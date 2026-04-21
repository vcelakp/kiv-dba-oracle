-- 06-refs-and-derefs.sql
--
-- Goal:
--   Navigate object references.
--
SET SERVEROUTPUT ON

PROMPT Navigating a REF attribute with DEREF

SELECT s.student_no,
       s.name,
       DEREF(s.advisor_ref).name AS advisor_name,
       DEREF(s.advisor_ref).office_no AS advisor_office
FROM students s
ORDER BY s.person_id;

PROMPT Navigating REFs stored inside a nested table of objects

SELECT s.student_no,
       DEREF(g.course_ref).code  AS course_code,
       DEREF(g.course_ref).title AS course_title,
       g.grade
FROM students s,
     TABLE(s.grades) g
ORDER BY s.student_no, course_code;
