# Database Applications (KIV/DBA): Oracle Object-Relational Database Examples

This set of examples provides a step-by-step introduction to Oracle object-relational features [Oracle: Object-Relational Developer's Guide](https://docs.oracle.com/en/database/oracle/oracle-database/26/adobj/index.html).

The examples are intentionally small and focused. You should already know SQL and PL/SQL. In this set you explore Oracle object types, collections, object methods, object tables, object columns, references, and inheritance.

All the examples use a small university-style schema with:

- advisors,
- courses,
- students,
- addresses,
- phone arrays,
- skill collections,
- grade collections,
- object references between students, advisors, and courses.

## Topics covered

The set of SQL scripts covers the following topics:

- abstract data types (Oracle object types),
- object methods,
- arrays as attributes (`VARRAY`),
- nested tables,
- object references (`REF`),
- object tables and object columns,
- inheritance and substitutability,
- object comparison through a `MAP` method,
- querying and updating collection attributes.

## Running the examples

1. Run [`00-schema-setup.sql`](00-schema-setup.sql) first.
2. Run scripts `01-*` to `09-*`.
3. Use `SET SERVEROUTPUT ON` in your SQL client.
4. Run [`99-cleanup.sql`](99-cleanup.sql) when you want to remove all created objects.

## Recommended order of scripts

1. [`00-schema-setup.sql`](00-schema-setup.sql)  
   **Goal:** Create the shared object-relational schema and sample data for the whole example set.  
   **Practice:** defining object types, collection types, type bodies, object tables, scoped `REF`s, and nested-table storage.  
   **Key elements:** `CREATE TYPE`, `CREATE TYPE BODY`, `VARRAY`, `TABLE OF`, `CREATE TABLE OF`, `REF`, `SCOPE FOR`, `NESTED TABLE ... STORE AS`

2. [`01-object-types-and-constructors.sql`](01-object-types-and-constructors.sql)  
   **Goal:** Understand basic object constructors and attribute access.  
   **Practice:** creating standalone object instances in SQL and reading object attributes from object tables.  
   **Key elements:** object constructors, object attributes, `VALUE(...)`, method call on an object instance

3. [`02-object-methods.sql`](02-object-methods.sql)  
   **Goal:** Practice member methods and static methods.  
   **Practice:** calling methods in SQL and PL/SQL and using behavior encapsulated inside object types.  
   **Key elements:** member method, static method, SQL method invocation, PL/SQL method invocation

4. [`03-varray-attributes.sql`](03-varray-attributes.sql)  
   **Goal:** Work with arrays stored as object attributes.  
   **Practice:** querying and updating a `VARRAY` attribute.  
   **Key elements:** `VARRAY`, `TABLE(...)`, `COLUMN_VALUE`, object attribute update

5. [`04-nested-table-attributes.sql`](04-nested-table-attributes.sql)  
   **Goal:** Work with nested-table attributes and multiset operations.  
   **Practice:** querying scalar nested-table elements and adding new values to a nested-table collection.  
   **Key elements:** nested table attribute, `TABLE(...)`, `COLUMN_VALUE`, `MULTISET UNION DISTINCT`

6. [`05-object-tables-and-object-columns.sql`](05-object-tables-and-object-columns.sql)  
   **Goal:** Compare object tables with relational tables that contain object columns.  
   **Practice:** selecting whole objects from an object table and embedding objects as relational column values.  
   **Key elements:** object table, object column, `VALUE(...)`, attribute navigation

7. [`06-refs-and-deref.sql`](06-refs-and-deref.sql)  
   **Goal:** Navigate object references.  
   **Practice:** reading and dereferencing `REF` attributes both directly and inside nested tables.  
   **Key elements:** `REF`, `DEREF`, scoped references, object navigation

8. [`07-collection-queries-and-updates.sql`](07-collection-queries-and-updates.sql)  
   **Goal:** Query and modify nested tables of object values.  
   **Practice:** reading collection elements, inserting a new element, and updating one nested-table item.  
   **Key elements:** `TABLE(...)`, object collection elements, `INSERT INTO TABLE(...)`, `UPDATE TABLE(...)`

9. [`08-inheritance-and-substitutability.sql`](08-inheritance-and-substitutability.sql)  
   **Goal:** Understand inheritance and substitutability in Oracle object types.  
   **Practice:** storing subtype instances in a supertype table, dynamic method dispatch, and safe subtype access.  
   **Key elements:** `UNDER`, `NOT FINAL`, `IS OF`, `TREAT`, overriding methods

10. [`09-object-comparison-and-ordering.sql`](09-object-comparison-and-ordering.sql)  
    **Goal:** Compare and order object instances.  
    **Practice:** using a `MAP` method for ordering in SQL and PL/SQL comparisons.  
    **Key elements:** `MAP MEMBER FUNCTION`, `ORDER BY VALUE(...)`, object comparison operators

11. [`99-cleanup.sql`](99-cleanup.sql) *(optional cleanup)*  
    **Goal:** Remove all schema objects created for the example set.  
    **Practice:** resetting the environment and cleaning up dependent types and tables.  
    **Key elements:** `DROP TABLE`, `DROP TYPE ... FORCE`, rerunnable cleanup
