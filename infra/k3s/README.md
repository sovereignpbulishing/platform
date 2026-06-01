# k3s Deployment

## Purpose

This directory provides a lightweight single-node k3s deployment baseline for the Sovereign Publishing Platform.

It is intended for local labs, sovereign VPS deployments, demos, and early production hardening.

## Apply

```bash
kubectl apply -k infra/k3s
```

## Components

- `sovereign-publishing` namespace
- API deployment and service
- SurrealDB deployment, service, and persistent volume claim
- ConfigMap for API runtime configuration
- Ingress placeholder for k3s Traefik or any ingress controller

## Assumptions

- k3s is already installed.
- A default storage class exists.
- An ingress controller is available, such as the default k3s Traefik controller.
- Real secrets are not committed to Git.

## Production hardening still required

- Replace demo SurrealDB credentials with Kubernetes secrets.
- Add TLS through cert-manager or existing ingress TLS.
- Add NetworkPolicies.
- Add backup and restore automation.
- Add image signing and admission checks.
- Replace mutable image tags with immutable digests.
- Add observability, metrics, logs, and alerts.
