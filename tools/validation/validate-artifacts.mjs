import { readdir, readFile, writeFile, mkdir } from 'node:fs/promises';
import { join, extname } from 'node:path';

const root = process.argv[2] ?? 'examples/artifacts';
const reportDir = 'reports';
const reportPath = join(reportDir, 'artifact-validation-report.json');

const COMMON_CHECKS = [
  'schema_valid',
  'metadata_complete',
  'license_present',
  'attribution_complete',
  'provenance_present',
  'content_hash_present',
  'signature_valid',
  'publisher_identity_verified',
  'publisher_trust_score_met',
  'protocol_version_recorded',
  'policy_decision_recorded',
  'audit_event_recorded'
];

const EXECUTABLE_CHECKS = [
  'sbom_present',
  'slsa_level_recorded',
  'vulnerability_scan_passed',
  'malware_scan_passed',
  'secret_scan_passed',
  'dependency_license_check_passed',
  'provenance_attestation_valid',
  'sandbox_required',
  'permission_review_passed',
  'runtime_policy_defined',
  'least_privilege_verified',
  'rollback_plan_present'
];

async function walk(dir) {
  const entries = await readdir(dir, { withFileTypes: true }).catch(() => []);
  const files = [];
  for (const entry of entries) {
    const path = join(dir, entry.name);
    if (entry.isDirectory()) files.push(...await walk(path));
    if (entry.isFile() && extname(entry.name) === '.json') files.push(path);
  }
  return files;
}

function check(condition, name, message) {
  return { checkName: name, status: condition ? 'pass' : 'fail', message };
}

function scoreOf(value, fallback = 0) {
  return typeof value === 'number' ? value : fallback;
}

function validateArtifact(file, artifact) {
  const checks = [];
  const protocol = artifact.protocol ?? {};
  const publisher = artifact.publisher ?? {};
  const item = artifact.artifact ?? {};
  const decision = artifact.decision ?? {};
  const common = artifact.checks?.commonChecks ?? [];
  const executable = artifact.checks?.executableChecks ?? [];

  checks.push(check(protocol.name === 'UniversalArtifactPublishingProtocol', 'schema_valid', 'protocol.name must be UniversalArtifactPublishingProtocol'));
  checks.push(check(Boolean(protocol.version), 'protocol_version_recorded', 'protocol.version is required'));
  checks.push(check(Boolean(item.artifactId && item.artifactType && item.version), 'metadata_complete', 'artifact id, type, and version are required'));
  checks.push(check(Boolean(item.hash), 'content_hash_present', 'artifact.hash is required'));
  checks.push(check(Boolean(publisher.publisherId), 'publisher_identity_verified', 'publisher.publisherId is required'));
  checks.push(check(scoreOf(publisher.trustScore) >= 70, 'publisher_trust_score_met', 'publisher trust score must be at least 70'));
  checks.push(check(Boolean(decision.result), 'policy_decision_recorded', 'decision.result is required'));

  for (const required of COMMON_CHECKS) {
    checks.push(check(common.includes(required), required, `common check ${required} must be declared`));
  }

  if (item.isExecutable === true) {
    for (const required of EXECUTABLE_CHECKS) {
      checks.push(check(executable.includes(required), required, `executable check ${required} must be declared`));
    }
  }

  const failures = checks.filter((entry) => entry.status === 'fail');
  const warnings = [];
  const result = failures.length > 0 ? 'block' : 'allow';

  return {
    file,
    artifactId: item.artifactId ?? null,
    artifactType: item.artifactType ?? null,
    isExecutable: item.isExecutable === true,
    result,
    checks,
    failures,
    warnings
  };
}

const files = await walk(root);
const results = [];

for (const file of files) {
  try {
    const artifact = JSON.parse(await readFile(file, 'utf8'));
    results.push(validateArtifact(file, artifact));
  } catch (error) {
    results.push({ file, result: 'block', failures: [{ checkName: 'json_parse', status: 'fail', message: error.message }], checks: [], warnings: [] });
  }
}

const summary = {
  validatedAt: new Date().toISOString(),
  root,
  total: results.length,
  allowed: results.filter((r) => r.result === 'allow').length,
  blocked: results.filter((r) => r.result === 'block').length
};

await mkdir(reportDir, { recursive: true });
await writeFile(reportPath, JSON.stringify({ summary, results }, null, 2));

console.log(JSON.stringify(summary, null, 2));

if (summary.blocked > 0) {
  console.error(`Artifact validation blocked ${summary.blocked} artifact(s). See ${reportPath}.`);
  process.exit(1);
}
