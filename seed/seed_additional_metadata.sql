-- =============================================================================
-- Additional Metadata for Existing Items
-- Enriches existing VinUni items with fields needed by the CRIS layout
-- Inspired by the DSpace-CRIS full demo (4Science)
-- =============================================================================
-- Run AFTER seed_cris_layout.sql
-- docker exec -i dspacedb-dev psql -U dspace -d dspace < seed/seed_additional_metadata.sql
-- =============================================================================

BEGIN;

-- =============================================================================
-- PUBLICATIONS: add dc.type, dc.language.iso, dc.identifier.issn
-- =============================================================================

-- dc.type (84): Publication type for all publications
INSERT INTO metadatavalue (dspace_object_id, metadata_field_id, text_value, place, confidence)
VALUES
('40000000-0000-0000-0000-000000000010', 84, 'Journal Article', 0, -1),
('40000000-0000-0000-0000-000000000011', 84, 'Journal Article', 0, -1),
('40000000-0000-0000-0000-000000000012', 84, 'Journal Article', 0, -1),
('40000000-0000-0000-0000-000000000013', 84, 'Journal Article', 0, -1),
('40000000-0000-0000-0000-000000000014', 84, 'Journal Article', 0, -1),
('40000000-0000-0000-0000-000000000015', 84, 'Conference Paper', 0, -1),
('40000000-0000-0000-0000-000000000016', 84, 'Journal Article', 0, -1);

-- dc.language.iso (51): Language
INSERT INTO metadatavalue (dspace_object_id, metadata_field_id, text_value, place, confidence)
VALUES
('40000000-0000-0000-0000-000000000010', 51, 'en', 0, -1),
('40000000-0000-0000-0000-000000000011', 51, 'en', 0, -1),
('40000000-0000-0000-0000-000000000012', 51, 'en', 0, -1),
('40000000-0000-0000-0000-000000000013', 51, 'en', 0, -1),
('40000000-0000-0000-0000-000000000014', 51, 'en', 0, -1),
('40000000-0000-0000-0000-000000000015', 51, 'en', 0, -1),
('40000000-0000-0000-0000-000000000016', 51, 'vi', 0, -1);  -- Vietnamese paper in Vietnamese

-- dc.publisher (52)
INSERT INTO metadatavalue (dspace_object_id, metadata_field_id, text_value, place, confidence)
VALUES
('40000000-0000-0000-0000-000000000010', 52, 'International Journal of Educational Technology in Higher Education', 0, -1),
('40000000-0000-0000-0000-000000000011', 52, 'IEEE Access', 0, -1),
('40000000-0000-0000-0000-000000000012', 52, 'Natural Language Engineering', 0, -1),
('40000000-0000-0000-0000-000000000013', 52, 'npj Digital Medicine', 0, -1),
('40000000-0000-0000-0000-000000000014', 52, 'Applied Soft Computing', 0, -1),
('40000000-0000-0000-0000-000000000015', 52, 'Procedia Manufacturing', 0, -1),
('40000000-0000-0000-0000-000000000016', 52, 'Tạp chí Khoa học và Công nghệ Việt Nam', 0, -1);

-- dc.relation.ispartof (55): Journal name
INSERT INTO metadatavalue (dspace_object_id, metadata_field_id, text_value, place, confidence)
VALUES
('40000000-0000-0000-0000-000000000010', 55, 'IJETHE Vol. 20 (2023)', 0, -1),
('40000000-0000-0000-0000-000000000011', 55, 'IEEE Access Vol. 11 (2023)', 0, -1),
('40000000-0000-0000-0000-000000000012', 55, 'NLE Vol. 29 (2023)', 0, -1),
('40000000-0000-0000-0000-000000000013', 55, 'npj Digital Medicine Vol. 6 (2023)', 0, -1),
('40000000-0000-0000-0000-000000000014', 55, 'Applied Soft Computing Vol. 138 (2023)', 0, -1),
('40000000-0000-0000-0000-000000000015', 55, 'Procedia Manufacturing Vol. 58 (2022)', 0, -1),
('40000000-0000-0000-0000-000000000016', 55, 'Tạp chí KHCN Việt Nam, Số 5/2023', 0, -1);

-- dc.identifier.doi (32): DOI
INSERT INTO metadatavalue (dspace_object_id, metadata_field_id, text_value, place, confidence)
VALUES
('40000000-0000-0000-0000-000000000010', 32, '10.1007/s41239-023-0001-x', 0, -1),
('40000000-0000-0000-0000-000000000011', 32, '10.1109/ACCESS.2023.0000001', 0, -1),
('40000000-0000-0000-0000-000000000012', 32, '10.1017/S1351324923000001', 0, -1),
('40000000-0000-0000-0000-000000000013', 32, '10.1038/s41746-023-00001-x', 0, -1),
('40000000-0000-0000-0000-000000000014', 32, '10.1016/j.asoc.2023.000001', 0, -1),
('40000000-0000-0000-0000-000000000015', 32, '10.1016/j.promfg.2022.000001', 0, -1);

-- dc.description.volume (96) / issue (97)
INSERT INTO metadatavalue (dspace_object_id, metadata_field_id, text_value, place, confidence)
VALUES
('40000000-0000-0000-0000-000000000010', 96, '20', 0, -1),
('40000000-0000-0000-0000-000000000010', 97, '1',  0, -1),
('40000000-0000-0000-0000-000000000011', 96, '11', 0, -1),
('40000000-0000-0000-0000-000000000012', 96, '29', 0, -1),
('40000000-0000-0000-0000-000000000013', 96, '6',  0, -1),
('40000000-0000-0000-0000-000000000014', 96, '138',0, -1),
('40000000-0000-0000-0000-000000000015', 96, '58', 0, -1);


-- =============================================================================
-- PERSONS: add oairecerif.affiliation fields (linked to org items)
--          and person.birthDate for privacy-level demo (similar to video)
-- =============================================================================

-- Nguyen Van An (40000000-0000-0000-0000-000000000001)
INSERT INTO metadatavalue (dspace_object_id, metadata_field_id, text_value, place, confidence)
VALUES
-- Affiliation dates and role (used in Affiliations tab)
('40000000-0000-0000-0000-000000000001', 380, 'College of Engineering and Computer Science', 0, -1),
('40000000-0000-0000-0000-000000000001', 381, '2021-09-01', 0, -1),  -- affiliation.startDate
('40000000-0000-0000-0000-000000000001', 383, 'Associate Professor', 0, -1), -- affiliation.role
-- Website
('40000000-0000-0000-0000-000000000001', 379, 'https://scholar.google.com/citations?user=nguyen-van-an', 0, -1),
-- Birth date (shown in Privacy demo in video)
('40000000-0000-0000-0000-000000000001', 223, '1985-03-15', 0, -1);

-- Tran Thi Bich (40000000-0000-0000-0000-000000000002)
INSERT INTO metadatavalue (dspace_object_id, metadata_field_id, text_value, place, confidence)
VALUES
('40000000-0000-0000-0000-000000000002', 380, 'College of Engineering and Computer Science', 0, -1),
('40000000-0000-0000-0000-000000000002', 381, '2022-01-15', 0, -1),
('40000000-0000-0000-0000-000000000002', 383, 'Assistant Professor', 0, -1),
('40000000-0000-0000-0000-000000000002', 379, 'https://scholar.google.com/citations?user=tran-thi-bich', 0, -1),
('40000000-0000-0000-0000-000000000002', 223, '1990-07-22', 0, -1);

-- Le Van Cuong (40000000-0000-0000-0000-000000000003)
INSERT INTO metadatavalue (dspace_object_id, metadata_field_id, text_value, place, confidence)
VALUES
('40000000-0000-0000-0000-000000000003', 380, 'College of Health Sciences', 0, -1),
('40000000-0000-0000-0000-000000000003', 381, '2020-06-01', 0, -1),
('40000000-0000-0000-0000-000000000003', 383, 'Associate Professor', 0, -1),
('40000000-0000-0000-0000-000000000003', 379, 'https://scholar.google.com/citations?user=le-van-cuong', 0, -1),
('40000000-0000-0000-0000-000000000003', 223, '1982-11-08', 0, -1);


-- =============================================================================
-- PROJECTS: add oairecerif fields (funder, dates, status, acronym)
-- =============================================================================

-- Project 1: AI-Powered Adaptive Learning Platform (40000000-0000-0000-0000-000000000020)
INSERT INTO metadatavalue (dspace_object_id, metadata_field_id, text_value, place, confidence)
VALUES
('40000000-0000-0000-0000-000000000020', 386, 'ALAIV', 0, -1),            -- acronym
('40000000-0000-0000-0000-000000000020', 391, '2023-01-01', 0, -1),       -- startDate
('40000000-0000-0000-0000-000000000020', 392, '2025-12-31', 0, -1),       -- endDate
('40000000-0000-0000-0000-000000000020', 393, 'ACTIVE', 0, -1),           -- status
('40000000-0000-0000-0000-000000000020', 388, 'VinGroup Innovation Fund', 0, -1), -- funder
('40000000-0000-0000-0000-000000000020', 397, '5000000000', 0, -1),       -- amount (VND)
('40000000-0000-0000-0000-000000000020', 396, 'VND', 0, -1),              -- currency
('40000000-0000-0000-0000-000000000020', 406, 'VinGroup R&D Program 2023', 0, -1); -- funding program

-- Project 2: Smart Healthcare (40000000-0000-0000-0000-000000000021)
INSERT INTO metadatavalue (dspace_object_id, metadata_field_id, text_value, place, confidence)
VALUES
('40000000-0000-0000-0000-000000000021', 386, 'SHAICDS', 0, -1),
('40000000-0000-0000-0000-000000000021', 391, '2022-07-01', 0, -1),
('40000000-0000-0000-0000-000000000021', 392, '2024-06-30', 0, -1),
('40000000-0000-0000-0000-000000000021', 393, 'ACTIVE', 0, -1),
('40000000-0000-0000-0000-000000000021', 388, 'Ministry of Health Vietnam', 0, -1),
('40000000-0000-0000-0000-000000000021', 397, '3500000000', 0, -1),
('40000000-0000-0000-0000-000000000021', 396, 'VND', 0, -1),
('40000000-0000-0000-0000-000000000021', 406, 'National Health Research Program 2022', 0, -1);


-- =============================================================================
-- ORGUNITS: add dc.type and oairecerif.identifier.url
-- =============================================================================

INSERT INTO metadatavalue (dspace_object_id, metadata_field_id, text_value, place, confidence)
VALUES
-- VinUniversity (40000000-0000-0000-0000-000000000030)
('40000000-0000-0000-0000-000000000030', 84, 'University', 0, -1),
('40000000-0000-0000-0000-000000000030', 379, 'https://vinuni.edu.vn', 0, -1),
-- CECS (40000000-0000-0000-0000-000000000031)
('40000000-0000-0000-0000-000000000031', 84, 'College', 0, -1),
('40000000-0000-0000-0000-000000000031', 379, 'https://vinuni.edu.vn/college-of-engineering-computer-science/', 0, -1),
('40000000-0000-0000-0000-000000000031', 40, 'The College of Engineering and Computer Science at VinUniversity prepares students to be innovative problem solvers who contribute to Vietnam''s digital transformation. Programs span Computer Science, Electrical Engineering, and Mechatronics.', 0, -1),
-- CHS (40000000-0000-0000-0000-000000000032)
('40000000-0000-0000-0000-000000000032', 84, 'College', 0, -1),
('40000000-0000-0000-0000-000000000032', 379, 'https://vinuni.edu.vn/college-of-health-sciences/', 0, -1),
('40000000-0000-0000-0000-000000000032', 40, 'The College of Health Sciences at VinUniversity offers world-class medical education in partnership with Cornell University. It focuses on evidence-based clinical practice and translational research.', 0, -1);

COMMIT;

SELECT 'Additional metadata seeded successfully' AS status;
SELECT msr.short_id || '.' || mfr.element || COALESCE('.' || mfr.qualifier, '') AS field,
       COUNT(*) AS new_values
FROM metadatavalue mv
JOIN metadatafieldregistry mfr ON mv.metadata_field_id = mfr.metadata_field_id
JOIN metadataschemaregistry msr ON mfr.metadata_schema_id = msr.metadata_schema_id
WHERE msr.short_id NOT IN ('dc','dspace','eperson')
   OR mfr.element IN ('type','language','publisher','relation','description','identifier')
GROUP BY 1
HAVING COUNT(*) > 1
ORDER BY 2 DESC
LIMIT 20;
