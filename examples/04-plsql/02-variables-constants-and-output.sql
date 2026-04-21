-- 02-variables-constants-and-output.sql
--
-- Goal:
--   Demonstrate constants, variables, SELECT INTO, and DBMS_OUTPUT.

SET SERVEROUTPUT ON

DECLARE
    c_city CONSTANT VARCHAR2(50) := 'Brno';
    v_count NUMBER;
    v_avg_grade NUMBER(4,2);
    v_label VARCHAR2(100);
BEGIN
    SELECT COUNT(*), AVG(grade)
    INTO v_count, v_avg_grade
    FROM course_student
    WHERE city = c_city;

    v_label := 'Students in ' || c_city || ': ' || v_count;

    DBMS_OUTPUT.PUT_LINE(v_label);
    DBMS_OUTPUT.PUT_LINE('Average grade in ' || c_city || ': ' || NVL(TO_CHAR(v_avg_grade), 'NULL'));
END;
/
