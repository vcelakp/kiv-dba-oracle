-- 08-inheritance-and-substitutability.sql
--
-- Goal:
--   Understand inheritance and substitutability in Oracle object types.
--

SET SERVEROUTPUT ON

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE people PURGE';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE people OF person_t (
    CONSTRAINT people_pk PRIMARY KEY (person_id)
)
OBJECT IDENTIFIER IS PRIMARY KEY
/

INSERT INTO people
SELECT VALUE(a)
FROM advisors a;

INSERT INTO people
SELECT VALUE(s)
FROM students s;

COMMIT;

PROMPT Dynamic method dispatch on a supertype table

SELECT p.person_id,
       p.summary() AS runtime_summary
FROM people p
ORDER BY p.person_id;

PROMPT Testing runtime type with IS OF

SELECT p.person_id,
       p.name,
       CASE
           WHEN VALUE(p) IS OF (ONLY advisor_t) THEN 'ADVISOR'
           WHEN VALUE(p) IS OF (ONLY student_t) THEN 'STUDENT'
           ELSE 'PERSON'
       END AS runtime_type
FROM people p
ORDER BY p.person_id;

PROMPT Accessing subtype attributes with TREAT

SELECT TREAT(VALUE(p) AS student_t).student_no AS student_no,
       p.name
FROM people p
WHERE VALUE(p) IS OF (ONLY student_t)
ORDER BY p.person_id;
