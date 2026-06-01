import { serve } from '@hono/node-server';
import { Hono } from 'hono';
import { cors } from 'hono/cors';
import { logger } from 'hono/logger';
import { nanoid } from 'nanoid';
import { z } from 'zod';

const app = new Hono();

app.use('*', logger());
app.use('*', cors());

type RecordMap<T> = Map<string, T>;

const db = {
  tenants: new Map<string, any>() as RecordMap<any>,
  publications: new Map<string, any>() as RecordMap<any>,
  works: new Map<string, any>() as RecordMap<any>,
  taxonomyTerms: new Map<string, any>() as RecordMap<any>,
  decisions: new Map<string, any>() as RecordMap<any>,
  trustScores: new Map<string, any>() as RecordMap<any>,
  events: new Map<string, any>() as RecordMap<any>,
};

const createTenantSchema = z.object({
  name: z.string().min(1),
  slug: z.string().min(1),
  plan: z.string().default('community'),
});

const createPublicationSchema = z.object({
  tenantId: z.string().min(1),
  name: z.string().min(1),
  publicationType: z.enum(['business', 'news', 'entertainment', 'journal', 'research', 'education', 'community', 'brand', 'personal', 'live_media']),
  language: z.string().default('en'),
});

const createWorkSchema = z.object({
  tenantId: z.string().min(1),
  publicationId: z.string().min(1),
  type: z.string().default('Article'),
  title: z.string().min(1),
  body: z.string().optional(),
  authorId: z.string().optional(),
  language: z.string().default('en'),
  license: z.string().default('UNSPECIFIED'),
  status: z.string().default('draft'),
});

const createTaxonomyTermSchema = z.object({
  tenantId: z.string().min(1),
  axis: z.string().min(1),
  label: z.string().min(1),
  slug: z.string().min(1),
  parentTermId: z.string().optional(),
});

function now() {
  return new Date().toISOString();
}

function emit(eventType: string, eventCategory: string, subject: Record<string, unknown>, tenantId: string, actorId = 'system') {
  const event = {
    eventId: `evt_${nanoid()}`,
    eventType,
    eventCategory,
    subject,
    tenantId,
    actorId,
    occurredAt: now(),
    protocol: { name: 'SovereignPublishingEvent', version: '0.1.0' },
  };
  db.events.set(event.eventId, event);
  return event;
}

function calculatePublishScore(work: any) {
  let score = 0;
  score += work.title ? 15 : 0;
  score += work.type ? 10 : 0;
  score += work.language ? 10 : 0;
  score += work.license && work.license !== 'UNSPECIFIED' ? 20 : 0;
  score += work.authorId ? 15 : 0;
  score += work.body ? 15 : 0;
  score += work.publicationId ? 15 : 0;
  return Math.min(score, 100);
}

app.get('/healthz', (c) => c.json({ status: 'ok', service: 'sovereign-publishing-api', time: now() }));

app.get('/v1/tenants', (c) => c.json({ items: [...db.tenants.values()] }));
app.post('/v1/tenants', async (c) => {
  const input = createTenantSchema.parse(await c.req.json());
  const tenant = { tenantId: `tenant_${nanoid()}`, ...input, createdAt: now(), updatedAt: now() };
  db.tenants.set(tenant.tenantId, tenant);
  emit('tenant.created', 'governance', { subjectId: tenant.tenantId, subjectType: 'tenant' }, tenant.tenantId);
  return c.json(tenant, 201);
});

app.get('/v1/publications', (c) => c.json({ items: [...db.publications.values()] }));
app.post('/v1/publications', async (c) => {
  const input = createPublicationSchema.parse(await c.req.json());
  const publication = { publicationId: `pub_${nanoid()}`, ...input, createdAt: now(), updatedAt: now() };
  db.publications.set(publication.publicationId, publication);
  emit('publication.created', 'publishing', { subjectId: publication.publicationId, subjectType: 'publication' }, publication.tenantId);
  return c.json(publication, 201);
});

app.get('/v1/works', (c) => c.json({ items: [...db.works.values()] }));
app.post('/v1/works', async (c) => {
  const input = createWorkSchema.parse(await c.req.json());
  const work = { workId: `work_${nanoid()}`, ...input, publishScore: 0, createdAt: now(), updatedAt: now() };
  work.publishScore = calculatePublishScore(work);
  db.works.set(work.workId, work);
  emit('draft.created', 'publishing', { subjectId: work.workId, subjectType: 'creative_work', version: '0.1.0' }, work.tenantId, work.authorId ?? 'system');
  return c.json(work, 201);
});

app.get('/v1/works/:id', (c) => {
  const work = db.works.get(c.req.param('id'));
  return work ? c.json(work) : c.json({ error: 'work not found' }, 404);
});

app.post('/v1/works/:id/publish-decision', (c) => {
  const work = db.works.get(c.req.param('id'));
  if (!work) return c.json({ error: 'work not found' }, 404);
  const publishScore = calculatePublishScore(work);
  const decision = publishScore >= 75 ? 'allow' : publishScore >= 60 ? 'require_review' : 'block';
  const record = {
    decisionId: `dec_${nanoid()}`,
    gate: 'publish_request',
    subject: { subjectId: work.workId, subjectType: 'creative_work', version: '0.1.0' },
    scores: { publishScore },
    outcome: { decision, decidedAt: now(), decidedBy: 'api.validation' },
    audit: { auditEventId: `audit_${nanoid()}`, retentionClass: 'standard' },
  };
  db.decisions.set(record.decisionId, record);
  emit(decision === 'allow' ? 'publish.approved' : 'publish.blocked', 'governance', { subjectId: work.workId, subjectType: 'creative_work' }, work.tenantId);
  return c.json(record, 201);
});

app.get('/v1/taxonomy/terms', (c) => c.json({ items: [...db.taxonomyTerms.values()] }));
app.post('/v1/taxonomy/terms', async (c) => {
  const input = createTaxonomyTermSchema.parse(await c.req.json());
  const term = { termId: `term_${nanoid()}`, ...input, createdAt: now(), updatedAt: now() };
  db.taxonomyTerms.set(term.termId, term);
  emit('taxonomy.term.created', 'discovery', { subjectId: term.termId, subjectType: 'taxonomy_term' }, term.tenantId);
  return c.json(term, 201);
});

app.get('/v1/trust/:entityId', (c) => {
  const entityId = c.req.param('entityId');
  const score = db.trustScores.get(entityId) ?? { entityId, trustScore: 50, status: 'unknown', calculatedAt: now() };
  return c.json(score);
});

app.get('/v1/decisions', (c) => c.json({ items: [...db.decisions.values()] }));
app.get('/v1/events', (c) => c.json({ items: [...db.events.values()] }));

app.notFound((c) => c.json({ error: 'not found' }, 404));
app.onError((error, c) => {
  console.error(error);
  return c.json({ error: 'internal_error', message: error.message }, 500);
});

const port = Number(process.env.PORT ?? 3000);
serve({ fetch: app.fetch, port });
console.log(`Sovereign Publishing API listening on :${port}`);
