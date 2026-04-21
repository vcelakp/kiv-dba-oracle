-- 09-object-comparison-and-ordering.sql
--
-- Goal:
--   Compare and order object instances.
--

SET SERVEROUTPUT ON

PROMPT Ordering rows by whole object value using the MAP method

SELECT s.person_id,
       s.name
FROM students s
ORDER BY VALUE(s);

PROMPT Comparing two object instances in PL/SQL

DECLARE
    v_first  student_t;
    v_second student_t;
BEGIN
    SELECT VALUE(s)
      INTO v_first
      FROM students s
     WHERE s.person_id = 100;

    SELECT VALUE(s)
      INTO v_second
      FROM students s
     WHERE s.person_id = 101;

    IF v_first < v_second THEN
        DBMS_OUTPUT.PUT_LINE(v_first.name || ' sorts before ' || v_second.name);
    ELSE
        DBMS_OUTPUT.PUT_LINE(v_second.name || ' sorts before ' || v_first.name);
    END IF;
END;
/
