-- all.sql
--
-- Goal:
--   Run all Oracle PL/SQL examples.

SET SERVEROUTPUT ON

PROMPT ##################################################
PROMPT === all.sql                                    ===
PROMPT ##################################################


PROMPT
PROMPT ##################################################
PROMPT === 00-schema-setup.sql
PROMPT ##################################################

@@00-schema-setup.sql

PROMPT
PROMPT ##################################################
PROMPT === 01-anonymous-block-basics.sql
PROMPT ##################################################

@@01-anonymous-block-basics.sql

PROMPT
PROMPT ##################################################
PROMPT === 02-variables-constants-and-output.sql
PROMPT ##################################################

@@02-variables-constants-and-output.sql

PROMPT
PROMPT ##################################################
PROMPT === 03-control-flow-and-nested-blocks.sql
PROMPT ##################################################

@@03-control-flow-and-nested-blocks.sql

PROMPT
PROMPT ##################################################
PROMPT === 04-exceptions-and-user-defined-errors.sql
PROMPT ##################################################

@@04-exceptions-and-user-defined-errors.sql

PROMPT
PROMPT ##################################################
PROMPT === 05-records-and-rowtypes.sql
PROMPT ##################################################

@@05-records-and-rowtypes.sql

PROMPT
PROMPT ##################################################
PROMPT === 06-implicit-and-explicit-cursors.sql
PROMPT ##################################################

@@06-implicit-and-explicit-cursors.sql

PROMPT
PROMPT ##################################################
PROMPT === 07-parameterized-cursors-and-cursor-for-loop.sql
PROMPT ##################################################

@@07-parameterized-cursors-and-cursor-for-loop.sql

PROMPT
PROMPT ##################################################
PROMPT === 08-collections-bulk-collect-forall.sql
PROMPT ##################################################

@@08-collections-bulk-collect-forall.sql

PROMPT
PROMPT ##################################################
PROMPT === 09-stored-procedure.sql
PROMPT ##################################################

@@09-stored-procedure.sql

PROMPT
PROMPT ##################################################
PROMPT === 10-stored-function.sql
PROMPT ##################################################

@@10-stored-function.sql

PROMPT
PROMPT ##################################################
PROMPT === 11-packages.sql
PROMPT ##################################################

@@11-packages.sql

PROMPT
PROMPT ##################################################
PROMPT === 12-dynamic-sql-execute-immediate.sql
PROMPT ##################################################

@@12-dynamic-sql-execute-immediate.sql

PROMPT
PROMPT ##################################################
PROMPT === 13-ref-cursors-open-for.sql
PROMPT ##################################################

@@13-ref-cursors-open-for.sql

PROMPT
PROMPT ##################################################
PROMPT === 14-dbms-sql-package.sql
PROMPT ##################################################

@@14-dbms-sql-package.sql

PROMPT
PROMPT ##################################################
PROMPT === 15-sequences.sql
PROMPT ##################################################

@@15-sequences.sql

PROMPT
PROMPT ##################################################
PROMPT === 16-triggers-and-audit.sql
PROMPT ##################################################

@@16-triggers-and-audit.sql

PROMPT
PROMPT ##################################################
PROMPT === 17-rights-authid-and-grants.sql
PROMPT ##################################################

@@17-rights-authid-and-grants.sql

PROMPT
PROMPT ##################################################
PROMPT === 18-compilation-debug-and-user-errors.sql
PROMPT ##################################################

@@18-compilation-debug-and-user-errors.sql

PROMPT
PROMPT ##################################################
PROMPT === 19-autonomous-transaction-logging.sql
PROMPT ##################################################

@@19-autonomous-transaction-logging.sql

PROMPT
PROMPT ##################################################
PROMPT === 99-cleanup.sql
PROMPT ##################################################

@@99-cleanup.sql

PROMPT ##################################################
PROMPT === DONE all.sql                               ===
PROMPT ##################################################
