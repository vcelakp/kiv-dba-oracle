-- 19-autonomous-transaction-logging.sql
--
-- Goal:
--   Demonstrate PRAGMA AUTONOMOUS_TRANSACTION for independent logging.

SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE course_log_message (
    p_action_name IN VARCHAR2,
    p_student_id  IN NUMBER,
    p_old_note    IN VARCHAR2,
    p_new_note    IN VARCHAR2
)
AS
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    INSERT INTO course_student_audit(action_name, student_id, old_note, new_note)
    VALUES (p_action_name, p_student_id, p_old_note, p_new_note);
    COMMIT;
END;
/
SHOW ERRORS

BEGIN
    course_log_message('AUTOLOG', 1, 'old note', 'new note from autonomous txn');

    UPDATE course_student
    SET note = 'temporary local change'
    WHERE student_id = 1;
    ROLLBACK;
END;
/

PROMPT The student row rollback does not remove the autonomous log row.
SELECT action_name, student_id, old_note, new_note
FROM course_student_audit
WHERE action_name = 'AUTOLOG'
ORDER BY audit_id;
