-- 14-dbms-sql-package.sql
--
-- Goal:
--   Demonstrate DBMS_SQL for dynamic SQL when the select list is not known
--   until run time.

SET SERVEROUTPUT ON

DECLARE
    v_cursor   INTEGER;
    v_col_cnt  INTEGER;
    v_desc_tab DBMS_SQL.DESC_TAB2;
    v_sql      VARCHAR2(4000);
    v_value    VARCHAR2(4000);
    v_status   INTEGER;
BEGIN
    v_sql := 'SELECT student_id, name, city FROM course_student ORDER BY student_id';

    v_cursor := DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.PARSE(v_cursor, v_sql, DBMS_SQL.NATIVE);
    DBMS_SQL.DESCRIBE_COLUMNS2(v_cursor, v_col_cnt, v_desc_tab);

    FOR i IN 1 .. v_col_cnt LOOP
        DBMS_OUTPUT.PUT_LINE('Column ' || i || ': ' || v_desc_tab(i).col_name);
        DBMS_SQL.DEFINE_COLUMN(v_cursor, i, v_value, 4000);
    END LOOP;

    v_status := DBMS_SQL.EXECUTE(v_cursor);

    WHILE DBMS_SQL.FETCH_ROWS(v_cursor) > 0 LOOP
        FOR i IN 1 .. v_col_cnt LOOP
            DBMS_SQL.COLUMN_VALUE(v_cursor, i, v_value);
            DBMS_OUTPUT.PUT(v_desc_tab(i).col_name || '=' || v_value || ' ');
        END LOOP;
        DBMS_OUTPUT.NEW_LINE;
    END LOOP;

    DBMS_SQL.CLOSE_CURSOR(v_cursor);
END;
/
