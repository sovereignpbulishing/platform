# GitOps Operating Model

## Principle

Git is the desired-state source of truth for platform infrastructure, application deployment, policies, registry configuration, and publishing control-plane configuration.

The platform remains vendor neutral, cloud agnostic, Kubernetes native, and single-node capable.

## Default GitOps engine

Flux is the default GitOps engine.

The platform should also remain portable to other GitOps controllers through neutral Kubernetes manifests and Kustomize overlays.

## Repository layout

```text
infra/gitops/
  clusters/
    single-node/
      flux-system/
      platform/
      policies/
      observability/
  apps/
    platform-api/
    platform-web/
    validation-worker/
    publishing-worker/
    registry/
  components/
    namespace/
    config/
    secrets-template/
    network-policy/
  policies/
    kyverno/
    opa/
```

## GitOps responsibilities

- reconcile namespaces
- deploy platform services
- apply policy controls
- configure observability
- configure ingress and routing
- mount secret references
- deploy validation workers
- deploy publishing workers
- deploy registry services
- reconcile route and distribution adapters

## Rules

1. Do not commit real secrets.
2. All deployable artifacts must be signed or traceable.
3. All platform changes must pass validation before reconciliation.
4. All executable artifacts require additional supply-chain checks.
5. Policy changes must be auditable.
6. Separation of duty must be enforced before publish approval.
7. GitOps reconciliation must not bypass publishing decisions.

## Environments

Initial target:

- single-node Kubernetes
- k3s, Talos, MicroK8s, or kubeadm
- one cluster
- multiple namespaces
- GitOps-managed desired state

Future target:

- regional clusters
- edge clusters
- tenant-specific clusters
- sovereign jurisdictional clusters

## Deployment flow

```text
Git Commit
  -> CI Validation
  -> Artifact Trust Gate
  -> Policy Gate
  -> Flux Reconciliation
  -> Kubernetes Deployment
  -> Observability
  -> Audit
```
