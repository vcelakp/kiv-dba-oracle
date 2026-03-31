-- 13-ref-cursors-open-for.sql
--
-- Goal:
--   Demonstrate SYS_REFCURSOR and OPEN FOR with a dynamic query.

SET SERVEROUTPUT ON

DECLARE
    v_rc SYS_REFCURSOR;
    v_sql VARCHAR2(4000);
    v_city VARCHAR2(50) := 'Brno';
    v_id course_student.student_id%TYPE;
    v_name course_student.name%TYPE;
BEGIN
    v_sql := 'SELECT student_id, name
              FROM course_student
              WHERE city = :city
              ORDER BY student_id';

    OPEN v_rc FOR v_sql USING v_city;

    LOOP
        FETCH v_rc INTO v_id, v_name;
        EXIT WHEN v_rc%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_id || ' -> ' || v_name);
    END LOOP;

    CLOSE v_rc;
END;
/
