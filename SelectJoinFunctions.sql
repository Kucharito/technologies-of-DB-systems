--------------------SELECT-----------------
--Napište dotaz pro spojování řetězců pomocí ||
select distinct first_name ||' '|| last_name as full_name
from person;

--CONCAT
select distinct concat(first_name,CONCAT(' ',last_name)) as full_nameConc
from person;

---WHERE podmínky pro výběr řídků o Funkce LOWER, UPPER, INITCAP
select distinct first_name || ' ' || last_name AS full_name
FROM person
where LOWER(first_name)='john';

select distinct first_name || ' ' || last_name AS full_name
FROM person
where UPPER(last_name)='DOE';

select distinct first_name || ' ' || last_name AS full_name
FROM person
where INITCAP(first_name)NOT LIKE '%John%';

---BETWEEN … AND LIKE (%, _) IN() IS NULL, IS NOT NULL
select distinct first_name
FROM person
where first_name NOT LIKE '%John%';

select distinct first_name
FROM person
where first_name IN ('John');

SELECT DISTINCT task_name, date_of_creation
FROM task
WHERE date_of_creation BETWEEN TO_DATE('2024-05-01', 'YYYY-MM-DD') AND TO_DATE('2024-05-07', 'YYYY-MM-DD');

select *
from userr
where manager_id is null;

select *
from userr
where manager_id is not null;

----AND, OR, NOT ,Priorita vyhodnocení pomocí ()
SELECT
    t.id_task,
    t.task_name,
    u.skills
FROM
    task t
JOIN
    userr u ON t.id_user = u.id_user
WHERE
    (t.actual_status = 'Completed' OR t.actual_status = 'Pending')
    AND
    (u.skills LIKE '%Java%' OR u.skills LIKE '%SQL%');

SELECT
    u.id_user,
    u.skills
FROM
    userr u
WHERE
    (u.manager_id IS NOT NULL)
    AND
    (NOT u.skills LIKE '%Python%');

SELECT
    f.id_feedback,
    f.feedback_text,
    f.id_client,
    f.id_user
FROM
    feedback f
WHERE
    (f.feedback_text LIKE '%super%' OR f.feedback_text LIKE '%Excellent%')
    AND
    (f.id_client IS NOT NULL OR f.id_user IS NULL);


------ORDER BY atr [ASC/DESC] ,Třídění podle jednoho nebo vice atributů
SELECT DISTINCT first_name, last_name, email
FROM person
ORDER BY last_name ASC;

SELECT DISTINCT first_name,last_name
FROM person
ORDER BY last_name DESC;

SELECT DISTINCT task_name, date_of_creation, date_of_completion
FROM task
ORDER BY task_name ASC;

-------Jednořádkové funkce ,víceřádkové funkce MIN, MAX, AVG, SUM, COUNT
-- Jednořádkové funkce
SELECT
    LOWER(first_name) AS lower_first_name,
    UPPER(last_name) AS upper_last_name
FROM person;

-- Víceřádkové (agregační) funkce
SELECT
    MIN(material_quantity) AS min_quantity,
    MAX(material_quantity) AS max_quantity
FROM materials;

SELECT
    AVG(material_quantity) AS avg_quantity
FROM materials;

SELECT
    SUM(material_quantity) AS total_quantity
FROM materials;

SELECT
    COUNT(*) AS total_records
FROM materials;

-------------LOWER, UPPER, INITCAP ,CONCAT, SUBSTR, LENGTH, INSTR, LPAD, RPAD, TRIM, REPLACE ,Použijte tabulku DUAL
-- LOWER, UPPER, INITCAP
SELECT
    LOWER('Hello World') AS lower_text,
    UPPER('Hello World') AS upper_text,
    INITCAP('hello world') AS initcap_text
FROM DUAL;

-- CONCAT, SUBSTR, LENGTH, INSTR, LPAD, RPAD, TRIM, REPLACE
SELECT
    CONCAT('Hello', ' World') AS concatenated_text,
    SUBSTR('Hello World', 7, 5) AS substring_text,
    LENGTH('Hello World') AS text_length,
    INSTR('Hello World', 'World') AS position_text,
    LPAD('123', 5, '0') AS padded_text_left,
    RPAD('123', 5, '0') AS padded_text_right,
    TRIM('  Hello World  ') AS trimmed_text,
    REPLACE('Hello World', 'World', 'Oracle') AS replaced_text
FROM DUAL;

---------ROUND, TRUNC zaukrouhlení na 2 desetinná místa, na celé tisíce MOD

SELECT
ROUND(material_quantity, 2) AS rounded_quantity,
TRUNC(material_quantity, 2) AS truncated_quantity
FROM materials;

SELECT
    ROUND(material_quantity, -3) AS rounded_thousands,
    TRUNC(material_quantity, -3) AS truncated_thousands
FROM materials;

SELECT
    material_name,
    material_quantity,
    MOD(material_quantity, 1000) AS remainder
FROM materials;

-------MONTHS_BETWEEN, ADD_MONTHS, NEXT_DAY, LAST_DAY, ROUND, TRUNC ,Systémová konstanta SYSDATE

-- Použití SYSDATE na tabulce task pro výpočet rozdílu měsíců mezi SYSDATE a date_of_creation
SELECT
    id_task,
    task_name,
    date_of_creation,
    SYSDATE AS current_date,
    MONTHS_BETWEEN(SYSDATE, date_of_creation) AS months_since_creation
FROM task;

-- Přidání 3 měsíců k SYSDATE
SELECT
    SYSDATE AS current_date,
    ADD_MONTHS(SYSDATE, 3) AS date_after_3_months
FROM DUAL;

-- Nalezení následujícího pátku po SYSDATE
SELECT
    SYSDATE AS current_date,
    NEXT_DAY(SYSDATE, 'piatok') AS next_friday
FROM DUAL;

-- Nalezení posledního dne v měsíci pro SYSDATE
SELECT
    SYSDATE AS current_date,
    LAST_DAY(SYSDATE) AS last_day_of_current_month
FROM DUAL;

-- Zaokrouhlení a trunc SYSDATE na nejbližší měsíc
SELECT
    SYSDATE AS current_date,
    ROUND(SYSDATE, 'MONTH') AS rounded_date,
    TRUNC(SYSDATE, 'MONTH') AS truncated_date
FROM DUAL;

----TO_CHAR, TO_NUMBER, TO_DATE
-- Převedení date_of_creation v tabulce task na řetězec ve formátu 'DD-MM-YYYY'
SELECT
    id_task,
    task_name,
    TO_CHAR(date_of_creation, 'DD-MM-YYYY') AS creation_date_formatted
FROM
    task;

-- Předpokládejme, že máme sloupec feedback_text obsahující čísla jako text a chceme je převést na číslo
SELECT
    id_feedback,
    feedback_text,
    TO_NUMBER(feedback_text) AS feedback_number
FROM
    feedback
WHERE
    REGEXP_LIKE(feedback_text, '^[0-9]+$');
select * from feedback;

SELECT
    id_task,
    task_name,
    TO_DATE(TO_CHAR(date_of_creation, 'DD-MM-YYYY'), 'DD-MM-YYYY') AS creation_date_as_date
FROM
    task;

---------NVL, NVL2, NULLIF, COALESCE

-- Příklad: nahrazení NULL ve sloupci `comments` v tabulce `task` hodnotou 'No Comments'
SELECT
    id_task,
    task_name,
    NVL(comments, 'No Comments') AS comments_or_default
FROM
    task;

select * from task;


-- Příklad: pokud je `feedback_text` ne-NULL, vrátí 'Feedback Provided', jinak 'No Feedback'
SELECT
    id_feedback,
    feedback_text,
    NVL2(feedback_text, 'Feedback Provided', 'No Feedback') AS feedback_status
FROM
    feedback;

-- Příklad: pokud je `role` v tabulce `client_task` 'Owner', vrátí NULL, jinak vrátí hodnotu role
SELECT
    id_client,
    id_task,
    role,
    NULLIF(role, 'Owner') AS role_or_null
FROM
    client_task;

-- Příklad: vrátí první ne-NULL hodnotu z `feedback_text`, `comments`, nebo 'No Data' pokud jsou všechny NULL
SELECT
    id_feedback,
    COALESCE(feedback_text, comments, 'No Data') AS first_non_null
FROM
    feedback
LEFT JOIN
    task ON feedback.id_user = task.id_user;

select *from feedback;
------------DECODE, CASE, IF-THEN-ELSE
-- Příklad: Použití DECODE pro převod hodnoty `role_user` v tabulce `userr`
SELECT
    id_user,
    role_user,
    DECODE(role_user, 'A', 'Admin', 'B', 'Basic User', 'Unknown Role') AS role_description
FROM
    userr;

-- Příklad: Použití CASE pro převod hodnoty `actual_status` v tabulce `task`
SELECT
    id_task,
    task_name,
    actual_status,
    CASE
        WHEN actual_status = 'Completed' THEN 'Task Completed'
        WHEN actual_status = 'In Progress' THEN 'Task In Progress'
        WHEN actual_status = 'Pending' THEN 'Task Pending'
        ELSE 'Unknown Status'
    END AS status_description
FROM
    task;

DECLARE
    v_role_user CHAR(1);
    v_role_description VARCHAR2(20);
BEGIN
    SELECT role_user INTO v_role_user FROM userr WHERE id_user = 1;

    IF v_role_user = 'A' THEN
        v_role_description := 'Admin';
    ELSIF v_role_user = 'B' THEN
        v_role_description := 'Basic User';
    ELSE
        v_role_description := 'Unknown Role';
    END IF;

    DBMS_OUTPUT.PUT_LINE('Role Description: ' || v_role_description);
END;


---------NATURAL JOIN, CROSS JOIN
SELECT
    client.id_client,
    client.company_name,
    person.first_name,
    person.last_name
FROM
    client
NATURAL JOIN
    person;

SELECT
    userr.id_user,
    person.first_name,
    person.last_name
FROM
    userr
cross JOIN
    person;

--------JOIN … USING(atr) ,JOIN .. ON (podmínka spojení)
SELECT
    client.company_name,
    task.task_name,
    task.task_description
FROM
    client
JOIN
    task USING(id_client);

-- JOIN ... ON podmínka spojení mezi task a userr
SELECT
    work_record.description,
    work_record.date_work_record,
    place_of_work.construction_name
FROM
    place_of_work
JOIN
    work_record on place_of_work.id_place_of_work=work_record.id_place_of_work;

------------------LEFT OUTER JOIN … ON () ,RIGHT OUTER JOIN … ON () ,FULL OUTER JOIN … ON ()

SELECT
    work_record.id_work_record,
    work_record.description AS work_description,
    userr.id_user,
    userr.skills
FROM
    work_record
LEFT OUTER JOIN
    userr ON work_record.id_user = userr.id_user;

SELECT
    work_record.id_work_record,
    work_record.description AS work_description,
    place_of_work.id_place_of_work,
    place_of_work.construction_name
FROM
    work_record
RIGHT OUTER JOIN
    place_of_work ON work_record.id_place_of_work = place_of_work.id_place_of_work;

SELECT
    t.id_task,
    t.task_name,
    t.task_description,
    t.actual_status,
    t.date_of_creation,
    t.date_of_completion,
    c.id_client,
    c.company_name
FROM
    task t
FULL OUTER JOIN client c ON t.id_client = c.id_client
ORDER BY
    t.date_of_creation, c.company_name;



-----Spojování 2x stejné tabulky s přejmenováním (vazba mezi nadřízenými a podřízenými v jedné tabulce)
---Hierarchické dotazování – stromová struktura zanoření START WITH, CONNECT BY PRIOR, LEVEL
-- Spojení tabulky userr dvakrát pro vazbu mezi nadřízenými a podřízenými
SELECT
    u1.id_user AS subordinate_id,
    u1.skills AS subordinate_skills,
    u2.id_user AS manager_id,
    u2.skills AS manager_skills
FROM
    userr u1
LEFT JOIN
    userr u2 ON u1.manager_id = u2.id_user;

-- Hierarchické dotazování pro zobrazení stromové struktury nadřízených a podřízených
SELECT
    LEVEL AS hierarchy_level,
    SYS_CONNECT_BY_PATH(p.first_name || ' ' || p.last_name, '/') AS employee_path,
    p.first_name || ' ' || p.last_name AS employee_name,
    u.manager_id,
    u.id_user
FROM
    userr u
JOIN
    person p ON u.id_user = p.id_person
WHERE
    CONNECT_BY_ISCYCLE = 0
START WITH
    u.manager_id IS NOT NULL
CONNECT BY NOCYCLE
    PRIOR u.id_user = u.manager_id
ORDER BY
    LEVEL, employee_name;




----------AVG, COUNT, MIN, MAX, SUM, VARIANCE, STDDEV
SELECT
    AVG(material_quantity) AS avg_quantity,
    COUNT(*) AS total_records,
    MIN(material_quantity) AS min_quantity,
    MAX(material_quantity) AS max_quantity,
    SUM(material_quantity) AS total_quantity,
    VARIANCE(material_quantity) AS variance_quantity,
    STDDEV(material_quantity) AS stddev_quantity
FROM
    materials;

-----COUNT, COUNT(DISTINCT ), NVL  Rozdíl mezi COUNT (*) a COUNT (atribut) Proč NVL u agregačních funkcí

SELECT
    COUNT(*) AS total_records
FROM
    person
where email like 'j%';

-- COUNT specifického atributu (DISTINCT)
SELECT DISTINCT
    COUNT(email) AS email_count
FROM
    person;

SELECT
    SUM(NVL(material_quantity, 0)) AS total_quantity
FROM
    materials;

-------GROUP BY ,  HAVING

SELECT
    id_work_record,
    SUM(quantity_used) AS total_materials_used
FROM
    materials_used
GROUP BY
    id_work_record
HAVING
    SUM(quantity_used) > 50;

----------ROLLUP, CUBE, ROUPING SETS
SELECT
    material_name,
    material_description,
    SUM(material_quantity) AS total_quantity,
    GROUPING_ID(material_name, material_description) AS grouping_level
FROM
    materials
GROUP BY
    ROLLUP(material_name, material_description);

SELECT
    material_name,
    material_description,
    SUM(material_quantity) AS total_quantity
FROM
    materials
GROUP BY
    CUBE(material_name, material_description);

SELECT
    material_name,
    material_description,
    SUM(material_quantity) AS total_quantity
FROM
    materials
GROUP BY
    GROUPING SETS (
        (material_name),
        (material_description),
        (material_name, material_description)
    );
--------Množinové operace v SQL – UNION, UNION ALL, INTERSECT, MINUS ,ORDER BY u množinových operací
SELECT id_user FROM userr
UNION
SELECT id_user FROM user_profession
ORDER BY id_user;

SELECT id_user FROM userr
UNION ALL
SELECT id_user FROM user_profession
ORDER BY id_user;

-- INTERSECT example
SELECT id_client FROM client
INTERSECT
SELECT id_client FROM task
ORDER BY id_client;


-- MINUS example
SELECT id_client FROM client
MINUS
SELECT id_client FROM task
ORDER BY id_client;


-------Vnořené dotazy ,Výsledek jako jediná hodnota ,Vícesloupcový poddotaz ,EXISTS, NOT EXISTS
SELECT id_user, skills
FROM userr
WHERE skills = (SELECT MAX(skills) FROM userr);

SELECT
    id_client, company_name
FROM
    client
WHERE
    EXISTS (
        SELECT *
        FROM task
        WHERE task.id_client = client.id_client
    );

SELECT
    id_client, company_name
FROM
    client
WHERE
    NOT EXISTS (
        SELECT
            1
        FROM
            task
        WHERE
            task.id_client = client.id_client
    );


-------Jednořádkové poddotazy
---Zobrazíme počet úkolů pro jednotlivé uživatele a pouze ty, kteří mají více úkolů než průměrný počet úkolů na uživatele:
SELECT
    id_user,
    COUNT(id_task) AS task_count
FROM
    task
GROUP BY
    id_user
HAVING
    COUNT(id_task) > (
        SELECT AVG(task_count)
        FROM (
            SELECT
                id_user,
                COUNT(id_task) AS task_count
            FROM
                task
            GROUP BY
                id_user
        )
    );


-----Víceřádkové poddotazy IN, ANY, ALL ,NULL hodnoty v poddotazech
SELECT
    id_task,
    task_name,
    id_user
FROM
    task
WHERE
    id_user IN (
        SELECT
            id_user
        FROM
            userr
        WHERE
            role_user = 'A'
    );

SELECT
    id_task,
    task_name,
    date_of_creation,
    date_of_completion
FROM
    task
WHERE
    date_of_completion > ANY (
        SELECT
            date_of_creation
        FROM
            task
    );


SELECT
    id_task,
    task_name,
    date_of_creation,
    date_of_completion
FROM
    task
WHERE
    date_of_completion > ALL (
        SELECT
            date_of_creation
        FROM
            task
    );

-----WITH .. AS() konstrukce poddotazu
---Vybereme všechny úkoly, které byly přiřazeny uživatelům s určitými rolemi a zobrazíme jejich detaily.
WITH user_roles AS (
    SELECT
        id_user,
        first_name,
        last_name,
        role_user
    FROM
        person
    JOIN
        userr ON person.id_person = userr.id_user
    WHERE
        role_user = 'A'
)
SELECT
    t.id_task,
    t.task_name,
    t.date_of_creation,
    ur.first_name,
    ur.last_name,
    ur.role_user
FROM
    task t
JOIN
    user_roles ur ON t.id_user = ur.id_user
ORDER BY
    t.date_of_creation;

------INSERT INTO Tab VALUES() ,INSERT INTo Tab (atr, atr) VALUES() ,INSERT INTO Tab AS SELECT …
INSERT INTO person VALUES (11, 'Alice', 'Smith', 'alice.smith@example.com', '1234567891');

INSERT INTO address (id_address, address_name, address_number, address_city, address_country, postal_code)
VALUES (11, 'Eleventh St', 1100, 'New Springfield', 'USA', '11011');

INSERT INTO client_task (id_client, id_task, role)
SELECT c.id_client, t.id_task, 'Supervisor'
FROM client c
JOIN task t ON c.id_client = t.id_client
WHERE t.task_name = 'Electrical Work'
AND NOT EXISTS (
    SELECT 1
    FROM client_task ct
    WHERE ct.id_client = c.id_client
    AND ct.id_task = t.id_task
);

---UPDATE Tab SET atr= …. WHERE podm ,DELETE FROM Tab WHERE atr=…
UPDATE userr
SET skills = 'Docker, Kubernetes, AWS'
WHERE id_user = 10;

DELETE FROM feedback
WHERE id_feedback = 10;

----DEFAULT, MERGE, Multi-Table Inserts
ALTER TABLE userr MODIFY role_user DEFAULT 'B';

MERGE INTO userr u
USING (
    SELECT 1 AS id_user, 'Docker, Kubernetes' AS skills, 'password11' AS password_user, 'A' AS role_user, 10 AS id_profession, 9 AS id_address, 4 AS manager_id
    FROM dual
) src
ON (u.id_user = src.id_user)
WHEN MATCHED THEN
    UPDATE SET u.skills = src.skills, u.password_user = src.password_user, u.role_user = src.role_user, u.id_profession = src.id_profession, u.id_address = src.id_address, u.manager_id = src.manager_id
WHEN NOT MATCHED THEN
    INSERT (id_user, skills, password_user, role_user, id_profession, id_address, manager_id)
    VALUES (src.id_user, src.skills, src.password_user, src.role_user, src.id_profession, src.id_address, src.manager_id);

INSERT ALL
    INTO client (id_client, company_name) VALUES (11, 'New Client Co.')
    INTO person (id_person, first_name, last_name, email, phone_number) VALUES (12, 'New', 'Client', 'new.client@example.com', '123456789');



-------Objekty v databází – Tabulky, Indexy, Constraint, View, Sequnce, Synonym
--- CREATE, ALTER, DROP, RENAME, TRUNCATE
--- CREATE TABLE (atr DAT TYP, DEFAULT NOT NULL )
---ORGANIZATION EXTERNAL, TYPE ORACLE_LOADER, DEFAULT DICTIONARY, ACESS
---PARAMETERS, RECORDS DELIMITED BY NEWLINE, FIELDS, LOCATION
ALTER TABLE employee ADD (department_id INTEGER);
ALTER TABLE employee MODIFY (salary NUMBER(10, 2));
ALTER TABLE employee DROP COLUMN department_id;


--DROP TABLE employee;

RENAME employee TO staff;

TRUNCATE TABLE staff;

CREATE INDEX idx_employee_last_name ON employee (last_name);

DROP INDEX idx_employee_last_name;

CREATE SEQUENCE emp_seq START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

DROP SEQUENCE emp_seq;

CREATE SYNONYM emp FOR employee;
DROP SYNONYM emp;

CREATE TABLE external_employee (
    id_employee INTEGER,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    email VARCHAR2(100),
    salary NUMBER(8, 2)
)
ORGANIZATION EXTERNAL (
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY ext_dir
    ACCESS PARAMETERS (
        RECORDS DELIMITED BY NEWLINE
        FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
        MISSING FIELD VALUES ARE NULL
        (
            id_employee INTEGER,
            first_name CHAR(50),
            last_name CHAR(50),
            email CHAR(100),
            salary CHAR(10)
        )
    )
    LOCATION ('employee_data.csv')
)
REJECT LIMIT UNLIMITED;


--CREATE VIEW ,FORCE, NOFORCE ,WITCH CHECK OPTION ,WITH READ ONLY ,Simple vs. Compex VIEW

-------ALTER TABLE (ADD, MODIFY, DROP), DROP, RENAME
---- FLASHBACK TABLE Tab TO BEFORE DROP (pohled USER_RECYCLEBIN)
---- DELETE, TRUNCATE
---- COMMENT ON TABLE
--- SET UNUSED
ALTER TABLE person ADD date_of_birth DATE;
ALTER TABLE person MODIFY email VARCHAR2(100);
ALTER TABLE person DROP COLUMN date_of_birth;
---DROP TABLE person;
--DROP TABLE person;
-- Obnovení tabulky z koše
FLASHBACK TABLE person TO BEFORE DROP;

DELETE FROM person WHERE first_name = 'John';
COMMENT ON TABLE person IS 'This table stores personal information.';
ALTER TABLE person SET UNUSED email;

----CREATE VIEW ,FORCE, NOFORCE ,WITCH CHECK OPTION , WITH READ ONLY , Simple vs. Compex VIEW

CREATE VIEW simple_view AS
SELECT first_name, last_name, email
FROM person;

CREATE FORCE VIEW force_view AS
SELECT first_name, last_name, email
FROM person;

CREATE NOFORCE VIEW noforce_view AS
SELECT first_name, last_name, email
FROM person;

CREATE VIEW check_option_view AS
SELECT first_name, last_name, email
FROM person
WHERE email LIKE '%@example.com'
WITH CHECK OPTION;

CREATE VIEW read_only_view AS
SELECT first_name, last_name, email
FROM person
WITH READ ONLY;


CREATE VIEW complex_view AS
SELECT p.first_name, p.last_name, t.task_name, t.date_of_creation
FROM person p
JOIN task t ON p.id_person = t.id_user
WHERE t.date_of_creation > TO_DATE('2024-01-01', 'YYYY-MM-DD');

--INLINE VIEW Poddotaz v podobě tabulky SELECT atr FROM (SELECT * FROM Tab) alt_tab
SELECT first_name, last_name, email
FROM (
    SELECT *
    FROM person
) alt_tab;

---TIMESTAMP, TIMESTAMP WITH TIME ZONE, TIMESTAM WITH LOCAL TIMEZONE INTERVAL YEAT TO MONTH, INTERVAL DAY TO SECOND  CHAR, VARCHAR2, CLOB  NUMBER  BLOB
CREATE TABLE T(
    exact_time TIMESTAMP,
    t1 TIMESTAMP WITH TIME ZONE,
    t2 TIMESTAMP WITH LOCAL TIME ZONE
    );

INSERT INTO T (exact_time,t1,t2)
VALUES (SYSDATE,'06.11.21 15:37:02,000000000 EUROPE/PRAGUE','06.11.21 15:37:02')

CREATE TABLE time_ex4
    (delka1 INTERVAL YEAR(3) TO MONTH,
     delka2 INTERVAL YEAR(2) TO MONTH);

INSERT INTO time_ex4 (delka1, delka2)
VALUES (INTERVAL '120' MONTH(3),
        INTERVAL '3-6' YEAR TO MONTH);

SELECT  SYSDATE + delka1 AS "120 months from now",
        SYSDATE + delka2 AS "3 years 6 months from now"
FROM time_ex4;

CREATE TABLE ccc(
        c CHAR(10),
        cc VARCHAR (50),
        ccc CLOB,
        n   number,
        b   BLOB
        )


--CREATE SEQUENCE nazev INCREMENT BY n START WITH m, (NO)MAXVALUE, (NO)MINVALUE,
--ALTER SEQUENCE


CREATE SEQUENCE Sekvence2
    INCREMENT BY 1
    START WITH 1
    MAXVALUE 50000
    MINVALUE 1
    NOCACHE
    NOCYCLE;

ALTER SEQUENCE Sekvence2
    INCREMENT BY 1
    MAXVALUE 999999
    NOCACHE
    NOCYCLE;

SELECT sequence_name, min_value, max_value, increment_by,
last_number
FROM user_sequences;
--GRANT  ON TO PUBLIC

GRANT SELECT ON employee TO public;

REVOKE SELECT ON employee FROM public;

---- Regulární výrazy
---REGEXP_LIKE, REGEXP_REPLACE, REGEXP_INSTR, REGEXP_SUBSTR, REGEXP_COUNT
SELECT id_feedback, feedback_text
FROM feedback
WHERE REGEXP_LIKE(feedback_text, 'job', 'i');

SELECT id_feedback,
       REGEXP_REPLACE(feedback_text, 'Satisfactory', 'Acceptable', 1, 0, 'i') AS modified_feedback
FROM feedback;

SELECT id_feedback,
       REGEXP_INSTR(feedback_text, 'recommend', 1, 1, 0, 'i') AS position
FROM feedback;

SELECT id_feedback,
       REGEXP_SUBSTR(feedback_text, '\b[A-Z][a-z]*\b!', 1, 1, 'i') AS extracted_word
FROM feedback;

SELECT id_feedback,
       REGEXP_COUNT(feedback_text, 'great', 1, 'i') AS count_great
FROM feedback;

----Transakce, COMMIT, ROLLBACK, SAVEPOINT
BEGIN;
INSERT INTO client (id_client, company_name) VALUES (11, 'New Client Co.');

SAVEPOINT after_client_insert;

INSERT INTO client_task (id_client, id_task, role)
VALUES (11, 12, 'Supervisor');

SAVEPOINT after_task_insert;


---Alternativní zápis spojování bez JOIN s podmínkou spojení ve WHERE
---Levé a pravé spojení s pomocí atrA = atrB (+)

SELECT
    work_record.id_work_record,
    work_record.description,
    userr.id_user,
    userr.skills
FROM
    work_record, userr
WHERE 
    work_record.id_user = userr.id_user;


SELECT
    w.id_work_record,
    w.description AS work_description,
    p.id_place_of_work,
    p.construction_name
FROM
    work_record w, place_of_work p
WHERE
    w.id_place_of_work(+) = p.id_place_of_work;

SELECT
    w.id_work_record,
    w.description AS work_description,
    u.id_user,
    u.skills
FROM
    work_record w, userr u
WHERE
    w.id_user = u.id_user(+);