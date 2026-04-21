# Database Applications (KIV/DBA): Oracle Database PL/SQL Examples

This repository provides a step-by-step introduction to PL/SQL in Oracle.

The examples are intentionally small and focused. Most of them use the same table `COURSE_STUDENT` as the [Embedded SQL](https://github.com/vcelakp/kiv-dba-embedded-sql):

- `COURSE_STUDENT(student_id, name, city, grade, note)`

Additional supporting objects are only where they make the examples clearer:

- `COURSE_STUDENT_SEQ`
- `COURSE_STUDENT_AUDIT`
- package objects and helper procedures/functions.

The examples/files numbers allows a natural progression from basics, such as anonymous blocks, to advanced PL/SQL topics, such as stored program units.

Most scripts enable `SERVEROUTPUT`, so you should see text output produced by `DBMS_OUTPUT.PUT_LINE`.

## Topics covered

The set of SQL scripts covers the following topics:

- PL/SQL block structure,
- variables, constants, and data types,
- executable statements in a block,
- nested blocks and scope,
- control structures (`IF`, `CASE`, loops),
- exceptions and user-defined errors,
- records and `%ROWTYPE`,
- implicit and explicit cursors,
- parameterised cursors and cursor `FOR` loops,
- collections, `BULK COLLECT`, and `FORALL`,
- stored procedures and functions,
- packages,
- native dynamic SQL (`EXECUTE IMMEDIATE`, `OPEN FOR`),
- `DBMS_SQL` for fully dynamic statements,
- sequences,
- triggers,
- access control basics (`GRANT`, `AUTHID DEFINER`, `AUTHID CURRENT_USER`),
- compilation, recompilation, debugging, and `USER_ERRORS`,
- autonomous transactions.

## Recommended order of scripts

1. [`00-schema-setup.sql`](00-schema-setup.sql)  
   **Goal:** Prepare the shared schema objects used by the whole PL/SQL example set.  
   **Practice:** creating tables, inserting sample data, and creating supporting objects.  
   **Key elements:** `CREATE TABLE`, `INSERT`, `CREATE SEQUENCE`, shared objects for later scripts

2. [`01-anonymous-block-basics.sql`](01-anonymous-block-basics.sql)  
   **Goal:** Understand the structure of a basic PL/SQL anonymous block.  
   **Practice:** writing and executing a minimal `DECLARE ... BEGIN ... END;` block.  
   **Key elements:** anonymous block, `BEGIN`, `END`, `NULL;`

3. [`02-variables-constants-and-output.sql`](02-variables-constants-and-output.sql)  
   **Goal:** Learn how to declare variables and constants and print values from PL/SQL.  
   **Practice:** scalar declarations, assignments, constants, and console output.  
   **Key elements:** `DECLARE`, variables, `CONSTANT`, `:=`, `DBMS_OUTPUT.PUT_LINE`

4. [`03-control-flow-and-nested-blocks.sql`](03-control-flow-and-nested-blocks.sql)  
   **Goal:** Practice basic control flow and nested PL/SQL blocks.  
   **Practice:** conditions, loops, local scope, and block nesting.  
   **Key elements:** `IF`, `ELSIF`, `CASE`, `LOOP`, `WHILE`, `FOR`, nested `BEGIN ... END`

5. [`04-exceptions-and-user-defined-errors.sql`](04-exceptions-and-user-defined-errors.sql)  
   **Goal:** Understand exception handling in PL/SQL, including user-defined errors.  
   **Practice:** catching predefined exceptions, raising custom exceptions, and controlled error reporting.  
   **Key elements:** `EXCEPTION`, `WHEN`, `RAISE`, user-defined exception, `RAISE_APPLICATION_ERROR`

6. [`05-records-and-rowtypes.sql`](05-records-and-rowtypes.sql)  
   **Goal:** Work with structured PL/SQL data using records and row types.  
   **Practice:** declaring record variables and fetching whole rows into structured variables.  
   **Key elements:** `%ROWTYPE`, `TYPE ... IS RECORD`, record fields, `SELECT ... INTO`

7. [`06-implicit-and-explicit-cursors.sql`](06-implicit-and-explicit-cursors.sql)  
   **Goal:** Compare implicit and explicit cursor processing in PL/SQL.  
   **Practice:** single-row processing, multi-row processing, and cursor lifecycle.  
   **Key elements:** implicit cursor, explicit cursor, `OPEN`, `FETCH`, `CLOSE`, cursor attributes like `SQL%ROWCOUNT`

8. [`07-parameterized-cursors-and-cursor-for-loop.sql`](07-parameterized-cursors-and-cursor-for-loop.sql)  
   **Goal:** Use cursor parameters and simplify iteration with cursor `FOR` loops.  
   **Practice:** passing values into cursors and writing cleaner row-processing loops.  
   **Key elements:** parameterised cursor, cursor `FOR` loop, `%NOTFOUND`, host-style filtering logic

9. [`08-collections-bulk-collect-forall.sql`](08-collections-bulk-collect-forall.sql)  
   **Goal:** Introduce PL/SQL collections and bulk SQL processing.  
   **Practice:** fetching rows into collections and performing bulk DML efficiently.  
   **Key elements:** collection types, associative array / nested table / varray, `BULK COLLECT`, `FORALL`

10. [`09-stored-procedure.sql`](09-stored-procedure.sql)  
    **Goal:** Create and execute a stored procedure.  
    **Practice:** parameter passing and encapsulating reusable database logic.  
    **Key elements:** `CREATE OR REPLACE PROCEDURE`, `IN`, `OUT`, `IN OUT`, procedure call

11. [`10-stored-function.sql`](10-stored-function.sql)  
    **Goal:** Create and use a stored function that returns a value.  
    **Practice:** returning computed results and calling functions from PL/SQL and SQL contexts where appropriate.  
    **Key elements:** `CREATE OR REPLACE FUNCTION`, `RETURN`, function invocation

12. [`11-packages.sql`](11-packages.sql)  
    **Goal:** Group related procedures, functions, constants, and types into a package.  
    **Practice:** separating specification and body and organising reusable PL/SQL APIs.  
    **Key elements:** `CREATE PACKAGE`, `CREATE PACKAGE BODY`, public vs private elements, package state

13. [`12-dynamic-sql-execute-immediate.sql`](12-dynamic-sql-execute-immediate.sql)  
    **Goal:** Use native dynamic SQL for statements known only at runtime.  
    **Practice:** executing dynamic DDL or DML and binding values safely.  
    **Key elements:** `EXECUTE IMMEDIATE`, `USING`, dynamic `INSERT` / `UPDATE` / DDL

14. [`13-ref-cursors-open-for.sql`](13-ref-cursors-open-for.sql)  
    **Goal:** Return query results dynamically through REF CURSORS.  
    **Practice:** opening queries at runtime and fetching rows from cursor variables.  
    **Key elements:** `REF CURSOR`, cursor variable, `OPEN ... FOR`, `FETCH`, `CLOSE`

15. [`14-dbms-sql-package.sql`](14-dbms-sql-package.sql)  
    **Goal:** Introduce `DBMS_SQL` for fully dynamic SQL scenarios.  
    **Practice:** parsing statements, binding variables, describing columns, and executing unknown query structures.  
    **Key elements:** `DBMS_SQL.OPEN_CURSOR`, `PARSE`, `BIND_VARIABLE`, `DESCRIBE_COLUMNS`, `EXECUTE`

16. [`15-sequences.sql`](15-sequences.sql)  
    **Goal:** Generate unique keys using Oracle sequences.  
    **Practice:** creating sequences and using them in DML statements.  
    **Key elements:** `CREATE SEQUENCE`, `NEXTVAL`, `CURRVAL`, generated identifiers

17. [`16-triggers-and-audit.sql`](16-triggers-and-audit.sql)  
    **Goal:** Understand how triggers react to table events and support auditing.  
    **Practice:** row-level trigger logic, audit table population, and automatic reaction to DML.  
    **Key elements:** `CREATE TRIGGER`, `BEFORE` / `AFTER`, `INSERT` / `UPDATE` / `DELETE`, `:OLD`, `:NEW`

18. [`17-rights-authid-and-grants.sql`](17-rights-authid-and-grants.sql)  
    **Goal:** Learn how PL/SQL units execute with definer's rights or invoker's rights, and how privileges affect them.  
    **Practice:** comparing execution models and assigning access rights.  
    **Key elements:** `AUTHID DEFINER`, `AUTHID CURRENT_USER`, `GRANT`, execution privileges

19. [`18-compilation-debug-and-user-errors.sql`](18-compilation-debug-and-user-errors.sql)  
    **Goal:** Understand PL/SQL compilation diagnostics and basic debugging workflow.  
    **Practice:** compiling invalid objects intentionally, inspecting errors, and correcting them.  
    **Key elements:** `SHOW ERRORS`, `USER_ERRORS`, recompilation, diagnostic workflow

20. [`19-autonomous-transaction-logging.sql`](19-autonomous-transaction-logging.sql)  
    **Goal:** Demonstrate autonomous transactions for independent logging or audit operations.  
    **Practice:** writing log records that commit independently of the caller's transaction.  
    **Key elements:** `PRAGMA AUTONOMOUS_TRANSACTION`, logging procedure, independent `COMMIT`

21. [`99-cleanup.sql`](99-cleanup.sql) *(optional cleanup)*  
    **Goal:** Remove the schema objects created for the example set.  
    **Practice:** cleaning up tables, procedures, functions, packages, triggers, and sequences after the lab.  
    **Key elements:** `DROP` statements, cleanup script, resetting the environment

## Notes

- Script `17-rights-authid-and-grants.sql` is partly demonstrational. To observe the difference between definer's rights and invoker's rights in practice, it is best to use two schemas.
- Script `18-compilation-debug-and-user-errors.sql` intentionally creates one invalid procedure first, shows the compilation errors, and then replaces it with a corrected version.
- The `19-autonomous-transaction-logging.sql` script displays the `PRAGMA AUTONOMOUS_TRANSACTION` command, which is often associated with logging and trigger design.
