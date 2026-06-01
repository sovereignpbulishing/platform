# Streaming-First Microservices Core

## Principle

The platform should use a lightweight microservices architecture where each service owns a bounded capability and communicates through explicit APIs, events, and streams.

Streaming is the default pattern for long-running, real-time, agentic, validation, publishing, distribution, analytics, and collaboration workflows.

Microservices are an implementation architecture. They must not fragment the canonical platform model.

## Core rule

```text
Canonical record first.
Bounded service second.
Event third.
Stream fourth.
Projection fifth.
Transport last.
```

## Bounded services

Initial core services:

- identity-service
- tenant-service
- publishing-service
- validation-service
- policy-service
- trust-service
- registry-service
- distribution-service
- discovery-service
- analytics-service
- commerce-service
- audit-service
- search-service
- mcp-service

Optional services:

- journal-service
- translation-service
- source-verification-service
- agent-runtime-service
- design-registry-service
- notification-service

## Service ownership

Each service must declare:

- owned entities
- read models
- emitted events
- consumed events
- API routes
- MCP resources or tools where applicable
- policies enforced
- audit events emitted
- health checks
- OpenTelemetry spans

## Streaming use cases

Streaming should be supported for:

- AI-assisted drafting and editing
- agent responses
- source verification progress
- publish validation progress
- trust score calculation progress
- review and approval updates
- async publishing jobs
- distribution traces
- CDN and edge propagation updates
- search and indexing progress
- analytics event ingestion
- live comments and collaboration
- notifications
- long-running imports and exports
- registry package validation

## Stream categories

- user-facing progress stream
- agent response stream
- validation event stream
- publishing event stream
- distribution event stream
- analytics event stream
- audit event stream
- registry event stream
- commerce event stream
- system health stream

## Transport neutrality

Supported transports may include:

- Server-Sent Events
- WebSocket
- HTTP chunked response
- gRPC stream
- pub/sub
- message queue
- webhook delivery
- ActivityPub inbox/outbox
- feed polling
- offline sync queue

No transport is canonical.

## Kubernetes-native deployment

Each service should be deployable as a Kubernetes workload with:

- Deployment or Job
- Service
- ConfigMap
- Secret reference
- NetworkPolicy
- readiness and liveness probes
- resource requests and limits
- OpenTelemetry instrumentation
- policy checks

## GitOps rule

All service deployment, config, policy, and routing state should be declared in Git and reconciled into Kubernetes.

## Data rule

Canonical records remain in the platform data model:

- Entity
- Artifact
- Relationship
- Policy
- Evidence
- Decision
- TrustScore
- Projection
- DistributionReceipt
- AuditRecord

Streams, queues, and service caches are not canonical truth.

## Lightweight rule

Microservices must remain lightweight. Start with a small service set and split only when there is a clear ownership, scaling, security, or operational reason.

Avoid distributed complexity where a modular monolith would be simpler.

## Non-goals

- Do not create one service per table.
- Do not make event streams the source of truth.
- Do not bypass validation or policy through direct service calls.
- Do not require a specific queue, broker, mesh, or cloud provider.
- Do not make microservices mandatory for local development.
