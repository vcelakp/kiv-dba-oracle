-- 18-compilation-debug-and-user-errors.sql
--
-- Goal:
--   Demonstrate compilation errors, SHOW ERRORS, USER_ERRORS,
--   recompilation, and COMPILE DEBUG.

SET SERVEROUTPUT ON

PROMPT Creating an invalid procedure on purpose...

CREATE OR REPLACE PROCEDURE course_bad_proc
AS
BEGIN
    DBMS_OUTPUT.PUT_LINE(undefined_variable);
END;
/
SHOW ERRORS PROCEDURE course_bad_proc

PROMPT Querying USER_ERRORS...
COLUMN name FORMAT A20
COLUMN type FORMAT A12
COLUMN text FORMAT A60 WORD_WRAPPED

SELECT name, type, line, position, text
FROM user_errors
WHERE name = 'COURSE_BAD_PROC'
ORDER BY sequence;

PROMPT Replacing the procedure with a valid version...
CREATE OR REPLACE PROCEDURE course_bad_proc
AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Procedure is valid now');
END;

/
SHOW ERRORS PROCEDURE course_bad_proc

ALTER PROCEDURE course_bad_proc COMPILE DEBUG;

SELECT name, type, plsql_debug
FROM user_plsql_object_settings
WHERE name = 'COURSE_BAD_PROC';

BEGIN
    course_bad_proc;
END;
/
