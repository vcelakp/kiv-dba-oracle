-- 17-rights-authid-and-grants.sql
--
-- Goal:
--   Demonstrate definer's rights, invoker's rights, and simple GRANT usage.
--
-- Note:
--   The GRANT statement can be executed only by the object owner (or DBA).
--   To observe the full difference between AUTHID DEFINER and AUTHID CURRENT_USER,
--   use two schemas.

SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE course_show_user_definer
AUTHID DEFINER
AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('DEFINER rights procedure');
    DBMS_OUTPUT.PUT_LINE('SESSION_USER=' || SYS_CONTEXT('USERENV', 'SESSION_USER'));
    DBMS_OUTPUT.PUT_LINE('CURRENT_SCHEMA=' || SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA'));
    DBMS_OUTPUT.PUT_LINE('CURRENT_USER=' || SYS_CONTEXT('USERENV', 'CURRENT_USER'));
END;
/
SHOW ERRORS

CREATE OR REPLACE PROCEDURE course_show_user_invoker
AUTHID CURRENT_USER
AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('INVOKER rights procedure');
    DBMS_OUTPUT.PUT_LINE('SESSION_USER=' || SYS_CONTEXT('USERENV', 'SESSION_USER'));
    DBMS_OUTPUT.PUT_LINE('CURRENT_SCHEMA=' || SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA'));
    DBMS_OUTPUT.PUT_LINE('CURRENT_USER=' || SYS_CONTEXT('USERENV', 'CURRENT_USER'));
END;
/
SHOW ERRORS

GRANT EXECUTE ON course_show_user_definer TO PUBLIC;
GRANT EXECUTE ON course_show_user_invoker TO PUBLIC;

BEGIN
    course_show_user_definer;
    course_show_user_invoker;
END;
/

PROMPT To continue the access-control example from another schema:
PROMPT   EXEC owner_name.course_show_user_definer;
PROMPT   EXEC owner_name.course_show_user_invoker;
