-- Discovery domain schema
-- Channels, collections, follows, bookmarks, saved searches, trends, and recommendations.

DEFINE TABLE channel SCHEMAFULL;
DEFINE FIELD tenant ON channel TYPE record<tenant>;
DEFINE FIELD publication ON channel TYPE option<record<publication>>;
DEFINE FIELD name ON channel TYPE string ASSERT string::len($value) > 0;
DEFINE FIELD slug ON channel TYPE string ASSERT string::len($value) > 0;
DEFINE FIELD channel_type ON channel TYPE string DEFAULT 'topic';
DEFINE FIELD description ON channel TYPE option<string>;
DEFINE FIELD taxonomy_terms ON channel TYPE array<record<taxonomy_term>> DEFAULT [];
DEFINE FIELD language ON channel TYPE option<string>;
DEFINE FIELD geography ON channel TYPE option<string>;
DEFINE FIELD target_audience ON channel TYPE option<string>;
DEFINE FIELD status ON channel TYPE string DEFAULT 'active';
DEFINE FIELD created_at ON channel TYPE datetime DEFAULT time::now();
DEFINE FIELD updated_at ON channel TYPE datetime VALUE time::now();
DEFINE INDEX channel_slug ON channel COLUMNS tenant, slug UNIQUE;
DEFINE INDEX channel_type_status ON channel COLUMNS tenant, channel_type, status;

DEFINE TABLE collection SCHEMAFULL;
DEFINE FIELD tenant ON collection TYPE record<tenant>;
DEFINE FIELD publication ON collection TYPE option<record<publication>>;
DEFINE FIELD title ON collection TYPE string ASSERT string::len($value) > 0;
DEFINE FIELD slug ON collection TYPE string ASSERT string::len($value) > 0;
DEFINE FIELD collection_type ON collection TYPE string DEFAULT 'curated';
DEFINE FIELD description ON collection TYPE option<string>;
DEFINE FIELD owner ON collection TYPE option<record<identity>>;
DEFINE FIELD status ON collection TYPE string DEFAULT 'draft';
DEFINE FIELD public ON collection TYPE bool DEFAULT false;
DEFINE FIELD created_at ON collection TYPE datetime DEFAULT time::now();
DEFINE FIELD updated_at ON collection TYPE datetime VALUE time::now();
DEFINE INDEX collection_slug ON collection COLUMNS tenant, slug UNIQUE;

DEFINE TABLE collection_item SCHEMAFULL;
DEFINE FIELD tenant ON collection_item TYPE record<tenant>;
DEFINE FIELD collection ON collection_item TYPE record<collection>;
DEFINE FIELD subject_id ON collection_item TYPE string;
DEFINE FIELD subject_type ON collection_item TYPE string;
DEFINE FIELD sort_order ON collection_item TYPE int DEFAULT 0;
DEFINE FIELD added_by ON collection_item TYPE option<record<identity>>;
DEFINE FIELD added_at ON collection_item TYPE datetime DEFAULT time::now();
DEFINE INDEX collection_item_lookup ON collection_item COLUMNS collection, subject_id, subject_type UNIQUE;

DEFINE TABLE follow SCHEMAFULL;
DEFINE FIELD tenant ON follow TYPE record<tenant>;
DEFINE FIELD identity ON follow TYPE record<identity>;
DEFINE FIELD subject_id ON follow TYPE string;
DEFINE FIELD subject_type ON follow TYPE string;
DEFINE FIELD status ON follow TYPE string DEFAULT 'active';
DEFINE FIELD created_at ON follow TYPE datetime DEFAULT time::now();
DEFINE INDEX follow_unique ON follow COLUMNS tenant, identity, subject_id, subject_type UNIQUE;

DEFINE TABLE bookmark SCHEMAFULL;
DEFINE FIELD tenant ON bookmark TYPE record<tenant>;
DEFINE FIELD identity ON bookmark TYPE record<identity>;
DEFINE FIELD work ON bookmark TYPE record<creative_work>;
DEFINE FIELD note ON bookmark TYPE option<string>;
DEFINE FIELD status ON bookmark TYPE string DEFAULT 'active';
DEFINE FIELD created_at ON bookmark TYPE datetime DEFAULT time::now();
DEFINE INDEX bookmark_unique ON bookmark COLUMNS tenant, identity, work UNIQUE;

DEFINE TABLE saved_search SCHEMAFULL;
DEFINE FIELD tenant ON saved_search TYPE record<tenant>;
DEFINE FIELD identity ON saved_search TYPE record<identity>;
DEFINE FIELD name ON saved_search TYPE string;
DEFINE FIELD query ON saved_search TYPE option<string>;
DEFINE FIELD filters ON saved_search TYPE object DEFAULT {};
DEFINE FIELD notify ON saved_search TYPE bool DEFAULT false;
DEFINE FIELD status ON saved_search TYPE string DEFAULT 'active';
DEFINE FIELD created_at ON saved_search TYPE datetime DEFAULT time::now();
DEFINE FIELD updated_at ON saved_search TYPE datetime VALUE time::now();
DEFINE INDEX saved_search_identity ON saved_search COLUMNS tenant, identity, status;

DEFINE TABLE trend SCHEMAFULL;
DEFINE FIELD tenant ON trend TYPE record<tenant>;
DEFINE FIELD subject_id ON trend TYPE string;
DEFINE FIELD subject_type ON trend TYPE string;
DEFINE FIELD scope ON trend TYPE object DEFAULT {};
DEFINE FIELD time_window ON trend TYPE string DEFAULT 'day';
DEFINE FIELD score ON trend TYPE number DEFAULT 0;
DEFINE FIELD rank ON trend TYPE option<int>;
DEFINE FIELD calculated_at ON trend TYPE datetime DEFAULT time::now();
DEFINE INDEX trend_scope_window ON trend COLUMNS tenant, subject_type, time_window, score;

DEFINE TABLE trend_signal SCHEMAFULL;
DEFINE FIELD tenant ON trend_signal TYPE record<tenant>;
DEFINE FIELD subject_id ON trend_signal TYPE string;
DEFINE FIELD subject_type ON trend_signal TYPE string;
DEFINE FIELD signal_type ON trend_signal TYPE string;
DEFINE FIELD weight ON trend_signal TYPE number DEFAULT 1;
DEFINE FIELD value ON trend_signal TYPE number DEFAULT 1;
DEFINE FIELD privacy_level ON trend_signal TYPE string DEFAULT 'anonymous';
DEFINE FIELD occurred_at ON trend_signal TYPE datetime DEFAULT time::now();
DEFINE INDEX trend_signal_subject ON trend_signal COLUMNS tenant, subject_id, signal_type;

DEFINE TABLE recommendation SCHEMAFULL;
DEFINE FIELD tenant ON recommendation TYPE record<tenant>;
DEFINE FIELD identity ON recommendation TYPE option<record<identity>>;
DEFINE FIELD subject_id ON recommendation TYPE string;
DEFINE FIELD subject_type ON recommendation TYPE string;
DEFINE FIELD recommended_id ON recommendation TYPE string;
DEFINE FIELD recommended_type ON recommendation TYPE string;
DEFINE FIELD reason ON recommendation TYPE option<string>;
DEFINE FIELD score ON recommendation TYPE number DEFAULT 0;
DEFINE FIELD policy_decision ON recommendation TYPE option<record<decision>>;
DEFINE FIELD created_at ON recommendation TYPE datetime DEFAULT time::now();
DEFINE FIELD expires_at ON recommendation TYPE option<datetime>;
DEFINE INDEX recommendation_identity ON recommendation COLUMNS tenant, identity, score;
DEFINE INDEX recommendation_subject ON recommendation COLUMNS tenant, subject_id, recommended_id;
