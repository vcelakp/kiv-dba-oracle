-- 02-object-methods.sql
--
-- Goal:
--   Practice member methods and static methods.
--

SET SERVEROUTPUT ON

PROMPT Member methods in SQL

SELECT s.student_no,
       s.summary() AS summary,
       s.average_grade() AS average_grade,
       s.passed_count() AS passed_count
FROM students s
ORDER BY s.person_id;

PROMPT Member and static methods together

SELECT c.code,
       c.label() AS member_label,
       course_t.make_label(c.code, c.title) AS static_label
FROM courses c
ORDER BY c.course_id;

PROMPT Method call in PL/SQL

DECLARE
    v_student student_t;
BEGIN
    SELECT VALUE(s)
      INTO v_student
      FROM students s
     WHERE s.person_id = 100;

    DBMS_OUTPUT.PUT_LINE(v_student.summary());
    DBMS_OUTPUT.PUT_LINE('Average grade = ' || NVL(TO_CHAR(v_student.average_grade()), 'NULL'));
END;
/
