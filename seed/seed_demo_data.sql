-- =============================================================================
-- DSpace-CRIS Demo Data - Based on video demo by 4Science
-- Adds entities shown in the demo: disambiguation example, external author,
-- additional researcher profiles, and a third publication with 3 named authors
-- =============================================================================
-- Run AFTER seed_cris_layout.sql and seed_additional_metadata.sql
-- docker exec -i dspacedb-dev psql -U dspace -d dspace < seed/seed_demo_data.sql
-- =============================================================================

BEGIN;

-- Sync sequence with current max IDs
SELECT setval('relationship_id_seq', GREATEST((SELECT MAX(id) FROM relationship), 1));

-- =============================================================================
-- 1. DISAMBIGUATION DEMO: Two researchers named "Nguyen Van Duc"
--    (mirrors the "Pascal" disambiguation example in the video)
-- =============================================================================

-- Insert DSpaceObject entries first
INSERT INTO dspaceobject (uuid) VALUES
('40000000-0000-0000-0000-000000000004'),   -- Nguyen Van Duc (Person 1 - CECS)
('40000000-0000-0000-0000-000000000005');   -- Nguyen Van Duc (Person 2 - CHS)

-- Insert items (entity type is stored in metadatavalue, not item table)
INSERT INTO item (uuid, in_archive, withdrawn, discoverable, last_modified)
VALUES ('40000000-0000-0000-0000-000000000004', true, false, true, NOW());

INSERT INTO item (uuid, in_archive, withdrawn, discoverable, last_modified)
VALUES ('40000000-0000-0000-0000-000000000005', true, false, true, NOW());

-- Person 1: Nguyen Van Duc - Computer Science (CECS)
INSERT INTO metadatavalue (dspace_object_id, metadata_field_id, text_value, place, confidence) VALUES
('40000000-0000-0000-0000-000000000004',  82, 'Nguyen Van Duc',                     0, -1),  -- dc.title
('40000000-0000-0000-0000-000000000004', 218, 'Van Duc',                             0, -1),  -- person.givenName
('40000000-0000-0000-0000-000000000004', 219, 'Nguyen',                              0, -1),  -- person.familyName
('40000000-0000-0000-0000-000000000004', 222, 'duc.nguyen@vinuni.edu.vn',            0, -1),  -- person.email
('40000000-0000-0000-0000-000000000004', 224, 'PhD Student',                         0, -1),  -- person.jobTitle
('40000000-0000-0000-0000-000000000004', 225, 'College of Engineering and Computer Science', 0, -1),
('40000000-0000-0000-0000-000000000004',  40, 'PhD student in Computer Science at VinUniversity CECS. Research focus: Deep Learning and Computer Vision.', 0, -1),
('40000000-0000-0000-0000-000000000004',  75, 'Deep Learning',                       0, -1),
('40000000-0000-0000-0000-000000000004',  75, 'Computer Vision',                     1, -1),
('40000000-0000-0000-0000-000000000004',   7, 'Person',                              0, -1),  -- dspace.entity.type
('40000000-0000-0000-0000-000000000004',  18, NOW()::text,                           0, -1),  -- dc.date.accessioned
('40000000-0000-0000-0000-000000000004',  19, NOW()::text,                           0, -1);  -- dc.date.available

-- Person 2: Nguyen Van Duc - Health Sciences (CHS) - same name, different person!
INSERT INTO metadatavalue (dspace_object_id, metadata_field_id, text_value, place, confidence) VALUES
('40000000-0000-0000-0000-000000000005',  82, 'Nguyen Van Duc',                     0, -1),
('40000000-0000-0000-0000-000000000005', 218, 'Van Duc',                             0, -1),
('40000000-0000-0000-0000-000000000005', 219, 'Nguyen',                              0, -1),
('40000000-0000-0000-0000-000000000005', 222, 'vanduc.nguyen@vinuni.edu.vn',         0, -1),
('40000000-0000-0000-0000-000000000005', 224, 'PhD Student',                         0, -1),
('40000000-0000-0000-0000-000000000005', 225, 'College of Health Sciences',          0, -1),
('40000000-0000-0000-0000-000000000005',  40, 'PhD student in Biomedical Engineering at VinUniversity CHS. Research focus: AI-assisted medical imaging.', 0, -1),
('40000000-0000-0000-0000-000000000005',  75, 'Biomedical Engineering',              0, -1),
('40000000-0000-0000-0000-000000000005',  75, 'Medical Imaging',                    1, -1),
('40000000-0000-0000-0000-000000000005',   7, 'Person',                              0, -1),
('40000000-0000-0000-0000-000000000005',  18, NOW()::text,                           0, -1),
('40000000-0000-0000-0000-000000000005',  19, NOW()::text,                           0, -1);

-- Place both "Duc" researchers in Researcher Profiles collection
INSERT INTO collection2item (collection_id, item_id) VALUES
('30000000-0000-0000-0000-000000000006', '40000000-0000-0000-0000-000000000004'),
('30000000-0000-0000-0000-000000000006', '40000000-0000-0000-0000-000000000005');

-- Membership: Duc-1 → CECS, Duc-2 → CHS
INSERT INTO relationship (id, left_id, right_id, type_id, left_place, right_place, leftward_value, rightward_value)
SELECT nextval('relationship_id_seq'), '40000000-0000-0000-0000-000000000004', '40000000-0000-0000-0000-000000000031',
       rt.id, 0, 0, NULL, NULL
FROM relationship_type rt WHERE rt.leftward_type = 'isMemberOf';

INSERT INTO relationship (id, left_id, right_id, type_id, left_place, right_place, leftward_value, rightward_value)
SELECT nextval('relationship_id_seq'), '40000000-0000-0000-0000-000000000005', '40000000-0000-0000-0000-000000000032',
       rt.id, 0, 0, NULL, NULL
FROM relationship_type rt WHERE rt.leftward_type = 'isMemberOf';


-- =============================================================================
-- 2. PUBLICATION WITH THREE NAMED AUTHORS (mirrors the 3-author paper in video)
--    Authors: Nguyen Van An (internal+ORCID), Tran Thi Bich (internal),
--             John Smith (external - no profile)
-- =============================================================================

INSERT INTO dspaceobject (uuid) VALUES ('40000000-0000-0000-0000-000000000017');

INSERT INTO item (uuid, in_archive, withdrawn, discoverable, last_modified)
VALUES ('40000000-0000-0000-0000-000000000017', true, false, true, NOW());

INSERT INTO metadatavalue (dspace_object_id, metadata_field_id, text_value, place, confidence) VALUES
('40000000-0000-0000-0000-000000000017',  82, 'Federated Learning for Privacy-Preserving AI in Vietnamese Healthcare', 0, -1),
('40000000-0000-0000-0000-000000000017',   7, 'Publication', 0, -1),
('40000000-0000-0000-0000-000000000017',  10, 'Nguyen, Van An',   0, 600),  -- internal author (confidence 600 = matched)
('40000000-0000-0000-0000-000000000017',  10, 'Tran, Thi Bich',  1, 600),  -- internal author
('40000000-0000-0000-0000-000000000017',  10, 'Smith, John',     2, -1),   -- external author (no profile, confidence -1)
-- Affiliations (oairecerif.author.affiliation nested with each author)
('40000000-0000-0000-0000-000000000017', 377, 'College of Engineering and Computer Science, VinUniversity', 0, -1),
('40000000-0000-0000-0000-000000000017', 377, 'College of Engineering and Computer Science, VinUniversity', 1, -1),
('40000000-0000-0000-0000-000000000017', 377, 'MIT Computer Science and Artificial Intelligence Laboratory', 2, -1),
-- Publication details
('40000000-0000-0000-0000-000000000017',  22, '2024', 0, -1),
('40000000-0000-0000-0000-000000000017',  52, 'IEEE Transactions on Neural Networks and Learning Systems', 0, -1),
('40000000-0000-0000-0000-000000000017',  55, 'IEEE TNNLS Vol. 35 (2024)', 0, -1),
('40000000-0000-0000-0000-000000000017',  32, '10.1109/TNNLS.2024.0000001', 0, -1),
('40000000-0000-0000-0000-000000000017',  84, 'Journal Article', 0, -1),
('40000000-0000-0000-0000-000000000017',  51, 'en', 0, -1),
('40000000-0000-0000-0000-000000000017',  40, 'This paper proposes a federated learning framework designed for privacy-preserving AI applications in the Vietnamese healthcare system. Our approach enables collaborative model training across multiple hospitals without sharing sensitive patient data. We demonstrate significant improvements in diagnostic accuracy for cardiovascular disease while preserving patient privacy in compliance with Vietnam''s Cybersecurity Law.', 0, -1),
('40000000-0000-0000-0000-000000000017',  75, 'Federated Learning', 0, -1),
('40000000-0000-0000-0000-000000000017',  75, 'Privacy-Preserving AI', 1, -1),
('40000000-0000-0000-0000-000000000017',  75, 'Healthcare Informatics', 2, -1),
('40000000-0000-0000-0000-000000000017',  96, '35', 0, -1),   -- volume
('40000000-0000-0000-0000-000000000017',  97, '4',  0, -1),   -- issue
('40000000-0000-0000-0000-000000000017',  98, '1234', 0, -1), -- startpage
('40000000-0000-0000-0000-000000000017',  99, '1248', 0, -1), -- endpage
('40000000-0000-0000-0000-000000000017',  18, NOW()::text, 0, -1),
('40000000-0000-0000-0000-000000000017',  19, NOW()::text, 0, -1);

-- Place publication in CECS Faculty Publications
INSERT INTO collection2item (collection_id, item_id) VALUES
('30000000-0000-0000-0000-000000000001', '40000000-0000-0000-0000-000000000017');

-- Author relationships: Nguyen Van An and Tran Thi Bich are internal authors
INSERT INTO relationship (id, left_id, right_id, type_id, left_place, right_place, leftward_value, rightward_value)
SELECT nextval('relationship_id_seq'),
       '40000000-0000-0000-0000-000000000001',
       '40000000-0000-0000-0000-000000000017',
       rt.id, 0, 0, NULL, NULL
FROM relationship_type rt WHERE rt.leftward_type = 'isAuthorOf';

INSERT INTO relationship (id, left_id, right_id, type_id, left_place, right_place, leftward_value, rightward_value)
SELECT nextval('relationship_id_seq'),
       '40000000-0000-0000-0000-000000000002',
       '40000000-0000-0000-0000-000000000017',
       rt.id, 1, 1, NULL, NULL
FROM relationship_type rt WHERE rt.leftward_type = 'isAuthorOf';

-- Link to Smart Healthcare project
INSERT INTO relationship (id, left_id, right_id, type_id, left_place, right_place, leftward_value, rightward_value)
SELECT nextval('relationship_id_seq'),
       '40000000-0000-0000-0000-000000000021',
       '40000000-0000-0000-0000-000000000017',
       rt.id, 0, 0, NULL, NULL
FROM relationship_type rt WHERE rt.leftward_type = 'isRelatedTo';


-- =============================================================================
-- 3. COLLEGE OF BUSINESS AND MANAGEMENT (third org unit - not in video but
--    enriches the demo for business/management research)
-- =============================================================================

INSERT INTO dspaceobject (uuid) VALUES ('40000000-0000-0000-0000-000000000033');

INSERT INTO item (uuid, in_archive, withdrawn, discoverable, last_modified)
VALUES ('40000000-0000-0000-0000-000000000033', true, false, true, NOW());

INSERT INTO metadatavalue (dspace_object_id, metadata_field_id, text_value, place, confidence) VALUES
('40000000-0000-0000-0000-000000000033',  82, 'College of Business and Management',  0, -1),
('40000000-0000-0000-0000-000000000033',   7, 'OrgUnit', 0, -1),
('40000000-0000-0000-0000-000000000033',  84, 'College', 0, -1),
('40000000-0000-0000-0000-000000000033',  40, 'VinUniversity''s College of Business and Management offers undergraduate and graduate programs in Business Administration, Finance, and Accounting. It partners with Cornell University''s SC Johnson College of Business.', 0, -1),
('40000000-0000-0000-0000-000000000033', 379, 'https://vinuni.edu.vn/college-of-business-and-management/', 0, -1),
('40000000-0000-0000-0000-000000000033',  75, 'Business Administration', 0, -1),
('40000000-0000-0000-0000-000000000033',  75, 'Finance',                 1, -1),
('40000000-0000-0000-0000-000000000033',  18, NOW()::text, 0, -1),
('40000000-0000-0000-0000-000000000033',  19, NOW()::text, 0, -1);

-- Place CBM in Organizational Units collection
INSERT INTO collection2item (collection_id, item_id) VALUES
('30000000-0000-0000-0000-000000000007', '40000000-0000-0000-0000-000000000033');

-- OrgUnit hierarchy: VinUniversity → CBM
INSERT INTO relationship (id, left_id, right_id, type_id, left_place, right_place, leftward_value, rightward_value)
SELECT nextval('relationship_id_seq'),
       '40000000-0000-0000-0000-000000000030',
       '40000000-0000-0000-0000-000000000033',
       rt.id, 2, 0, NULL, NULL
FROM relationship_type rt WHERE rt.leftward_type = 'isParentOrgUnitOf';


-- =============================================================================
-- 4. UPDATE COLLECTION ENTITY TYPES (needed for proper CRIS routing)
-- =============================================================================

-- Researcher Profiles collection → Person entity type
UPDATE metadatavalue SET text_value = 'Person'
WHERE dspace_object_id = '30000000-0000-0000-0000-000000000006'
  AND metadata_field_id = 7;

-- If no entity type exists yet, insert it
INSERT INTO metadatavalue (dspace_object_id, metadata_field_id, text_value, place, confidence)
SELECT '30000000-0000-0000-0000-000000000006', 7, 'Person', 0, -1
WHERE NOT EXISTS (
    SELECT 1 FROM metadatavalue
    WHERE dspace_object_id = '30000000-0000-0000-0000-000000000006'
    AND metadata_field_id = 7
);

-- Research Projects collection → Project entity type
INSERT INTO metadatavalue (dspace_object_id, metadata_field_id, text_value, place, confidence)
SELECT '30000000-0000-0000-0000-000000000005', 7, 'Project', 0, -1
WHERE NOT EXISTS (
    SELECT 1 FROM metadatavalue
    WHERE dspace_object_id = '30000000-0000-0000-0000-000000000005'
    AND metadata_field_id = 7
);

-- Organizational Units collection → OrgUnit entity type
INSERT INTO metadatavalue (dspace_object_id, metadata_field_id, text_value, place, confidence)
SELECT '30000000-0000-0000-0000-000000000007', 7, 'OrgUnit', 0, -1
WHERE NOT EXISTS (
    SELECT 1 FROM metadatavalue
    WHERE dspace_object_id = '30000000-0000-0000-0000-000000000007'
    AND metadata_field_id = 7
);

-- CECS Faculty Publications → Publication entity type
INSERT INTO metadatavalue (dspace_object_id, metadata_field_id, text_value, place, confidence)
SELECT '30000000-0000-0000-0000-000000000001', 7, 'Publication', 0, -1
WHERE NOT EXISTS (
    SELECT 1 FROM metadatavalue
    WHERE dspace_object_id = '30000000-0000-0000-0000-000000000001'
    AND metadata_field_id = 7
);

-- VinUniversity Publications → Publication entity type
INSERT INTO metadatavalue (dspace_object_id, metadata_field_id, text_value, place, confidence)
SELECT '30000000-0000-0000-0000-000000000008', 7, 'Publication', 0, -1
WHERE NOT EXISTS (
    SELECT 1 FROM metadatavalue
    WHERE dspace_object_id = '30000000-0000-0000-0000-000000000008'
    AND metadata_field_id = 7
);

COMMIT;

-- Summary
SELECT 'Demo data seeded successfully' AS status;
SELECT mv.text_value as entity_type, COUNT(i.uuid) as total_items
FROM item i
JOIN metadatavalue mv ON mv.dspace_object_id = i.uuid AND mv.metadata_field_id = 7
GROUP BY mv.text_value
ORDER BY mv.text_value;

SELECT 'Total relationships: ' || COUNT(*) as info FROM relationship;
