# Lightweight Multi-Tenant Multi-Model Spatial-Temporal Kubernetes Core

## Principle

The platform core must be lightweight, multi-tenant, multi-model, spatial-temporal, open-source-first, cloud-native, Kubernetes-native, vendor-neutral, cloud-agnostic, publishing-surface-neutral, and distribution-channel-neutral.

A vendor product may be supported through an adapter, but no vendor product should define the core platform model.

## Core rule

```text
Open contract first.
Open standard second.
Open-source default third.
Lightweight Kubernetes-native implementation fourth.
Vendor adapter last.
```

## Multi-tenancy rule

Multi-tenancy is core.

Every canonical object must be tenant-scoped unless explicitly public or platform-scoped.

Tenant isolation applies to identity, publications, journals, CreativeWorks, drafts, assets, workflows, policies, trust scores, analytics, commerce records, registry entries, distribution receipts, and audit records.

Default isolation is lightweight shared infrastructure with strict logical tenant isolation. Stronger isolation can use namespace-per-tenant, database-scope-per-tenant, or dedicated cluster-per-tenant.

## Multi-model rule

Multi-model is core as an abstraction.

No model provider is canonical. The platform should route to local, open-source, hosted, domain-specific, multimodal, embedding, ranking, translation, speech, vision, and safety models through a neutral model invocation contract.

Every model call must record tenant, purpose, model id, model version, provider or runtime, prompt policy, output policy, cost metadata when available, trust score, and audit trace where required.

## Spatial-temporal rule

Space and time are first-class primitives.

Every relevant artifact, projection, route, policy, distribution decision, analytics event, and publishing decision may carry spatial and temporal metadata.

Spatial metadata supports:

- country
- region
- city
- venue
- campus
- building
- room
- route
- geofence
- coordinates
- plus code
- spatial anchor
- AR or VR scene

Temporal metadata supports:

- created time
- modified time
- published time
- embargo window
- expiry window
- event window
- recurrence
- campaign window
- correction time
- retraction time
- cache validity

## Delivery rule

The platform should decide delivery using:

```text
content + audience + language + location + time + device + policy + trust + consent
```

The result is a projection and distribution receipt, not a mutation of the canonical CreativeWork.

## Lightweight rule

The reference stack must be single-node capable and avoid unnecessary moving parts.

Prefer fewer services, small containers, optional adapters, local-first development, shared control plane, and clear resource budgets.

Avoid making service mesh, heavy event platforms, multi-cluster systems, managed cloud-only services, vendor analytics suites, vendor AI platforms, or complex data platforms mandatory.

## Kubernetes-native rule

Use Kubernetes as the default execution and reconciliation substrate.

Core runtime capabilities should be represented as Kubernetes resources, workloads, services, jobs, config, policies, secrets, routes, and observable deployments.

## Cloud-native rule

Core capabilities should follow declarative configuration, containerized workloads, immutable artifacts, GitOps reconciliation, policy as code, service identity, least privilege, health checks, graceful recovery, observability by default, and portability across clouds and sovereign infrastructure.

## Canonical state rule

Canonical state belongs to platform contracts:

- Entity
- Artifact
- Relationship
- Policy
- Evidence
- Decision
- TrustScore
- SpatialContext
- TemporalContext
- Projection
- DistributionReceipt
- AuditRecord

Vendor state is only projection, cache, adapter state, or external receipt.
