-- Editorial workflow domain schema
-- Submission, assignment, review, approval, publish request, correction, and retraction records.

DEFINE TABLE submission SCHEMAFULL;
DEFINE FIELD tenant ON submission TYPE record<tenant>;
DEFINE FIELD work ON submission TYPE record<creative_work>;
DEFINE FIELD publication ON submission TYPE option<record<publication>>;
DEFINE FIELD submitted_by ON submission TYPE record<identity>;
DEFINE FIELD submission_type ON submission TYPE string DEFAULT 'article';
DEFINE FIELD status ON submission TYPE string DEFAULT 'submitted';
DEFINE FIELD message ON submission TYPE option<string>;
DEFINE FIELD submitted_at ON submission TYPE datetime DEFAULT time::now();
DEFINE FIELD updated_at ON submission TYPE datetime VALUE time::now();
DEFINE INDEX submission_work ON submission COLUMNS tenant, work;
DEFINE INDEX submission_status ON submission COLUMNS tenant, status;

DEFINE TABLE editorial_assignment SCHEMAFULL;
DEFINE FIELD tenant ON editorial_assignment TYPE record<tenant>;
DEFINE FIELD work ON editorial_assignment TYPE record<creative_work>;
DEFINE FIELD assigned_to ON editorial_assignment TYPE record<identity>;
DEFINE FIELD assigned_by ON editorial_assignment TYPE option<record<identity>>;
DEFINE FIELD role ON editorial_assignment TYPE string;
DEFINE FIELD status ON editorial_assignment TYPE string DEFAULT 'active';
DEFINE FIELD due_at ON editorial_assignment TYPE option<datetime>;
DEFINE FIELD assigned_at ON editorial_assignment TYPE datetime DEFAULT time::now();
DEFINE FIELD completed_at ON editorial_assignment TYPE option<datetime>;
DEFINE INDEX editorial_assignment_work_role ON editorial_assignment COLUMNS tenant, work, role;
DEFINE INDEX editorial_assignment_identity ON editorial_assignment COLUMNS tenant, assigned_to, status;

DEFINE TABLE review SCHEMAFULL;
DEFINE FIELD tenant ON review TYPE record<tenant>;
DEFINE FIELD work ON review TYPE record<creative_work>;
DEFINE FIELD reviewer ON review TYPE record<identity>;
DEFINE FIELD review_type ON review TYPE string DEFAULT 'editorial';
DEFINE FIELD status ON review TYPE string DEFAULT 'submitted';
DEFINE FIELD recommendation ON review TYPE string DEFAULT 'needs_revision';
DEFINE FIELD score ON review TYPE option<number>;
DEFINE FIELD comments ON review TYPE option<string>;
DEFINE FIELD evidence_refs ON review TYPE array<string> DEFAULT [];
DEFINE FIELD submitted_at ON review TYPE datetime DEFAULT time::now();
DEFINE FIELD updated_at ON review TYPE datetime VALUE time::now();
DEFINE INDEX review_work ON review COLUMNS tenant, work, review_type;
DEFINE INDEX review_reviewer ON review COLUMNS tenant, reviewer;

DEFINE TABLE approval SCHEMAFULL;
DEFINE FIELD tenant ON approval TYPE record<tenant>;
DEFINE FIELD work ON approval TYPE record<creative_work>;
DEFINE FIELD approver ON approval TYPE record<identity>;
DEFINE FIELD approval_type ON approval TYPE string DEFAULT 'publish';
DEFINE FIELD status ON approval TYPE string DEFAULT 'approved';
DEFINE FIELD decision ON approval TYPE option<record<decision>>;
DEFINE FIELD notes ON approval TYPE option<string>;
DEFINE FIELD approved_at ON approval TYPE datetime DEFAULT time::now();
DEFINE INDEX approval_work_type ON approval COLUMNS tenant, work, approval_type;
DEFINE INDEX approval_approver ON approval COLUMNS tenant, approver;

DEFINE TABLE publish_request SCHEMAFULL;
DEFINE FIELD tenant ON publish_request TYPE record<tenant>;
DEFINE FIELD work ON publish_request TYPE record<creative_work>;
DEFINE FIELD requested_by ON publish_request TYPE record<identity>;
DEFINE FIELD gate ON publish_request TYPE string DEFAULT 'publish_request';
DEFINE FIELD status ON publish_request TYPE string DEFAULT 'requested';
DEFINE FIELD decision ON publish_request TYPE option<record<decision>>;
DEFINE FIELD requested_at ON publish_request TYPE datetime DEFAULT time::now();
DEFINE FIELD scheduled_at ON publish_request TYPE option<datetime>;
DEFINE FIELD completed_at ON publish_request TYPE option<datetime>;
DEFINE INDEX publish_request_work ON publish_request COLUMNS tenant, work, status;

DEFINE TABLE correction SCHEMAFULL;
DEFINE FIELD tenant ON correction TYPE record<tenant>;
DEFINE FIELD work ON correction TYPE record<creative_work>;
DEFINE FIELD requested_by ON correction TYPE record<identity>;
DEFINE FIELD approved_by ON correction TYPE option<record<identity>>;
DEFINE FIELD reason ON correction TYPE string;
DEFINE FIELD correction_text ON correction TYPE option<string>;
DEFINE FIELD status ON correction TYPE string DEFAULT 'requested';
DEFINE FIELD decision ON correction TYPE option<record<decision>>;
DEFINE FIELD requested_at ON correction TYPE datetime DEFAULT time::now();
DEFINE FIELD published_at ON correction TYPE option<datetime>;
DEFINE INDEX correction_work ON correction COLUMNS tenant, work, status;

DEFINE TABLE retraction SCHEMAFULL;
DEFINE FIELD tenant ON retraction TYPE record<tenant>;
DEFINE FIELD work ON retraction TYPE record<creative_work>;
DEFINE FIELD requested_by ON retraction TYPE record<identity>;
DEFINE FIELD approved_by ON retraction TYPE option<record<identity>>;
DEFINE FIELD reason ON retraction TYPE string;
DEFINE FIELD public_notice ON retraction TYPE option<string>;
DEFINE FIELD status ON retraction TYPE string DEFAULT 'requested';
DEFINE FIELD decision ON retraction TYPE option<record<decision>>;
DEFINE FIELD requested_at ON retraction TYPE datetime DEFAULT time::now();
DEFINE FIELD published_at ON retraction TYPE option<datetime>;
DEFINE INDEX retraction_work ON retraction COLUMNS tenant, work, status;

DEFINE TABLE editorial_lane SCHEMAFULL;
DEFINE FIELD tenant ON editorial_lane TYPE record<tenant>;
DEFINE FIELD publication ON editorial_lane TYPE option<record<publication>>;
DEFINE FIELD name ON editorial_lane TYPE string;
DEFINE FIELD lane_type ON editorial_lane TYPE string;
DEFINE FIELD sort_order ON editorial_lane TYPE int DEFAULT 0;
DEFINE FIELD requires_review ON editorial_lane TYPE bool DEFAULT false;
DEFINE FIELD requires_approval ON editorial_lane TYPE bool DEFAULT false;
DEFINE FIELD created_at ON editorial_lane TYPE datetime DEFAULT time::now();
DEFINE INDEX editorial_lane_publication ON editorial_lane COLUMNS tenant, publication, lane_type;
