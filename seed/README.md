# DSpace-CRIS Seed Data

Dữ liệu demo dựa trên video **[DSpace-CRIS full demo](https://www.youtube.com/watch?v=boXkel74Krc)** của 4Science.

## Chạy theo thứ tự

```bash
# Bước 1: CRIS Layout (tabs, boxes, fields)
docker exec -i dspacedb-dev psql -U dspace -d dspace < seed/seed_cris_layout.sql

# Bước 2: Bổ sung metadata cho items hiện có
docker exec -i dspacedb-dev psql -U dspace -d dspace < seed/seed_additional_metadata.sql

# Bước 3: Demo data theo video (disambiguation, 3-author paper, CBM)
docker exec -i dspacedb-dev psql -U dspace -d dspace < seed/seed_demo_data.sql
```

## Files

| File | Mô tả |
|------|-------|
| `seed_cris_layout.sql` | Cấu hình layout CRIS: tabs, rows, cells, boxes, fields cho Person/Publication/OrgUnit/Project |
| `seed_additional_metadata.sql` | Bổ sung dc.type, dc.language, dc.publisher, doi, oairecerif.funder cho items hiện có |
| `seed_demo_data.sql` | Demo data theo video: disambiguation (2 Nguyen Van Duc), publication 3 tác giả, CBM college |

## Data hiện có (trước khi seed)

| Entity | Items |
|--------|-------|
| Person | Nguyen Van An, Tran Thi Bich, Le Van Cuong |
| Publication | 7 publications (AI, Blockchain, NLP, Healthcare...) |
| Project | AI Learning Platform, Smart Healthcare |
| OrgUnit | VinUniversity, CECS, CHS |

## Sau khi seed

### CRIS Layout sẽ hiển thị:

**Person profile:**
- Tab "Profile": Given Name, Family Name, Email, Job Title, Affiliation, Biography, Research Areas / ORCID, Scopus ID, Website
- Tab "Publications": danh sách publications linked (RELATION.Person.researchoutputs)
- Tab "Projects": danh sách projects linked (RELATION.Person.projects)

**Publication page:**
- Left col (8/12): Authors, Date, Publisher, Journal, DOI, Abstract
- Right col (4/12): Type, Language, ISSN, Volume, Issue, Pages, Keywords

**OrgUnit page:**
- Tab "": Description, Website, Research Areas / Details
- Tab "People": danh sách members (RELATION.OrgUnit.people)
- Tab "Publications": danh sách publications (RELATION.OrgUnit.rppublications)

**Project page:**
- Left col (8/12): Description, Acronym, Start/End Date, Status
- Right col (4/12): Funder, Amount, Currency, Funding Program
- Tab "Research Outputs": linked publications (RELATION.Project.researchoutputs)

### Demo features từ video:

1. **Disambiguation** (Pascal trong video → Nguyen Van Duc ở đây): 2 người cùng tên, khác department
2. **External author** (Mikel Manelli → John Smith): không có profile trong hệ thống
3. **3-author publication** với internal authors (ORCID badge) và external author
4. **Funding info** trên Projects (VinGroup, Ministry of Health)
5. **ORCID** cho Nguyen Van An: `0000-0002-1234-5678`
6. **Affiliation nested metadata** (oairecerif.affiliation.*)

## Discovery configurations cần có (đã có sẵn trong discovery.xml)

- `RELATION.Person.researchoutputs`
- `RELATION.Person.projects`
- `RELATION.OrgUnit.people`
- `RELATION.OrgUnit.rppublications`
- `RELATION.Project.researchoutputs`
