-- 12-dynamic-sql-execute-immediate.sql
--
-- Goal:
--   Demonstrate native dynamic SQL with EXECUTE IMMEDIATE.

SET SERVEROUTPUT ON

DECLARE
    v_sql   VARCHAR2(4000);
    v_count NUMBER;
    v_city  VARCHAR2(50) := 'Brno';
BEGIN
    v_sql := 'SELECT COUNT(*) FROM course_student WHERE city = :x';
    EXECUTE IMMEDIATE v_sql INTO v_count USING v_city;

    DBMS_OUTPUT.PUT_LINE('Students in ' || v_city || ': ' || v_count);

    v_sql := 'UPDATE course_student SET note = :new_note WHERE city = :city_name';
    EXECUTE IMMEDIATE v_sql USING 'updated dynamically', v_city;

    DBMS_OUTPUT.PUT_LINE('Rows changed dynamically: ' || SQL%ROWCOUNT);

    ROLLBACK;
END;
/
