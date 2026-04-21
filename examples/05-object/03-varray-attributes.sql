-- 03-varray-attributes.sql
--
-- Goal:
--   Work with arrays stored as object attributes.
--

SET SERVEROUTPUT ON

PROMPT Querying VARRAY elements with TABLE()

SELECT s.name,
       p.COLUMN_VALUE AS phone
FROM students s,
     TABLE(s.phones) p
ORDER BY s.person_id, p.COLUMN_VALUE;

PROMPT Updating a VARRAY attribute

UPDATE students s
   SET s.phones = phone_varray_t('777-300-300', '777-300-301')
 WHERE s.person_id = 102;

COMMIT;

SELECT s.name,
       p.COLUMN_VALUE AS phone
FROM students s,
     TABLE(s.phones) p
WHERE s.person_id = 102
ORDER BY p.COLUMN_VALUE;
