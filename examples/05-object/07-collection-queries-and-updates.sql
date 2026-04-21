-- 07-collection-queries-and-updates.sql
--
-- Goal:
--   Query and modify nested tables of object values.
--

SET SERVEROUTPUT ON

PROMPT Querying nested-table elements of an object type

SELECT s.student_no,
       DEREF(g.course_ref).code AS course_code,
       g.grade,
       g.passed() AS passed
FROM students s,
     TABLE(s.grades) g
ORDER BY s.student_no, course_code;

PROMPT Inserting a new nested-table element

INSERT INTO TABLE(
    SELECT s.grades
    FROM students s
    WHERE s.person_id = 102
)
SELECT grade_entry_t(REF(c), 2.5)
FROM courses c
WHERE c.course_id = 2;

COMMIT;

PROMPT Updating one nested-table element

UPDATE TABLE(
    SELECT s.grades
    FROM students s
    WHERE s.person_id = 100
) g
   SET g.grade = 1.5
 WHERE g.grade = 2.0;

COMMIT;

PROMPT Grades after modification

SELECT s.student_no,
       DEREF(g.course_ref).code AS course_code,
       g.grade
FROM students s,
     TABLE(s.grades) g
WHERE s.person_id IN (100, 102)
ORDER BY s.student_no, course_code;
