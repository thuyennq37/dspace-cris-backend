-- =============================================================================
-- DSpace-CRIS Layout Configuration Seed
-- Based on the DSpace-CRIS full demo (4Science)
-- Configures display layout for: Person, Publication, OrgUnit, Project
-- =============================================================================
-- Run via: docker exec -i dspacedb-dev psql -U dspace -d dspace < seed/seed_cris_layout.sql
-- =============================================================================

BEGIN;

-- =============================================================================
-- 1. TABS
--    entity_id: Person=2, Publication=3, Project=4, OrgUnit=5
--    security: 0=PUBLIC, 1=OWNER_ONLY, 2=ADMIN_ONLY, 3=CUSTOM
-- =============================================================================

INSERT INTO cris_layout_tab (id, entity_id, priority, shortname, header, security, is_leading, custom_filter) VALUES
-- PERSON tabs
(1,  2, 0, 'details',              'Profile',       0, true,  NULL),
(2,  2, 1, 'publications-person',  'Publications',  0, false, NULL),
(3,  2, 2, 'projects-person',      'Projects',      0, false, NULL),
-- PUBLICATION tabs
(4,  3, 0, 'primary',              NULL,            0, true,  NULL),
(5,  3, 1, 'files',                'Files',         0, false, NULL),
-- ORGUNIT tabs
(6,  5, 0, 'about-orgunit',        NULL,            0, true,  NULL),
(7,  5, 1, 'people-tab',           'People',        0, false, NULL),
(8,  5, 2, 'publications-orgunit', 'Publications',  0, false, NULL),
-- PROJECT tabs
(9,  4, 0, 'info-project',         NULL,            0, true,  NULL),
(10, 4, 1, 'outputs-project',      'Research Outputs', 0, false, NULL),
(11, 4, 2, 'team-project',         'Team',          0, false, NULL);


-- =============================================================================
-- 2. ROWS (layout rows within each tab)
-- =============================================================================

INSERT INTO cris_layout_row (id, style, tab, position) VALUES
-- Person - Details tab
(1,  NULL, 1, 0),   -- main 2-col row (biography + identifiers)
-- Person - Publications tab
(2,  NULL, 2, 0),
-- Person - Projects tab
(3,  NULL, 3, 0),
-- Publication - Primary tab
(4,  NULL, 4, 0),   -- main 2-col row (main info + details)
-- Publication - Files tab
(5,  NULL, 5, 0),
-- OrgUnit - About tab
(6,  NULL, 6, 0),   -- main 2-col row (info + details)
-- OrgUnit - People tab
(7,  NULL, 7, 0),
-- OrgUnit - Publications tab
(8,  NULL, 8, 0),
-- Project - Info tab
(9,  NULL, 9,  0),  -- main 2-col row (info + funding)
-- Project - Research Outputs tab
(10, NULL, 10, 0),
-- Project - Team tab
(11, NULL, 11, 0);


-- =============================================================================
-- 3. CELLS (columns within each row)
-- =============================================================================

INSERT INTO cris_layout_cell (id, style, row, position) VALUES
-- Person - Details row 1: 2 columns
(1,  'col-md-8',  1, 0),   -- left: biography
(2,  'col-md-4',  1, 1),   -- right: identifiers
-- Person - Publications row: full width
(3,  'col-md-12', 2, 0),
-- Person - Projects row: full width
(4,  'col-md-12', 3, 0),
-- Publication - Primary row: 2 columns
(5,  'col-md-8',  4, 0),   -- left: main info
(6,  'col-md-4',  4, 1),   -- right: details sidebar
-- Publication - Files row: full width
(7,  'col-md-12', 5, 0),
-- OrgUnit - About row: 2 columns
(8,  'col-md-8',  6, 0),   -- left: description
(9,  'col-md-4',  6, 1),   -- right: details
-- OrgUnit - People row: full width
(10, 'col-md-12', 7, 0),
-- OrgUnit - Publications row: full width
(11, 'col-md-12', 8, 0),
-- Project - Info row: 2 columns
(12, 'col-md-8',  9,  0),  -- left: project info
(13, 'col-md-4',  9,  1),  -- right: funding
-- Project - Outputs row: full width
(14, 'col-md-12', 10, 0),
-- Project - Team row: full width
(15, 'col-md-12', 11, 0);


-- =============================================================================
-- 4. BOXES (content blocks placed within cells)
--    type: METADATA | RELATION | BITSTREAM | METRICS
--    cell: FK to cris_layout_cell (where the box is placed on the tab grid)
-- =============================================================================

INSERT INTO cris_layout_box (id, entity_id, type, collapsed, shortname, header, minor, security, style, max_columns, cell, position, container) VALUES
-- ── PERSON boxes ──
(1,  2, 'METADATA', false, 'personaldata',   'Personal Data',   false, 0, NULL, NULL, 1,  0, false),
(2,  2, 'METADATA', false, 'identifiers',    'Identifiers',     false, 0, NULL, NULL, 2,  0, false),
(3,  2, 'RELATION', false, 'researchoutputs','Research Outputs', false, 0, NULL, NULL, 3,  0, false),
(4,  2, 'RELATION', false, 'projects',       'Projects',        false, 0, NULL, NULL, 4,  0, false),

-- ── PUBLICATION boxes ──
(5,  3, 'METADATA', false, 'maininfo',       NULL,              false, 0, NULL, NULL, 5,  0, false),
(6,  3, 'METADATA', false, 'details',        'Details',         false, 0, NULL, NULL, 6,  0, false),
(7,  3, 'METADATA', false, 'files',          'Files',           true,  0, NULL, NULL, 7,  0, false),

-- ── ORGUNIT boxes ──
(8,  5, 'METADATA', false, 'orgunit-info',   NULL,              false, 0, NULL, NULL, 8,  0, false),
(9,  5, 'METADATA', false, 'orgunit-details','Details',         false, 0, NULL, NULL, 9,  0, false),
(10, 5, 'RELATION', false, 'people',         'People',          false, 0, NULL, NULL, 10, 0, false),
(11, 5, 'RELATION', false, 'rppublications', 'Publications',    false, 0, NULL, NULL, 11, 0, false),

-- ── PROJECT boxes ──
(12, 4, 'METADATA', false, 'project-info',   NULL,              false, 0, NULL, NULL, 12, 0, false),
(13, 4, 'METADATA', false, 'funding-info',   'Funding',         false, 0, NULL, NULL, 13, 0, false),
(14, 4, 'RELATION', false, 'researchoutputs','Research Outputs', false, 0, NULL, NULL, 14, 0, false),
(15, 4, 'RELATION', false, 'team',           'Team',            false, 0, NULL, NULL, 15, 0, false);


-- =============================================================================
-- 5. FIELDS (metadata fields displayed within each METADATA box)
--    row/cell/priority: internal grid coordinates WITHIN the box (not FKs)
--    metadata_field_id references:
--      82  = dc.title
--      10  = dc.contributor.author
--      11  = dc.contributor.editor
--      22  = dc.date.issued
--      40  = dc.description.abstract
--      32  = dc.identifier.doi
--      28  = dc.identifier.issn
--      51  = dc.language.iso
--      52  = dc.publisher
--      55  = dc.relation.ispartof
--      75  = dc.subject
--      84  = dc.type
--      96  = dc.description.volume
--      97  = dc.description.issue
--      98  = dc.description.startpage
--      99  = dc.description.endpage
--     218  = person.givenName
--     219  = person.familyName
--     222  = person.email
--     223  = person.birthDate
--     224  = person.jobTitle
--     225  = person.affiliation.name
--     227  = person.identifier.scopus-author-id
--     230  = person.identifier.orcid
--     236  = person.identifier.linkedin-id
--     379  = oairecerif.identifier.url
--     380  = oairecerif.affiliation.orgunit
--     381  = oairecerif.affiliation.startDate
--     382  = oairecerif.affiliation.endDate
--     383  = oairecerif.affiliation.role
--     386  = oairecerif.acronym
--     388  = oairecerif.funder
--     391  = oairecerif.project.startDate
--     392  = oairecerif.project.endDate
--     393  = oairecerif.project.status
--     396  = oairecerif.amount.currency
--     397  = oairecerif.amount
--     406  = dc.relation.funding
-- =============================================================================

-- ── Box 1: personaldata (Person) ──
INSERT INTO cris_layout_field (field_id, box_id, metadata_field_id, row, cell, priority, type, rendering, label, label_as_heading, values_inline) VALUES
(1,  1, 218, 1, 0, 0, 'METADATA', 'text',      'Given Name',    false, false),
(2,  1, 219, 1, 1, 1, 'METADATA', 'text',      'Family Name',   false, false),
(3,  1, 222, 2, 0, 0, 'METADATA', 'email',     'Email',         false, false),
(4,  1, 224, 3, 0, 0, 'METADATA', 'text',      'Job Title',     false, false),
(5,  1, 225, 4, 0, 0, 'METADATA', 'text',      'Affiliation',   false, false),
(6,  1,  40, 5, 0, 0, 'METADATA', 'longtext',  'Biography',     false, false),
(7,  1,  75, 6, 0, 0, 'METADATA', 'tag',       'Research Areas',false, true);

-- ── Box 2: identifiers (Person) ──
INSERT INTO cris_layout_field (field_id, box_id, metadata_field_id, row, cell, priority, type, rendering, label, label_as_heading, values_inline) VALUES
(8,  2, 230, 1, 0, 0, 'METADATA', 'identifier.orcid', 'ORCID',          false, false),
(9,  2, 227, 2, 0, 0, 'METADATA', 'text',             'Scopus Author ID',false, false),
(10, 2, 379, 3, 0, 0, 'METADATA', 'link',             'Website',         false, false),
(11, 2, 236, 4, 0, 0, 'METADATA', 'link',             'LinkedIn',        false, false);

-- ── Box 5: maininfo (Publication) ──
INSERT INTO cris_layout_field (field_id, box_id, metadata_field_id, row, cell, priority, type, rendering, label, label_as_heading, values_inline) VALUES
(12, 5,  10, 1, 0, 0, 'METADATA', 'contributor',     'Authors',          false, false),
(13, 5,  22, 2, 0, 0, 'METADATA', 'date',            'Publication Date', false, false),
(14, 5,  52, 3, 0, 0, 'METADATA', 'text',            'Publisher',        false, false),
(15, 5,  55, 4, 0, 0, 'METADATA', 'text',            'Journal/Source',   false, false),
(16, 5,  32, 5, 0, 0, 'METADATA', 'identifier.doi',  'DOI',              false, false),
(17, 5,  40, 6, 0, 0, 'METADATA', 'longtext',        'Abstract',         false, false);

-- ── Box 6: details (Publication sidebar) ──
INSERT INTO cris_layout_field (field_id, box_id, metadata_field_id, row, cell, priority, type, rendering, label, label_as_heading, values_inline) VALUES
(18, 6,  84, 1, 0, 0, 'METADATA', 'text', 'Type',       false, false),
(19, 6,  51, 2, 0, 0, 'METADATA', 'text', 'Language',   false, false),
(20, 6,  28, 3, 0, 0, 'METADATA', 'text', 'ISSN',       false, false),
(21, 6,  96, 4, 0, 0, 'METADATA', 'text', 'Volume',     false, false),
(22, 6,  97, 5, 0, 0, 'METADATA', 'text', 'Issue',      false, false),
(23, 6,  98, 6, 0, 0, 'METADATA', 'text', 'Start Page', false, false),
(24, 6,  99, 7, 0, 0, 'METADATA', 'text', 'End Page',   false, false),
(25, 6,  75, 8, 0, 0, 'METADATA', 'tag',  'Keywords',   false, true);

-- ── Box 8: orgunit-info (OrgUnit) ──
INSERT INTO cris_layout_field (field_id, box_id, metadata_field_id, row, cell, priority, type, rendering, label, label_as_heading, values_inline) VALUES
(26, 8,  40, 1, 0, 0, 'METADATA', 'longtext', 'Description',    false, false),
(27, 8, 379, 2, 0, 0, 'METADATA', 'link',     'Website',        false, false),
(28, 8,  75, 3, 0, 0, 'METADATA', 'tag',      'Research Areas', false, true);

-- ── Box 9: orgunit-details (OrgUnit sidebar) ──
INSERT INTO cris_layout_field (field_id, box_id, metadata_field_id, row, cell, priority, type, rendering, label, label_as_heading, values_inline) VALUES
(29, 9,  84, 1, 0, 0, 'METADATA', 'text', 'Type',    false, false);

-- ── Box 12: project-info (Project) ──
INSERT INTO cris_layout_field (field_id, box_id, metadata_field_id, row, cell, priority, type, rendering, label, label_as_heading, values_inline) VALUES
(30, 12,  40, 1, 0, 0, 'METADATA', 'longtext', 'Description', false, false),
(31, 12, 386, 2, 0, 0, 'METADATA', 'text',     'Acronym',     false, false),
(32, 12, 391, 3, 0, 0, 'METADATA', 'date',     'Start Date',  false, false),
(33, 12, 392, 4, 0, 0, 'METADATA', 'date',     'End Date',    false, false),
(34, 12, 393, 5, 0, 0, 'METADATA', 'text',     'Status',      false, false);

-- ── Box 13: funding-info (Project sidebar) ──
INSERT INTO cris_layout_field (field_id, box_id, metadata_field_id, row, cell, priority, type, rendering, label, label_as_heading, values_inline) VALUES
(35, 13, 388, 1, 0, 0, 'METADATA', 'text', 'Funder',           false, false),
(36, 13, 397, 2, 0, 0, 'METADATA', 'text', 'Amount',           false, false),
(37, 13, 396, 3, 0, 0, 'METADATA', 'text', 'Currency',         false, false),
(38, 13, 406, 4, 0, 0, 'METADATA', 'text', 'Funding Program',  false, false);


-- =============================================================================
-- 6. Update sequences so next auto-generated IDs don't conflict
-- =============================================================================

SELECT setval('cris_layout_tab_id_seq',   (SELECT MAX(id)       FROM cris_layout_tab));
SELECT setval('cris_layout_row_id_seq',   (SELECT MAX(id)       FROM cris_layout_row));
SELECT setval('cris_layout_cell_id_seq',  (SELECT MAX(id)       FROM cris_layout_cell));
SELECT setval('cris_layout_box_id_seq',   (SELECT MAX(id)       FROM cris_layout_box));
SELECT setval('cris_layout_field_field_id_seq', (SELECT MAX(field_id) FROM cris_layout_field));

COMMIT;

-- Verify
SELECT 'Tabs'   AS table_name, COUNT(*) AS rows FROM cris_layout_tab   UNION ALL
SELECT 'Rows',   COUNT(*) FROM cris_layout_row   UNION ALL
SELECT 'Cells',  COUNT(*) FROM cris_layout_cell  UNION ALL
SELECT 'Boxes',  COUNT(*) FROM cris_layout_box   UNION ALL
SELECT 'Fields', COUNT(*) FROM cris_layout_field;
