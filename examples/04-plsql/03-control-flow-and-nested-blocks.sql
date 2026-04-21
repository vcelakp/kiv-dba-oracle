-- 03-control-flow-and-nested-blocks.sql
--
-- Goal:
--   Demonstrate IF, CASE, FOR loop, WHILE loop, and nested block scope.

SET SERVEROUTPUT ON

DECLARE
    v_grade NUMBER := 2.7;
    v_counter NUMBER := 1;
BEGIN
    IF v_grade IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('Grade is NULL');
    ELSIF v_grade <= 1.5 THEN
        DBMS_OUTPUT.PUT_LINE('Excellent result');
    ELSIF v_grade <= 2.5 THEN
        DBMS_OUTPUT.PUT_LINE('Good result');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Needs improvement');
    END IF;

    CASE
        WHEN v_grade < 2 THEN DBMS_OUTPUT.PUT_LINE('CASE: strong result');
        WHEN v_grade < 3 THEN DBMS_OUTPUT.PUT_LINE('CASE: acceptable result');
        ELSE DBMS_OUTPUT.PUT_LINE('CASE: weak result');
    END CASE;

    FOR i IN 1..3 LOOP
        DBMS_OUTPUT.PUT_LINE('FOR loop iteration ' || i);
    END LOOP;

    WHILE v_counter <= 2 LOOP
        DBMS_OUTPUT.PUT_LINE('WHILE loop iteration ' || v_counter);
        v_counter := v_counter + 1;
    END LOOP;

    DECLARE
        v_local_message VARCHAR2(50) := 'Inside nested block';
    BEGIN
        DBMS_OUTPUT.PUT_LINE(v_local_message);
    END;

    DBMS_OUTPUT.PUT_LINE('Nested block finished');
END;
/
