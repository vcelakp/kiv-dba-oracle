-- 05-records-and-rowtypes.sql
--
-- Goal:
--   Demonstrate user-defined records and %ROWTYPE.

SET SERVEROUTPUT ON

DECLARE
    TYPE student_brief_rec IS RECORD (
        name course_student.name%TYPE,
        city      course_student.city%TYPE
    );

    v_brief student_brief_rec;
    v_student course_student%ROWTYPE;
BEGIN
    SELECT name, city
    INTO v_brief
    FROM course_student
    WHERE student_id = 1;

    DBMS_OUTPUT.PUT_LINE('Brief record -> ' || v_brief.name || ', ' || v_brief.city);

    SELECT *
    INTO v_student
    FROM course_student
    WHERE student_id = 2;

    DBMS_OUTPUT.PUT_LINE('%ROWTYPE -> id=' || v_student.student_id
                         || ', name=' || v_student.name
                         || ', city=' || v_student.city
                         || ', grade=' || NVL(TO_CHAR(v_student.grade), 'NULL')
                         || ', note=' || NVL(v_student.note, 'NULL'));
END;
/
