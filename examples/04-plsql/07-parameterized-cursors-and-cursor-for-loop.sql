-- 07-parameterized-cursors-and-cursor-for-loop.sql
--
-- Goal:
--   Demonstrate a parameterized cursor and a cursor FOR loop.

SET SERVEROUTPUT ON

DECLARE
    CURSOR c_students_by_city (p_city course_student.city%TYPE) IS
        SELECT student_id, name, grade
        FROM course_student
        WHERE city = p_city
        ORDER BY name;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Students from Brno:');
    FOR rec IN c_students_by_city('Brno') LOOP
        DBMS_OUTPUT.PUT_LINE('  '
            || rec.student_id || ' '
            || rec.name || ' grade='
            || NVL(TO_CHAR(rec.grade), 'NULL'));
    END LOOP;
END;
/
