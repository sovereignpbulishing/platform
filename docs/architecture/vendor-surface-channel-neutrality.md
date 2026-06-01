# Vendor, Surface, and Channel Neutrality

## Principle

The platform must be vendor neutral, publishing surface neutral, and distribution channel neutral.

No core platform concept should depend on a specific cloud, CDN, CMS, social network, search engine, device, app framework, payment provider, AI provider, identity provider, analytics vendor, or publishing surface.

## Vendor neutrality

The platform should use provider-neutral contracts and adapters.

Examples:

- Cloud: any Kubernetes-compatible environment
- Storage: any S3-compatible object storage
- CDN: any CDN or self-hosted edge gateway
- Identity: OIDC-compatible providers
- Policy: OPA-compatible policy decisions
- Authorization: OpenFGA/AuthZEN-compatible authorization layer
- AI: model-router abstraction, not provider lock-in
- Analytics: privacy-centric event contract, not vendor-specific tracking
- Payments: commerce protocol abstraction, not single payment processor

## Publishing surface neutrality

A CreativeWork must not be tied to one display surface.

Supported surfaces include:

- website
- mobile web
- native mobile
- newsletter
- RSS or Atom feed
- ActivityPub
- API
- MCP resource
- search index
- agent index
- marketplace listing
- journal issue
- book package
- PDF
- EPUB
- kiosk
- signage
- IoT display
- AR scene
- VR scene
- voice interface

The canonical work stays in the platform. Each surface receives a rendered, transformed, or packaged projection.

## Distribution channel neutrality

Distribution should be channel-adapter based.

Supported channels include:

- first-party website
- global CDN
- regional edge
- feed readers
- newsletters
- social networks
- search engines
- agent engines
- citation indexes
- DOI or metadata registries
- marketplaces
- syndication partners
- webhooks
- APIs
- offline bundles
- AR/VR delivery surfaces

No channel is canonical. The canonical record remains the governed CreativeWork and its versioned artifact record.

## Adapter contract

Every adapter must declare:

- adapter id
- adapter type
- publisher
- version
- license
- supported protocols
- supported surfaces
- supported channels
- required permissions
- data shared
- privacy posture
- retry behavior
- revocation behavior
- audit events
- trust score

## Neutral publishing flow

```text
CreativeWork
  -> Artifact
  -> Validation
  -> PublishingDecision
  -> ChannelAdapter
  -> DistributionReceipt
  -> Trace
```

## Rules

1. Canonical content must not live only inside a vendor-specific system.
2. Vendor-specific identifiers must be secondary identifiers.
3. Every channel publish must create a distribution receipt.
4. Every rendered surface must preserve license, attribution, AI disclosure, source verification, and responsibility metadata.
5. Every adapter must be replaceable.
6. Every channel must support correction and retraction propagation where technically possible.
7. Every vendor integration must declare data sharing and privacy impact.

## Non-goals

- Do not hard-code one CDN.
- Do not hard-code one social network.
- Do not hard-code one cloud.
- Do not make one web framework the canonical content model.
- Do not make one payment provider the commerce model.
- Do not make one search engine the discovery model.
- Do not make one AI provider the intelligence layer.

## Outcome

The platform remains sovereign because content, governance, identity, policy, trust, and provenance remain platform-native while vendors, surfaces, and channels are replaceable adapters.
