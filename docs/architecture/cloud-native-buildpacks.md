# Cloud Native Buildpacks

## Purpose

Cloud Native Buildpacks provide a vendor-neutral way to transform application source code into runnable OCI images without requiring every app, plugin, worker, or service to maintain a custom Dockerfile.

Buildpacks fit the platform because the platform already treats every deployable unit as a governed artifact.

## Platform role

Buildpacks are used for source-to-image packaging of:

- platform API services
- publishing workers
- validation workers
- registry services
- MCP servers
- extension services
- plugin services
- adapter services
- tenant-specific publishing apps

## Why Buildpacks

- OCI image output
- reproducible builds
- build metadata
- SBOM support
- fewer custom Dockerfiles
- language/runtime detection
- Kubernetes-native deployment compatibility
- GitOps-friendly image promotion
- cloud and vendor neutrality

## Artifact model alignment

```text
Source Artifact
  -> Buildpack Build
  -> OCI Image Artifact
  -> Signature
  -> Validation
  -> PublishingDecision
  -> GitOps Deployment
```

## Governance requirements

Every buildpack-produced image must preserve:

- source revision
- buildpack id and version
- builder image reference
- build timestamp
- image digest
- SBOM reference
- provenance metadata
- vulnerability scan result
- signature status
- policy decision id

## Executable artifact checks

Buildpack-built images are executable artifacts and must pass the executable profile of the Universal Artifact Publishing Protocol.

Required gates:

- SBOM present
- provenance attestation present
- vulnerability scan passed or risk accepted
- secret scan passed
- dependency license check passed
- image digest recorded
- image signed before deployment
- runtime policy declared
- rollback plan present

## GitOps flow

```text
Git Commit
  -> GitHub Actions
  -> Buildpacks package
  -> SBOM and provenance
  -> Scan
  -> Sign
  -> Push OCI image
  -> Update GitOps image reference
  -> Flux reconcile
```

## Neutrality rule

Buildpacks are a packaging interface, not the platform's only packaging interface.

The platform may also support Dockerfiles, Nix, Bazel, ko, WASM components, or prebuilt OCI images as long as each artifact passes the same validation and trust gates.
