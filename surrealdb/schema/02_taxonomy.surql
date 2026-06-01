-- Taxonomy domain schema
-- Versioned taxonomies, mappings, classifications, and admin review workflow.

DEFINE TABLE taxonomy SCHEMAFULL;
DEFINE FIELD tenant ON taxonomy TYPE option<record<tenant>>;
DEFINE FIELD name ON taxonomy TYPE string ASSERT string::len($value) > 0;
DEFINE FIELD taxonomy_type ON taxonomy TYPE string DEFAULT 'canonical';
DEFINE FIELD publisher ON taxonomy TYPE option<string>;
DEFINE FIELD uri ON taxonomy TYPE option<string>;
DEFINE FIELD status ON taxonomy TYPE string DEFAULT 'active';
DEFINE FIELD created_at ON taxonomy TYPE datetime DEFAULT time::now();
DEFINE FIELD updated_at ON taxonomy TYPE datetime VALUE time::now();
DEFINE INDEX taxonomy_name_unique ON taxonomy COLUMNS tenant, name UNIQUE;

DEFINE TABLE taxonomy_version SCHEMAFULL;
DEFINE FIELD taxonomy ON taxonomy_version TYPE record<taxonomy>;
DEFINE FIELD version ON taxonomy_version TYPE string ASSERT string::len($value) > 0;
DEFINE FIELD source_uri ON taxonomy_version TYPE option<string>;
DEFINE FIELD status ON taxonomy_version TYPE string DEFAULT 'draft';
DEFINE FIELD published_at ON taxonomy_version TYPE option<datetime>;
DEFINE FIELD created_at ON taxonomy_version TYPE datetime DEFAULT time::now();
DEFINE INDEX taxonomy_version_unique ON taxonomy_version COLUMNS taxonomy, version UNIQUE;

DEFINE TABLE taxonomy_mapping SCHEMAFULL;
DEFINE FIELD tenant ON taxonomy_mapping TYPE option<record<tenant>>;
DEFINE FIELD source_taxonomy ON taxonomy_mapping TYPE record<taxonomy>;
DEFINE FIELD source_version ON taxonomy_mapping TYPE record<taxonomy_version>;
DEFINE FIELD source_term ON taxonomy_mapping TYPE record<taxonomy_term>;
DEFINE FIELD target_taxonomy ON taxonomy_mapping TYPE record<taxonomy>;
DEFINE FIELD target_version ON taxonomy_mapping TYPE record<taxonomy_version>;
DEFINE FIELD target_term ON taxonomy_mapping TYPE record<taxonomy_term>;
DEFINE FIELD mapping_type ON taxonomy_mapping TYPE string DEFAULT 'related_match';
DEFINE FIELD confidence ON taxonomy_mapping TYPE number DEFAULT 0 ASSERT $value >= 0 AND $value <= 100;
DEFINE FIELD review_status ON taxonomy_mapping TYPE string DEFAULT 'machine_suggested';
DEFINE FIELD migration_action ON taxonomy_mapping TYPE string DEFAULT 'manual_review';
DEFINE FIELD admin_notes ON taxonomy_mapping TYPE option<string>;
DEFINE FIELD reviewer ON taxonomy_mapping TYPE option<record<identity>>;
DEFINE FIELD approved_at ON taxonomy_mapping TYPE option<datetime>;
DEFINE FIELD created_at ON taxonomy_mapping TYPE datetime DEFAULT time::now();
DEFINE FIELD updated_at ON taxonomy_mapping TYPE datetime VALUE time::now();
DEFINE INDEX taxonomy_mapping_lookup ON taxonomy_mapping COLUMNS source_taxonomy, source_version, source_term, target_taxonomy, target_version;

DEFINE TABLE classification SCHEMAFULL;
DEFINE FIELD tenant ON classification TYPE record<tenant>;
DEFINE FIELD subject_id ON classification TYPE string;
DEFINE FIELD subject_type ON classification TYPE string;
DEFINE FIELD taxonomy ON classification TYPE record<taxonomy>;
DEFINE FIELD taxonomy_version ON classification TYPE record<taxonomy_version>;
DEFINE FIELD term ON classification TYPE record<taxonomy_term>;
DEFINE FIELD axis ON classification TYPE string;
DEFINE FIELD confidence ON classification TYPE number DEFAULT 100 ASSERT $value >= 0 AND $value <= 100;
DEFINE FIELD source ON classification TYPE string DEFAULT 'manual';
DEFINE FIELD status ON classification TYPE string DEFAULT 'active';
DEFINE FIELD reviewer ON classification TYPE option<record<identity>>;
DEFINE FIELD evidence_refs ON classification TYPE array<string> DEFAULT [];
DEFINE FIELD created_at ON classification TYPE datetime DEFAULT time::now();
DEFINE FIELD updated_at ON classification TYPE datetime VALUE time::now();
DEFINE INDEX classification_subject ON classification COLUMNS tenant, subject_id, subject_type;
DEFINE INDEX classification_term ON classification COLUMNS tenant, taxonomy, taxonomy_version, term;

DEFINE TABLE taxonomy_mapping_job SCHEMAFULL;
DEFINE FIELD tenant ON taxonomy_mapping_job TYPE option<record<tenant>>;
DEFINE FIELD source_taxonomy ON taxonomy_mapping_job TYPE record<taxonomy>;
DEFINE FIELD source_version ON taxonomy_mapping_job TYPE record<taxonomy_version>;
DEFINE FIELD target_taxonomy ON taxonomy_mapping_job TYPE record<taxonomy>;
DEFINE FIELD target_version ON taxonomy_mapping_job TYPE record<taxonomy_version>;
DEFINE FIELD status ON taxonomy_mapping_job TYPE string DEFAULT 'draft';
DEFINE FIELD affected_works ON taxonomy_mapping_job TYPE int DEFAULT 0;
DEFINE FIELD affected_publications ON taxonomy_mapping_job TYPE int DEFAULT 0;
DEFINE FIELD affected_routes ON taxonomy_mapping_job TYPE int DEFAULT 0;
DEFINE FIELD reindex_required ON taxonomy_mapping_job TYPE bool DEFAULT false;
DEFINE FIELD created_by ON taxonomy_mapping_job TYPE option<record<identity>>;
DEFINE FIELD approved_by ON taxonomy_mapping_job TYPE option<record<identity>>;
DEFINE FIELD created_at ON taxonomy_mapping_job TYPE datetime DEFAULT time::now();
DEFINE FIELD approved_at ON taxonomy_mapping_job TYPE option<datetime>;
DEFINE INDEX taxonomy_mapping_job_versions ON taxonomy_mapping_job COLUMNS source_version, target_version;
