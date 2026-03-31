-- 10-stored-function.sql
--
-- Goal:
--   Create and run a stored function from PL/SQL and from SQL.

SET SERVEROUTPUT ON

CREATE OR REPLACE FUNCTION course_grade_label (
    p_grade IN NUMBER
) RETURN VARCHAR2
AS
BEGIN
    IF p_grade IS NULL THEN
        RETURN 'NO GRADE';
    ELSIF p_grade <= 1.5 THEN
        RETURN 'EXCELLENT';
    ELSIF p_grade <= 2.5 THEN
        RETURN 'GOOD';
    ELSE
        RETURN 'NEEDS IMPROVEMENT';
    END IF;
END;
/
SHOW ERRORS

DECLARE
    v_label VARCHAR2(30);
BEGIN
    v_label := course_grade_label(2.7);
    DBMS_OUTPUT.PUT_LINE('Function call from PL/SQL -> ' || v_label);
END;
/

SELECT student_id,
       name,
       grade,
       course_grade_label(grade) AS label
FROM course_student
ORDER BY student_id;
