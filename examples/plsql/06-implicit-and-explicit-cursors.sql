-- 06-implicit-and-explicit-cursors.sql
--
-- Goal:
--   Compare implicit cursor attributes with explicit cursor processing.

SET SERVEROUTPUT ON

DECLARE
    CURSOR c_students IS
        SELECT student_id, name, city
        FROM course_student
        ORDER BY student_id;

    v_id   course_student.student_id%TYPE;
    v_name course_student.name%TYPE;
    v_city course_student.city%TYPE;
BEGIN
    UPDATE course_student
    SET note = 'checked'
    WHERE city = 'Praha';

    DBMS_OUTPUT.PUT_LINE('Implicit cursor SQL%ROWCOUNT = ' || SQL%ROWCOUNT);

    OPEN c_students;
    LOOP
        FETCH c_students INTO v_id, v_name, v_city;
        EXIT WHEN c_students%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Explicit cursor -> '
            || v_id || ', ' || v_name || ', ' || v_city);
    END LOOP;
    CLOSE c_students;

    ROLLBACK;
END;
/
