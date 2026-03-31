-- 04-exceptions-and-user-defined-errors.sql
--
-- Goal:
--   Demonstrate predefined exceptions, user-defined exceptions,
--   and RAISE_APPLICATION_ERROR.

SET SERVEROUTPUT ON

DECLARE
    v_name course_student.name%TYPE;
    e_missing_grade EXCEPTION;
    v_grade course_student.grade%TYPE;
BEGIN
    BEGIN
        SELECT name
        INTO v_name
        FROM course_student
        WHERE student_id = 999;

        DBMS_OUTPUT.PUT_LINE('Student: ' || v_name);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('NO_DATA_FOUND handled for student_id = 999');
    END;

    BEGIN
        SELECT grade
        INTO v_grade
        FROM course_student
        WHERE student_id = 3;

        IF v_grade IS NULL THEN
            RAISE e_missing_grade;
        END IF;

        DBMS_OUTPUT.PUT_LINE('Grade = ' || v_grade);
    EXCEPTION
        WHEN e_missing_grade THEN
            DBMS_OUTPUT.PUT_LINE('User-defined exception: student has no grade yet');
            RAISE_APPLICATION_ERROR(-20001, 'Grade is required for this operation');
    END;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Outer handler: ' || SQLERRM);
END;
/
