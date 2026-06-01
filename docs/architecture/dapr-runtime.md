# Dapr Runtime Architecture

## Purpose

Dapr is a vendor-neutral distributed application runtime for platform services, workers, agents, adapters, and publishing workflows.

The platform uses Dapr as an optional runtime layer for cloud-agnostic building blocks while preserving Kubernetes-native deployment, GitOps reconciliation, and protocol-neutral architecture.

## Where Dapr fits

Dapr supports these platform capabilities:

- async publishing events
- publish and distribution workers
- source verification workers
- trust score calculation workers
- registry events
- commerce events
- analytics events
- extension and adapter calls
- service-to-service invocation
- state abstraction
- secret abstraction
- workflow orchestration
- actor-style long-running coordination

## Dapr building blocks

| Dapr building block | Platform use |
|---|---|
| Service invocation | call platform services without hard-coded network details |
| Pub/sub | publish, correction, retraction, indexing, distribution events |
| Bindings | connect to external systems through neutral adapters |
| State management | store worker state and idempotency records |
| Secrets | retrieve secrets through configured secret stores |
| Configuration | runtime configuration for services and adapters |
| Workflow | durable publishing, review, distribution, and registry workflows |
| Actors | per-work, per-tenant, or per-agent coordination where useful |
| Observability | traces, metrics, and logs through OpenTelemetry-compatible paths |

## Publishing event flow

```text
PublishingDecision
  -> publish.approved event
  -> edge bundle worker
  -> distribution worker
  -> search indexing worker
  -> agent indexing worker
  -> analytics trace
  -> distribution receipt
```

## Recommended topics

- publishing.requested
- publishing.approved
- publishing.blocked
- publishing.published
- publishing.corrected
- publishing.retracted
- distribution.requested
- distribution.delivered
- distribution.failed
- registry.package.published
- registry.package.revoked
- trust.score.updated
- source.verification.completed
- commerce.offer.created
- commerce.payment.completed

## Runtime neutrality

Dapr is not the only supported runtime.

The platform must continue to support direct Kubernetes services, native queues, serverless workers, or other runtimes as long as they implement the same event, policy, validation, trust, and audit contracts.

## GitOps model

Dapr components are declared in Git and reconciled into Kubernetes.

```text
infra/gitops/components/dapr/
  pubsub.yaml
  state.yaml
  secretstore.yaml
  configuration.yaml
```

Do not commit real secrets.

## Security requirements

- enable mTLS where available
- use least privilege service identities
- scope pub/sub topics by tenant or environment where needed
- log policy decisions
- link events to PublishingDecision and audit records
- protect private drafts, embargoed works, and paid content
- do not bypass validation gates through direct worker calls

## Platform rule

Dapr is a runtime adapter layer, not the canonical platform model.

Canonical state remains in platform records: Artifact, Decision, Policy, Evidence, TrustScore, Projection, DistributionReceipt, AuditRecord, and Relationship.
