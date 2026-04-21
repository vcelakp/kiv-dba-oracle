-- 09-stored-procedure.sql
--
-- Goal:
--   Create and run a stored procedure.

SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE course_print_student (
    p_student_id IN course_student.student_id%TYPE
)
AS
    v_student course_student%ROWTYPE;
BEGIN
    SELECT *
    INTO v_student
    FROM course_student
    WHERE student_id = p_student_id;

    DBMS_OUTPUT.PUT_LINE('Student #' || v_student.student_id
                         || ': ' || v_student.name
                         || ', city=' || v_student.city
                         || ', grade=' || NVL(TO_CHAR(v_student.grade), 'NULL')
                         || ', note=' || NVL(v_student.note, 'NULL'));
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No student found for id=' || p_student_id);
END;
/
SHOW ERRORS

BEGIN
    course_print_student(1);
    course_print_student(999);
END;
/
