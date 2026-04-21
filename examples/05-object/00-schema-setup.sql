-- 00-schema-setup.sql
--
-- Goal:
--   Create the common schema objects used by the object-relational examples.
--
-- Objects:
--  - advisors, 
--  - courses, 
--  - students, 
--  - addresses, 
--  - phone arrays, 
--  - skill collections, 
--  - grade collections, 
--  - object references between students, advisors, and courses. 

SET SERVEROUTPUT ON

PROMPT Cleaning up previous objects if they exist...

BEGIN EXECUTE IMMEDIATE 'DROP TABLE people PURGE'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE project_groups PURGE'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE students PURGE'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE courses PURGE'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE advisors PURGE'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TYPE student_t FORCE'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TYPE grade_entry_nt_t FORCE'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TYPE grade_entry_t FORCE'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TYPE advisor_t FORCE'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TYPE person_t FORCE'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TYPE course_t FORCE'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TYPE skill_nt_t FORCE'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TYPE phone_varray_t FORCE'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TYPE address_t FORCE'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

PROMPT Creating object and collection types...

CREATE OR REPLACE TYPE address_t AS OBJECT (
    street       VARCHAR2(13),
    city         VARCHAR2(12),
    postal_code  VARCHAR2(15),
    MEMBER FUNCTION to_text RETURN VARCHAR2
);
/

CREATE OR REPLACE TYPE BODY address_t AS
    MEMBER FUNCTION to_text RETURN VARCHAR2 IS
    BEGIN
        RETURN street || ', ' || city || ' ' || postal_code;
    END;
END;
/

CREATE OR REPLACE TYPE phone_varray_t AS VARRAY(3) OF VARCHAR2(20);
/

CREATE OR REPLACE TYPE skill_nt_t AS TABLE OF VARCHAR2(30);
/

CREATE OR REPLACE TYPE course_t AS OBJECT (
    course_id  NUMBER,
    code       VARCHAR2(12),
    title      VARCHAR2(27),
    credits    NUMBER,
    MEMBER FUNCTION label RETURN VARCHAR2,
    STATIC FUNCTION make_label(
        p_code  VARCHAR2,
        p_title VARCHAR2
    ) RETURN VARCHAR2
);
/

CREATE OR REPLACE TYPE BODY course_t AS
    MEMBER FUNCTION label RETURN VARCHAR2 IS
    BEGIN
        RETURN code || ' - ' || title || ' (' || credits || ' cr)';
    END;

    STATIC FUNCTION make_label(
        p_code  VARCHAR2,
        p_title VARCHAR2
    ) RETURN VARCHAR2 IS
    BEGIN
        RETURN p_code || ' - ' || p_title;
    END;
END;
/

CREATE OR REPLACE TYPE person_t AS OBJECT (
    person_id      NUMBER,
    name           VARCHAR2(12),
    home_address   address_t,
    phones         phone_varray_t,
    MAP MEMBER FUNCTION get_sort_key RETURN NUMBER,
    MEMBER FUNCTION summary RETURN VARCHAR2
) NOT FINAL;
/

CREATE OR REPLACE TYPE BODY person_t AS
    MAP MEMBER FUNCTION get_sort_key RETURN NUMBER IS
    BEGIN
        RETURN person_id;
    END;

    MEMBER FUNCTION summary RETURN VARCHAR2 IS
    BEGIN
        RETURN 'Person ' || person_id || ': ' || name;
    END;
END;
/

CREATE OR REPLACE TYPE advisor_t UNDER person_t (
    employee_no VARCHAR2(25),
    office_no   VARCHAR2(25),
    OVERRIDING MEMBER FUNCTION summary RETURN VARCHAR2
);
/

CREATE OR REPLACE TYPE BODY advisor_t AS
    OVERRIDING MEMBER FUNCTION summary RETURN VARCHAR2 IS
    BEGIN
        RETURN 'Advisor ' || employee_no || ': ' || name || ' / office ' || office_no;
    END;
END;
/

CREATE OR REPLACE TYPE grade_entry_t AS OBJECT (
    course_ref REF course_t,
    grade      NUMBER(3,1),
    MEMBER FUNCTION passed RETURN VARCHAR2
);
/

CREATE OR REPLACE TYPE BODY grade_entry_t AS
    MEMBER FUNCTION passed RETURN VARCHAR2 IS
    BEGIN
        RETURN CASE
                 WHEN grade IS NULL THEN 'UNKNOWN'
                 WHEN grade <= 3.0 THEN 'YES'
                 ELSE 'NO'
               END;
    END;
END;
/

CREATE OR REPLACE TYPE grade_entry_nt_t AS TABLE OF grade_entry_t;
/

CREATE OR REPLACE TYPE student_t UNDER person_t (
    student_no  VARCHAR2(27),
    skills      skill_nt_t,
    grades      grade_entry_nt_t,
    advisor_ref REF advisor_t,
    OVERRIDING MEMBER FUNCTION summary RETURN VARCHAR2,
    MEMBER FUNCTION average_grade RETURN NUMBER,
    MEMBER FUNCTION passed_count RETURN NUMBER
);
/

CREATE OR REPLACE TYPE BODY student_t AS
    OVERRIDING MEMBER FUNCTION summary RETURN VARCHAR2 IS
    BEGIN
        RETURN 'Student ' || student_no || ': ' || name;
    END;

    MEMBER FUNCTION average_grade RETURN NUMBER IS
        v_sum   NUMBER := 0;
        v_count NUMBER := 0;
    BEGIN
        IF grades IS NULL OR grades.COUNT = 0 THEN
            RETURN NULL;
        END IF;

        FOR i IN 1 .. grades.COUNT LOOP
            IF grades(i).grade IS NOT NULL THEN
                v_sum := v_sum + grades(i).grade;
                v_count := v_count + 1;
            END IF;
        END LOOP;

        IF v_count = 0 THEN
            RETURN NULL;
        END IF;

        RETURN ROUND(v_sum / v_count, 2);
    END;

    MEMBER FUNCTION passed_count RETURN NUMBER IS
        v_count NUMBER := 0;
    BEGIN
        IF grades IS NULL THEN
            RETURN 0;
        END IF;

        FOR i IN 1 .. grades.COUNT LOOP
            IF grades(i).grade IS NOT NULL AND grades(i).grade <= 3.0 THEN
                v_count := v_count + 1;
            END IF;
        END LOOP;

        RETURN v_count;
    END;
END;
/

PROMPT Creating object tables...

CREATE TABLE advisors OF advisor_t (
    CONSTRAINT advisors_pk PRIMARY KEY (person_id),
    CONSTRAINT advisors_employee_no_uq UNIQUE (employee_no)
)
OBJECT IDENTIFIER IS PRIMARY KEY
/

CREATE TABLE courses OF course_t (
    CONSTRAINT courses_pk PRIMARY KEY (course_id),
    CONSTRAINT courses_code_uq UNIQUE (code)
)
OBJECT IDENTIFIER IS PRIMARY KEY
/

CREATE TABLE students OF student_t (
    CONSTRAINT students_pk PRIMARY KEY (person_id),
    CONSTRAINT students_student_no_uq UNIQUE (student_no),
    SCOPE FOR (advisor_ref) IS advisors
)
OBJECT IDENTIFIER IS PRIMARY KEY
NESTED TABLE skills STORE AS students_skills_nt
NESTED TABLE grades STORE AS students_grades_nt
/

ALTER TABLE students_grades_nt
    ADD (SCOPE FOR (course_ref) IS courses)
/

PROMPT Inserting sample data...

INSERT INTO advisors VALUES (
    advisor_t(
        10,
        'Dr. Alice',
        address_t('Klatovska 10', 'Plzen', '30100'),
        phone_varray_t('111-111-111', '222-222-222'),
        'UC100',
        'UN100'
    )
);

INSERT INTO advisors VALUES (
    advisor_t(
        11,
        'Dr. Dave',
        address_t('Univerzitni 8', 'Plzen', '30614'),
        phone_varray_t('333-333-333'),
        'UC200',
        'UN200'
    )
);

INSERT INTO courses VALUES (
    course_t(1, 'KIV/DBA', 'Database Applications', 5)
);

INSERT INTO courses VALUES (
    course_t(2, 'KIV/PLS', 'PL/SQL Programming', 4)
);

INSERT INTO courses VALUES (
    course_t(3, 'KIV/OODB', 'Object-Relational Databases', 4)
);

INSERT INTO students
SELECT student_t(
           100,
           'John',
           address_t('Studentska 1', 'Plzen', '32300'),
           phone_varray_t('777-100-100'),
           'ST100',
           skill_nt_t('SQL', 'PLSQL'),
           grade_entry_nt_t(
               grade_entry_t((SELECT REF(c) FROM courses c WHERE c.course_id = 1), 1.0),
               grade_entry_t((SELECT REF(c) FROM courses c WHERE c.course_id = 2), 2.0)
           ),
           (SELECT REF(a) FROM advisors a WHERE a.person_id = 10)
       )
FROM dual;

INSERT INTO students
SELECT student_t(
           101,
           'Jane',
           address_t('Studentska 22', 'Plzen', '32300'),
           phone_varray_t('777-200-200', '777-200-201'),
           'ST101',
           skill_nt_t('Java', 'SQL', 'UML'),
           grade_entry_nt_t(
               grade_entry_t((SELECT REF(c) FROM courses c WHERE c.course_id = 1), 2.5),
               grade_entry_t((SELECT REF(c) FROM courses c WHERE c.course_id = 3), 1.5)
           ),
           (SELECT REF(a) FROM advisors a WHERE a.person_id = 10)
       )
FROM dual;

INSERT INTO students
SELECT student_t(
           102,
           'Petr',
           address_t('Zelena 4', 'Praha', '14000'),
           phone_varray_t('777-300-300'),
           'ST102',
           skill_nt_t('C', 'Databases'),
           grade_entry_nt_t(
               grade_entry_t((SELECT REF(c) FROM courses c WHERE c.course_id = 3), NULL)
           ),
           (SELECT REF(a) FROM advisors a WHERE a.person_id = 11)
       )
FROM dual;

COMMIT;

PROMPT Setup complete.
SELECT COUNT(*) AS advisor_count FROM advisors;
SELECT COUNT(*) AS course_count FROM courses;
SELECT COUNT(*) AS student_count FROM students;
