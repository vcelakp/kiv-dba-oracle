-- 08-collections-bulk-collect-forall.sql
--
-- Goal:
--   Demonstrate collections, BULK COLLECT, and FORALL.

SET SERVEROUTPUT ON

DECLARE
    TYPE id_tab_t IS TABLE OF course_student.student_id%TYPE INDEX BY PLS_INTEGER;
    TYPE note_tab_t IS TABLE OF course_student.note%TYPE INDEX BY PLS_INTEGER;

    v_ids   id_tab_t;
    v_notes note_tab_t;
BEGIN
    SELECT student_id, NVL(note, 'no note')
    BULK COLLECT INTO v_ids, v_notes
    FROM course_student
    ORDER BY student_id;

    DBMS_OUTPUT.PUT_LINE('Rows loaded with BULK COLLECT: ' || v_ids.COUNT);

    FOR i IN 1 .. v_ids.COUNT LOOP
        v_notes(i) := 'bulk-' || v_notes(i);
    END LOOP;

    FORALL i IN 1 .. v_ids.COUNT
        UPDATE course_student
        SET note = v_notes(i)
        WHERE student_id = v_ids(i);

    DBMS_OUTPUT.PUT_LINE('Rows updated by FORALL: ' || SQL%ROWCOUNT);

    ROLLBACK;
END;
/
