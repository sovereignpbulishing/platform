# IAB Content Taxonomy Mapper

## Purpose

The platform should support IAB Tech Lab Content Taxonomy as an external taxonomy source for advertising, brand safety, content classification, audience packaging, and marketplace interoperability.

IAB taxonomy should be mapped into the platform's multidimensional taxonomy model. It must not replace the canonical platform taxonomy.

## Important rule

IAB taxonomy is an external taxonomy vocabulary.

The platform taxonomy remains canonical and may include:

- schema.org types
- editorial categories
- tags
- content type
- audience type
- geography
- location
- language
- authority
- trust
- rights
- sponsor
- event
- device
- commercial package

## Mapper flow

```text
External Taxonomy Term
  -> Mapping Candidate
  -> Confidence Score
  -> Human Review if needed
  -> Approved Mapping
  -> Taxonomy Relationship
  -> Audit Record
```

## Supported source taxonomies

Initial sources:

- IAB Content Taxonomy
- schema.org
- internal publication taxonomy
- tenant taxonomy
- editorial taxonomy
- advertising taxonomy
- commerce taxonomy

Future sources:

- IPTC Media Topics
- Wikidata
- Library of Congress vocabularies
- domain-specific scientific vocabularies

## Mapping types

- exact match
- close match
- broader match
- narrower match
- related match
- no match
- deprecated match

## Required mapping metadata

Every mapping must include:

- source taxonomy id
- source taxonomy version
- source term id
- source term label
- target taxonomy id
- target term id
- mapping type
- confidence score
- review status
- reviewer
- approved at
- audit event id

## Advertising and monetization use

IAB taxonomy mapping may support:

- brand suitability
- contextual advertising
- content packaging
- sponsorship targeting
- marketplace listings
- deal metadata
- content monetization

## Governance rules

1. A machine mapping below confidence threshold requires human review.
2. Sensitive categories require explicit policy approval.
3. Mapping changes must be audit logged.
4. IAB-mapped advertising categories must not override editorial taxonomy.
5. Reader privacy must not be weakened by taxonomy mapping.
6. Tenant-specific overrides must remain tenant-scoped.
7. Taxonomy version must be stored with every classification.

## Non-goals

- Do not make IAB the only taxonomy.
- Do not use advertising taxonomy as editorial truth.
- Do not infer sensitive audience attributes without consent and policy approval.
- Do not hard-code one advertising ecosystem into the core platform.
