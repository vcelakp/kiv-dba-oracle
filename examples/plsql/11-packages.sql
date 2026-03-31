-- 11-packages.sql
--
-- Goal:
--   Demonstrate package specification, package body, constants,
--   procedures, functions, and package state.

SET SERVEROUTPUT ON

CREATE OR REPLACE PACKAGE course_student_api AUTHID DEFINER AS
    c_default_city CONSTANT VARCHAR2(50) := 'Praha';

    PROCEDURE add_student (
        p_name IN course_student.name%TYPE,
        p_city      IN course_student.city%TYPE DEFAULT c_default_city,
        p_grade     IN course_student.grade%TYPE DEFAULT NULL,
        p_note      IN course_student.note%TYPE DEFAULT NULL
    );

    FUNCTION student_count RETURN NUMBER;

    FUNCTION find_city (
        p_student_id IN course_student.student_id%TYPE
    ) RETURN VARCHAR2;
END course_student_api;
/
SHOW ERRORS

CREATE OR REPLACE PACKAGE BODY course_student_api AS
    g_call_count NUMBER := 0;

    PROCEDURE add_student (
        p_name IN course_student.name%TYPE,
        p_city      IN course_student.city%TYPE DEFAULT c_default_city,
        p_grade     IN course_student.grade%TYPE DEFAULT NULL,
        p_note      IN course_student.note%TYPE DEFAULT NULL
    )
    AS
    BEGIN
        g_call_count := g_call_count + 1;

        INSERT INTO course_student(student_id, name, city, grade, note)
        VALUES (course_student_seq.NEXTVAL, p_name, p_city, p_grade, p_note);
    END add_student;

    FUNCTION student_count RETURN NUMBER
    AS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM course_student;

        RETURN v_count;
    END student_count;

    FUNCTION find_city (
        p_student_id IN course_student.student_id%TYPE
    ) RETURN VARCHAR2
    AS
        v_city course_student.city%TYPE;
    BEGIN
        SELECT city
        INTO v_city
        FROM course_student
        WHERE student_id = p_student_id;

        RETURN v_city;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END find_city;
END course_student_api;
/
SHOW ERRORS

BEGIN
    course_student_api.add_student('Bruce', 'Plzen', 1.9, 'from package');
    DBMS_OUTPUT.PUT_LINE('Student count after insert: ' || course_student_api.student_count);
    DBMS_OUTPUT.PUT_LINE('City for student 1: ' || course_student_api.find_city(1));
    ROLLBACK;
END;
/
