-- 05-object-tables-and-object-columns.sql
--
-- Goal:
--   Compare object tables with relational tables that contain object columns.
--
SET SERVEROUTPUT ON

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE project_groups PURGE';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE project_groups (
    group_id       NUMBER PRIMARY KEY,
    group_name     VARCHAR2(80) NOT NULL,
    lead           advisor_t,
    meeting_place  address_t
)
/

INSERT INTO project_groups
SELECT 1,
       'Object Database Seminar',
       VALUE(a),
       address_t('AAA Building', 'Plzen', '30100')
FROM advisors a
WHERE a.person_id = 10;

INSERT INTO project_groups
SELECT 2,
       'Database Design Workshop',
       VALUE(a),
       address_t('Bory Campus', 'Plzen', '30100')
FROM advisors a
WHERE a.person_id = 11;

COMMIT;

PROMPT Object table query

SELECT a.person_id,
       a.name,
       a.office_no
FROM advisors a
ORDER BY a.person_id;

PROMPT Relational table with object columns

SELECT g.group_id,
       g.group_name,
       g.lead.name AS lead_name,
       g.lead.office_no AS lead_office,
       g.meeting_place.to_text() AS meeting_place
FROM project_groups g
ORDER BY g.group_id;
