-- 16-triggers-and-audit.sql
--
-- Goal:
--   Demonstrate a row-level trigger and an audit table.

SET SERVEROUTPUT ON

CREATE OR REPLACE TRIGGER course_student_biu_trg
BEFORE INSERT OR UPDATE OF note ON course_student
FOR EACH ROW
DECLARE
    v_action_name course_student_audit.action_name%TYPE;
BEGIN
    IF INSERTING THEN
        IF :NEW.student_id IS NULL THEN
            :NEW.student_id := course_student_seq.NEXTVAL;
        END IF;
        v_action_name := 'INSERT';
    ELSIF UPDATING THEN
        v_action_name := 'UPDATE';
    END IF;

    INSERT INTO course_student_audit(action_name, student_id, old_note, new_note)
    VALUES (
        v_action_name,
        NVL(:NEW.student_id, :OLD.student_id),
        :OLD.note,
        :NEW.note
    );
END;
/
SHOW ERRORS

SELECT line, position, text
FROM user_errors
WHERE name = 'COURSE_STUDENT_BIU_TRG'
  AND type = 'TRIGGER'
ORDER BY sequence;

SELECT object_name, status
FROM user_objects
WHERE object_name = 'COURSE_STUDENT_BIU_TRG';

ALTER TRIGGER course_student_biu_trg COMPILE;

BEGIN
    UPDATE course_student
    SET note = 'changed by trigger'
    WHERE student_id = 1;

    INSERT INTO course_student(student_id, name, city, grade, note)
    VALUES (NULL, 'Trigger Student', 'Olomouc', 2.4, 'new row');

    DBMS_OUTPUT.PUT_LINE('Audit rows in current transaction:');
    FOR rec IN (
        SELECT action_name, student_id, old_note, new_note
        FROM course_student_audit
        ORDER BY audit_id
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('  ' || rec.action_name
                             || ' student_id=' || rec.student_id
                             || ' old_note=' || NVL(rec.old_note, 'NULL')
                             || ' new_note=' || NVL(rec.new_note, 'NULL'));
    END LOOP;

    ROLLBACK;
END;
/
