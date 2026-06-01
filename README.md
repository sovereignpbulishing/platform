# Sovereign Publishing Platform

AI-native, cloud-native, single-node Kubernetes-native publishing platform for independent, authoritative opinions and all schema.org CreativeWork types.

## Mission

Publishing for everyone: authors, researchers, institutions, communities, civic groups, studios, newsletters, and independent experts should be able to publish trustworthy work with provenance, consent, auditability, privacy controls, and open web interoperability.

## Principles

- AI-native, but human-accountable.
- Cloud-native, but single-node operable.
- Kubernetes-native, but simple enough for a sovereign VPS.
- Database-native: content, workflow, policy, audit, graph links, and publication state are first-class records.
- GitOps-first: desired state lives in Git and is reconciled into the cluster.
- Schema.org-first: every publication is modeled as CreativeWork or a subtype.
- Privacy by design: tenant isolation, consent, audit trails, minimal PII, and explicit publication boundaries.
- Open standards over proprietary publishing silos.

## Scope

The platform supports schema.org CreativeWork types such as Article, BlogPosting, NewsArticle, ScholarlyArticle, Report, Book, Review, ClaimReview, Dataset, SoftwareSourceCode, PodcastEpisode, VideoObject, AudioObject, ImageObject, Course, HowTo, FAQPage, WebPage, and CreativeWorkSeries.

## Repository layout

- apps/web: publishing UI, reader experience, admin console
- apps/worker: AI, validation, publishing, indexing workers
- packages/schema: schema.org contracts and validators
- packages/policy: privacy and authorization contracts
- packages/db: database schema and migrations
- infra/kubernetes: Kubernetes manifests
- infra/gitops/flux: Flux GitOps baseline
- docs: architecture, compliance, runbooks, ADRs

## Status

Foundation scaffold added. Production readiness requires passing the validation gates in docs/runbooks/production-readiness-gates.md.
