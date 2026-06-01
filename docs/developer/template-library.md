# Template Library

## Purpose

The template library provides reusable publishing and product templates for tenants, publications, journals, communities, sponsors, and commercial creators.

Templates are governed artifacts. Each template must be versioned, licensed, credited, reviewed, and compatible with the platform design system.

## Template types

- Article template
- Blog post template
- Research preprint template
- Journal article template
- Peer review template
- Book template
- Chapter template
- Dataset landing page template
- Software project page template
- Author profile template
- Publisher profile template
- Sponsor disclosure template
- Newsletter template
- Landing page template
- Commerce offer template
- License page template
- Correction notice template
- Retraction notice template

## Required metadata

Every template must include:

- template id
- name
- description
- publisher
- license
- credit line
- version
- compatible schema.org type
- compatible UI kit version
- supported devices
- accessibility status
- localization status
- review status

## Template package structure

```text
template-name/
  template.json
  README.md
  preview.png
  schema.json
  blocks/
  assets/
  tests/
```

## Governance rules

- Templates must not embed hidden tracking.
- Templates must declare all external assets.
- Templates must include license metadata.
- Templates must pass accessibility review before registry publication.
- Sponsored templates must show sponsor disclosure.
- AI-generated template assets must include AI disclosure metadata.
