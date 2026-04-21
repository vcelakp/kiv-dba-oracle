-- 01-object-types-and-constructors.sql
--
-- Goal:
--   Understand basic object constructors and attribute access. 
--

SET SERVEROUTPUT ON

PROMPT 1) Standalone object constructors

SELECT address_t('Technicka 8', 'Plzen', '30100').to_text() AS address_text
FROM dual;

SELECT course_t.make_label('KIV/DBA', 'Database Applications') AS static_label
FROM dual;

PROMPT 2) Accessing object attributes in an object table

SELECT s.person_id,
       s.name,
       s.student_no,
       s.home_address.city AS city
FROM students s
ORDER BY s.person_id;

PROMPT 3) Selecting and using a full object value

SELECT VALUE(c).label() AS course_label
FROM courses c
ORDER BY c.course_id;
