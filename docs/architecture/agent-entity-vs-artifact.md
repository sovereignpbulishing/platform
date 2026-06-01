# Agent Entity vs Agent Artifact

## Principle

An agent is an application/runtime entity.

An agent blueprint, manifest, package, policy, workflow, model output, or release bundle is an artifact.

This distinction is mandatory for the platform model.

## Correct model

```text
AgentApplication
  runtime identity
  lifecycle
  permissions
  memory
  tools
  policies
  accountability
  telemetry

AgentBlueprintArtifact
  design specification
  version
  manifest
  hash
  signature
  license
  provenance
  validation profile
```

## Relationship

```text
AgentBlueprintArtifact
    defines
      ↓
AgentApplication
    runs as
      ↓
RuntimeInstance
```

## Publishing rule

The platform publishes agent artifacts, not the running agent itself.

Published agent artifacts include:

- agent blueprint
- agent manifest
- agent package
- agent policy bundle
- agent workflow
- MCP tool contract
- capability declaration
- release bundle

## Runtime rule

The platform operates agent applications as governed runtime entities.

Runtime agent entities require:

- identity
- accountable owner
- tenant scope
- permissions
- tool allowlist
- memory policy
- network policy
- sandbox policy
- runtime trust score
- kill switch
- telemetry
- audit trail

## Protocol correction

Universal Artifact Publishing Protocol applies to publishable artifacts.

Agent Publishing Protocol should be renamed or scoped as:

- Agent Blueprint Publishing Profile
- Agent Package Publishing Profile
- Agent Release Publishing Profile

The running agent application should be governed by an Agent Runtime Governance Protocol, not artifact publishing alone.

## Correct hierarchy

```text
Entity Model
  AgentApplication
  HumanUser
  Organization
  Publisher
  Author

Artifact Model
  CreativeWorkArtifact
  AgentBlueprintArtifact
  PluginArtifact
  TemplateArtifact
  WorkflowArtifact
  PolicyArtifact
  ContainerArtifact
```

## Validation impact

Agent blueprint artifacts pass UAPP artifact checks.

Agent applications pass runtime governance checks.

Executable agent packages pass both artifact publishing checks and executable supply-chain checks before deployment.
