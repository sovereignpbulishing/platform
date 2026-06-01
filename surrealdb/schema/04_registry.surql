-- Registry domain schema
-- Governed registry for templates, plugins, workflows, policies, schemas, agent blueprints, design assets, media packages, and releases.

DEFINE TABLE registry_package SCHEMAFULL;
DEFINE FIELD tenant ON registry_package TYPE option<record<tenant>>;
DEFINE FIELD name ON registry_package TYPE string ASSERT string::len($value) > 0;
DEFINE FIELD slug ON registry_package TYPE string ASSERT string::len($value) > 0;
DEFINE FIELD package_type ON registry_package TYPE string;
DEFINE FIELD description ON registry_package TYPE option<string>;
DEFINE FIELD publisher ON registry_package TYPE option<record<identity>>;
DEFINE FIELD maintainer ON registry_package TYPE option<record<identity>>;
DEFINE FIELD license ON registry_package TYPE string DEFAULT 'UNSPECIFIED';
DEFINE FIELD status ON registry_package TYPE string DEFAULT 'draft';
DEFINE FIELD public ON registry_package TYPE bool DEFAULT false;
DEFINE FIELD trust_score ON registry_package TYPE number DEFAULT 50;
DEFINE FIELD created_at ON registry_package TYPE datetime DEFAULT time::now();
DEFINE FIELD updated_at ON registry_package TYPE datetime VALUE time::now();
DEFINE INDEX registry_package_slug ON registry_package COLUMNS tenant, slug UNIQUE;
DEFINE INDEX registry_package_type_status ON registry_package COLUMNS tenant, package_type, status;

DEFINE TABLE registry_release SCHEMAFULL;
DEFINE FIELD tenant ON registry_release TYPE option<record<tenant>>;
DEFINE FIELD package ON registry_release TYPE record<registry_package>;
DEFINE FIELD version ON registry_release TYPE string ASSERT string::len($value) > 0;
DEFINE FIELD artifact ON registry_release TYPE option<record<artifact>>;
DEFINE FIELD artifact_uri ON registry_release TYPE option<string>;
DEFINE FIELD digest ON registry_release TYPE string;
DEFINE FIELD signature_status ON registry_release TYPE string DEFAULT 'missing';
DEFINE FIELD protocol_name ON registry_release TYPE string DEFAULT 'UniversalArtifactPublishingProtocol';
DEFINE FIELD protocol_version ON registry_release TYPE string DEFAULT '0.1.0';
DEFINE FIELD sbom_uri ON registry_release TYPE option<string>;
DEFINE FIELD provenance_uri ON registry_release TYPE option<string>;
DEFINE FIELD release_notes ON registry_release TYPE option<string>;
DEFINE FIELD status ON registry_release TYPE string DEFAULT 'draft';
DEFINE FIELD published_by ON registry_release TYPE option<record<identity>>;
DEFINE FIELD published_at ON registry_release TYPE option<datetime>;
DEFINE FIELD created_at ON registry_release TYPE datetime DEFAULT time::now();
DEFINE INDEX registry_release_version ON registry_release COLUMNS package, version UNIQUE;

DEFINE TABLE registry_signature SCHEMAFULL;
DEFINE FIELD tenant ON registry_signature TYPE option<record<tenant>>;
DEFINE FIELD release ON registry_signature TYPE record<registry_release>;
DEFINE FIELD signer ON registry_signature TYPE option<record<identity>>;
DEFINE FIELD signer_type ON registry_signature TYPE string DEFAULT 'publisher';
DEFINE FIELD signature_algorithm ON registry_signature TYPE string;
DEFINE FIELD signature ON registry_signature TYPE string;
DEFINE FIELD public_key_id ON registry_signature TYPE option<string>;
DEFINE FIELD status ON registry_signature TYPE string DEFAULT 'valid';
DEFINE FIELD signed_at ON registry_signature TYPE datetime DEFAULT time::now();
DEFINE FIELD expires_at ON registry_signature TYPE option<datetime>;
DEFINE INDEX registry_signature_release ON registry_signature COLUMNS release, signer_type;

DEFINE TABLE registry_dependency SCHEMAFULL;
DEFINE FIELD tenant ON registry_dependency TYPE option<record<tenant>>;
DEFINE FIELD package ON registry_dependency TYPE record<registry_package>;
DEFINE FIELD release ON registry_dependency TYPE option<record<registry_release>>;
DEFINE FIELD dependency_name ON registry_dependency TYPE string;
DEFINE FIELD dependency_type ON registry_dependency TYPE string;
DEFINE FIELD version_constraint ON registry_dependency TYPE option<string>;
DEFINE FIELD required ON registry_dependency TYPE bool DEFAULT true;
DEFINE FIELD license ON registry_dependency TYPE option<string>;
DEFINE FIELD trust_score ON registry_dependency TYPE option<number>;
DEFINE FIELD created_at ON registry_dependency TYPE datetime DEFAULT time::now();
DEFINE INDEX registry_dependency_package ON registry_dependency COLUMNS package, dependency_name;

DEFINE TABLE registry_channel SCHEMAFULL;
DEFINE FIELD tenant ON registry_channel TYPE option<record<tenant>>;
DEFINE FIELD name ON registry_channel TYPE string;
DEFINE FIELD channel_type ON registry_channel TYPE string DEFAULT 'stable';
DEFINE FIELD description ON registry_channel TYPE option<string>;
DEFINE FIELD public ON registry_channel TYPE bool DEFAULT false;
DEFINE FIELD created_at ON registry_channel TYPE datetime DEFAULT time::now();
DEFINE INDEX registry_channel_name ON registry_channel COLUMNS tenant, name UNIQUE;

DEFINE TABLE registry_channel_release SCHEMAFULL;
DEFINE FIELD tenant ON registry_channel_release TYPE option<record<tenant>>;
DEFINE FIELD channel ON registry_channel_release TYPE record<registry_channel>;
DEFINE FIELD release ON registry_channel_release TYPE record<registry_release>;
DEFINE FIELD promoted_by ON registry_channel_release TYPE option<record<identity>>;
DEFINE FIELD promoted_at ON registry_channel_release TYPE datetime DEFAULT time::now();
DEFINE FIELD status ON registry_channel_release TYPE string DEFAULT 'active';
DEFINE INDEX registry_channel_release_unique ON registry_channel_release COLUMNS channel, release UNIQUE;

DEFINE TABLE registry_installation SCHEMAFULL;
DEFINE FIELD tenant ON registry_installation TYPE record<tenant>;
DEFINE FIELD package ON registry_installation TYPE record<registry_package>;
DEFINE FIELD release ON registry_installation TYPE record<registry_release>;
DEFINE FIELD installed_by ON registry_installation TYPE option<record<identity>>;
DEFINE FIELD target_resource_id ON registry_installation TYPE option<string>;
DEFINE FIELD target_resource_type ON registry_installation TYPE option<string>;
DEFINE FIELD status ON registry_installation TYPE string DEFAULT 'installed';
DEFINE FIELD installed_at ON registry_installation TYPE datetime DEFAULT time::now();
DEFINE FIELD updated_at ON registry_installation TYPE datetime VALUE time::now();
DEFINE INDEX registry_installation_lookup ON registry_installation COLUMNS tenant, package, target_resource_id;
