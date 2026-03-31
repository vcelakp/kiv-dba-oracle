-- 15-sequences.sql
--
-- Goal:
--   Demonstrate the use of a sequence for generating primary keys.

SET SERVEROUTPUT ON

DECLARE
    v_new_id NUMBER;
BEGIN
    v_new_id := course_student_seq.NEXTVAL;

    INSERT INTO course_student(student_id, name, city, grade, note)
    VALUES (v_new_id, 'Sequence Demo Student', 'Praha', 2.3, 'created by sequence');

    DBMS_OUTPUT.PUT_LINE('Inserted student with id=' || v_new_id);

    ROLLBACK;
END;
/
