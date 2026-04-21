-- all-object.sql
--
-- Goal:
--   Run all Oracle object-relatioal examples.

SET SERVEROUTPUT ON

PROMPT ##################################################
PROMPT === all-object.sql                             ===
PROMPT ##################################################

PROMPT
PROMPT ##################################################
PROMPT === 00-schema-setup.sql
PROMPT ##################################################

@@00-schema-setup.sql

PROMPT
PROMPT ##################################################
PROMPT === 01-object-types-and-constructors.sql
PROMPT ##################################################

@@01-object-types-and-constructors.sql

PROMPT
PROMPT ##################################################
PROMPT === 02-object-methods.sql
PROMPT ##################################################

@@02-object-methods.sql

PROMPT
PROMPT ##################################################
PROMPT === 03-varray-attributes.sql
PROMPT ##################################################

@@03-varray-attributes.sql

PROMPT
PROMPT ##################################################
PROMPT === 04-nested-table-attributes.sql
PROMPT ##################################################

@@04-nested-table-attributes.sql

PROMPT
PROMPT ##################################################
PROMPT === 05-object-tables-and-object-columns.sql
PROMPT ##################################################

@@05-object-tables-and-object-columns.sql

PROMPT
PROMPT ##################################################
PROMPT === 06-refs-and-deref.sql
PROMPT ##################################################

@@06-refs-and-deref.sql

PROMPT
PROMPT ##################################################
PROMPT === 07-collection-queries-and-updates.sql
PROMPT ##################################################

@@07-collection-queries-and-updates.sql

PROMPT
PROMPT ##################################################
PROMPT === 08-inheritance-and-substitutability.sql
PROMPT ##################################################

@@08-inheritance-and-substitutability.sql

PROMPT
PROMPT ##################################################
PROMPT === 09-object-comparison-and-ordering.sql
PROMPT ##################################################

@@09-object-comparison-and-ordering.sql

PROMPT
PROMPT ##################################################
PROMPT === 99-cleanup.sql
PROMPT ##################################################

@@99-cleanup.sql

PROMPT ##################################################
PROMPT === DONE all-object.sql                        ===
PROMPT ##################################################
