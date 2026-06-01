# JS-Native and Browser-Native Core

## Principle

The platform should be JS-native and browser-native at the experience and extension layer while remaining vendor-neutral, framework-neutral, device-neutral, protocol-neutral, and transport-neutral.

Browser-native means the web platform is a first-class runtime, not merely a thin client.

## Core rule

```text
Web standards first.
Progressive enhancement second.
Framework adapter third.
Native app wrapper last.
```

## JS-native rule

JavaScript and TypeScript are the default languages for browser-facing platform modules, UI kit, design system components, MCP clients, SDKs, validation tooling, and extension development.

JS-native does not mean framework-locked.

Supported framework adapters may include React, Astro, Next.js, Svelte, Vue, Solid, Web Components, or vanilla TypeScript.

## Browser-native capabilities

The platform should use browser-native capabilities where appropriate:

- Service Worker
- Web App Manifest
- Cache API
- IndexedDB
- Background Sync
- Web Share
- Web Push with consent
- Clipboard API
- File System Access where supported
- Web Crypto
- WebAuthn
- Web Workers
- Shared Workers where useful
- BroadcastChannel
- WebSocket
- Server-Sent Events
- Web Components
- Custom Elements
- CSS Custom Properties
- Container Queries
- View Transitions where appropriate
- Media Session API
- Web Speech where appropriate
- WebXR where appropriate

## Progressive Web App rule

The platform should support PWA operation for authoring, reading, review, notifications, offline drafts, offline reading, and low-connectivity scenarios.

Offline actions must remain policy-bound and sync through validation gates before becoming canonical.

## Browser security rule

Browser-native features must preserve governance:

- no sensitive data in unencrypted offline storage unless tenant policy allows it
- no background sync without consent where required
- no push notifications without consent
- no location access without consent
- no cross-tenant browser storage leakage
- no service worker cache bypassing correction or retraction invalidation
- use Web Crypto for local integrity checks where appropriate
- use Content Security Policy for browser security

## Extension model

Browser-side extensions, widgets, templates, and UI plugins must be treated as executable artifacts.

They require:

- manifest
- version
- license
- signature
- permissions
- sandbox policy
- CSP compatibility
- trust score
- dependency review
- accessibility review

## Framework neutrality

The core design system should expose tokens, contracts, schemas, and component behavior independently from any one framework.

Framework-specific UI kits may be generated or maintained as adapters.

## Non-goals

- Do not require native mobile apps for core usage.
- Do not make one JS framework the platform ontology.
- Do not allow browser extensions or widgets to bypass publishing validation.
- Do not store canonical platform truth only in browser storage.
- Do not make PWA offline state canonical.

## Outcome

The platform becomes usable across browsers, mobile web, offline-capable PWAs, agent clients, APIs, and native wrappers while keeping canonical state, governance, trust, and publishing decisions in the platform control plane.
