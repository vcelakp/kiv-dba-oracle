-- 04-nested-table-attributes.sql
--
-- Goal:
--   Work with nested-table attributes and multiset operations.
--
SET SERVEROUTPUT ON

PROMPT Querying scalar nested-table elements

SELECT s.name,
       sk.COLUMN_VALUE AS skill
FROM students s,
     TABLE(s.skills) sk
ORDER BY s.person_id, sk.COLUMN_VALUE;

PROMPT Adding a new skill using a multiset operation

UPDATE students s
   SET s.skills = s.skills MULTISET UNION DISTINCT skill_nt_t('Object SQL')
 WHERE s.person_id = 100;

COMMIT;

SELECT s.name,
       sk.COLUMN_VALUE AS skill
FROM students s,
     TABLE(s.skills) sk
WHERE s.person_id = 100
ORDER BY sk.COLUMN_VALUE;
