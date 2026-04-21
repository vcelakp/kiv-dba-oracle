-- 01-anonymous-block-basics.sql
--
-- Goal:
--   Show the structure of a basic anonymous PL/SQL block.

SET SERVEROUTPUT ON

DECLARE
    v_message VARCHAR2(100) := 'Hello from PL/SQL';
BEGIN
    DBMS_OUTPUT.PUT_LINE(v_message);
    DBMS_OUTPUT.PUT_LINE('Current user: ' || USER);
    DBMS_OUTPUT.PUT_LINE('Current date: ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'));
END;
/
