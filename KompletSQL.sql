-- Address Table
CREATE TABLE address (
    id_address      INTEGER NOT NULL,
    address_name    VARCHAR2(50) NOT NULL,
    address_number  INTEGER NOT NULL,
    address_city    VARCHAR2(40) NOT NULL,
    address_country VARCHAR2(40) NOT NULL,
    postal_code     CHAR(5) NOT NULL
)
LOGGING;

ALTER TABLE address ADD CONSTRAINT address_pk PRIMARY KEY ( id_address );

CREATE TABLE certification (
    id_certification   INTEGER NOT NULL,
    id_profession      INTEGER NOT NULL,
    certification_name VARCHAR2(100) NOT NULL
)
LOGGING;

ALTER TABLE certification ADD CONSTRAINT certification_profession_id_pk PRIMARY KEY ( id_profession, id_certification );

CREATE TABLE client (
    id_client    INTEGER NOT NULL,
    company_name VARCHAR2(30)
)
LOGGING;

ALTER TABLE client ADD CONSTRAINT client_pk PRIMARY KEY ( id_client );

CREATE TABLE client_task (
    id_client INTEGER NOT NULL,
    id_task   INTEGER NOT NULL,
    role      VARCHAR2(50) NOT NULL
)
LOGGING;

ALTER TABLE client_task ADD CONSTRAINT client_task_pk PRIMARY KEY ( id_client, id_task );

CREATE TABLE feedback (
    id_feedback   INTEGER NOT NULL,
    feedback_text VARCHAR2(500) NOT NULL,
    id_client     INTEGER,
    id_user       INTEGER
)
LOGGING;

ALTER TABLE feedback ADD CONSTRAINT feedback_client_user_chk CHECK ( ( ( id_client IS NOT NULL ) AND ( id_user IS NULL ) ) OR ( ( id_user IS NOT NULL ) AND ( id_client IS NULL ) ) );

ALTER TABLE feedback ADD CONSTRAINT feedback_pk PRIMARY KEY ( id_feedback );

CREATE TABLE materials (
    id_materials         INTEGER NOT NULL,
    material_name        VARCHAR2(50) NOT NULL,
    material_description VARCHAR2(255) NOT NULL,
    material_quantity    INTEGER NOT NULL
)
LOGGING;

ALTER TABLE materials ADD CONSTRAINT materials_pk PRIMARY KEY ( id_materials );

CREATE TABLE materials_used (
    quantity_used  INTEGER NOT NULL,
    id_work_record INTEGER NOT NULL,
    id_materials   INTEGER NOT NULL
)
LOGGING;

ALTER TABLE materials_used ADD CONSTRAINT materials_used_pk PRIMARY KEY ( id_work_record, id_materials );

CREATE TABLE person (
    id_person    INTEGER NOT NULL,
    first_name   VARCHAR2(30),
    last_name    VARCHAR2(40),
    email        VARCHAR2(40) NOT NULL,
    phone_number VARCHAR2(13) NOT NULL
)
LOGGING;

ALTER TABLE person ADD CONSTRAINT person_pk PRIMARY KEY ( id_person );

CREATE TABLE place_of_work (
    id_place_of_work  INTEGER NOT NULL,
    construction_name VARCHAR2(60) NOT NULL,
    id_address        INTEGER NOT NULL
)
LOGGING;

ALTER TABLE place_of_work ADD CONSTRAINT place_of_work_pk PRIMARY KEY ( id_place_of_work );

CREATE TABLE profession (
    id_profession   INTEGER NOT NULL,
    profession_name VARCHAR2(40) NOT NULL
)
LOGGING;

ALTER TABLE profession ADD CONSTRAINT profession_pk PRIMARY KEY ( id_profession );

CREATE TABLE task (
    id_task            INTEGER NOT NULL,
    task_name          VARCHAR2(40) NOT NULL,
    task_description   VARCHAR2(200),
    actual_status      VARCHAR2(100),
    date_of_creation   DATE NOT NULL,
    date_of_completion DATE NOT NULL,
    comments           VARCHAR2(100),
    id_user            INTEGER NOT NULL,
    id_client          INTEGER NOT NULL,
    parent_task_id     INTEGER
)
LOGGING;

ALTER TABLE task ADD CONSTRAINT task_pk PRIMARY KEY ( id_task );

CREATE TABLE user_profession (
    id_user       INTEGER NOT NULL,
    id_profession INTEGER NOT NULL
)
LOGGING;

ALTER TABLE user_profession ADD CONSTRAINT user_profession_pk PRIMARY KEY ( id_user, id_profession );

CREATE TABLE userr (
    id_user       INTEGER NOT NULL,
    skills        VARCHAR2(500),
    password_user VARCHAR2(30) NOT NULL,
    role_user     CHAR(1) NOT NULL,
    id_profession INTEGER NOT NULL,
    id_address    INTEGER NOT NULL,
    manager_id    INTEGER
)
LOGGING;

ALTER TABLE userr ADD CONSTRAINT userr_pk PRIMARY KEY ( id_user );

CREATE TABLE work_record (
    id_work_record   INTEGER NOT NULL,
    description      VARCHAR2(500),
    date_work_record DATE,
    id_user          INTEGER NOT NULL,
    id_task          INTEGER,
    id_place_of_work INTEGER NOT NULL
)
LOGGING;

ALTER TABLE work_record ADD CONSTRAINT work_record_pk PRIMARY KEY ( id_work_record );

CREATE TABLE work_record_history (
    modified_at     DATE NOT NULL,
    old_description VARCHAR2(2000) NOT NULL,
    new_description VARCHAR2(2000) NOT NULL,
    id_work_record  INTEGER NOT NULL,
    id_user         INTEGER NOT NULL
)
LOGGING;

ALTER TABLE work_record_history ADD CONSTRAINT work_record_history_pk PRIMARY KEY ( id_work_record );

ALTER TABLE certification
    ADD CONSTRAINT certification_profession_fk FOREIGN KEY ( id_profession )
        REFERENCES profession ( id_profession )
    NOT DEFERRABLE;

ALTER TABLE client
    ADD CONSTRAINT client_fk FOREIGN KEY ( id_client )
        REFERENCES person ( id_person )
    NOT DEFERRABLE;

ALTER TABLE client_task
    ADD CONSTRAINT client_task_client_fk FOREIGN KEY ( id_client )
        REFERENCES client ( id_client )
    NOT DEFERRABLE;

ALTER TABLE client_task
    ADD CONSTRAINT client_task_task_fk FOREIGN KEY ( id_task )
        REFERENCES task ( id_task )
    NOT DEFERRABLE;

ALTER TABLE feedback
    ADD CONSTRAINT feedback_client_fk FOREIGN KEY ( id_client )
        REFERENCES client ( id_client )
    NOT DEFERRABLE;

ALTER TABLE feedback
    ADD CONSTRAINT feedback_user_fk FOREIGN KEY ( id_user )
        REFERENCES userr ( id_user )
    NOT DEFERRABLE;

ALTER TABLE materials_used
    ADD CONSTRAINT materials_used_materials_fk FOREIGN KEY ( id_materials )
        REFERENCES materials ( id_materials )
    NOT DEFERRABLE;

ALTER TABLE materials_used
    ADD CONSTRAINT materials_used_work_record_fk FOREIGN KEY ( id_work_record )
        REFERENCES work_record ( id_work_record )
    NOT DEFERRABLE;

ALTER TABLE place_of_work
    ADD CONSTRAINT place_of_work_address_fk FOREIGN KEY ( id_address )
        REFERENCES address ( id_address )
    NOT DEFERRABLE;

ALTER TABLE task
    ADD CONSTRAINT task_client_fk FOREIGN KEY ( id_client )
        REFERENCES client ( id_client )
    NOT DEFERRABLE;

ALTER TABLE task
    ADD CONSTRAINT task_parent_fk FOREIGN KEY ( parent_task_id )
        REFERENCES task ( id_task )
    NOT DEFERRABLE;

ALTER TABLE task
    ADD CONSTRAINT task_userr_fk FOREIGN KEY ( id_user )
        REFERENCES userr ( id_user )
    NOT DEFERRABLE;

ALTER TABLE user_profession
    ADD CONSTRAINT user_profession_profession_fk FOREIGN KEY ( id_profession )
        REFERENCES profession ( id_profession )
    NOT DEFERRABLE;

ALTER TABLE user_profession
    ADD CONSTRAINT user_profession_userr_fk FOREIGN KEY ( id_user )
        REFERENCES userr ( id_user )
    NOT DEFERRABLE;

ALTER TABLE userr
    ADD CONSTRAINT userr_address_fk FOREIGN KEY ( id_address )
        REFERENCES address ( id_address )
    NOT DEFERRABLE;

ALTER TABLE userr
    ADD CONSTRAINT userr_fk FOREIGN KEY ( id_user )
        REFERENCES person ( id_person )
    NOT DEFERRABLE;

ALTER TABLE userr
    ADD CONSTRAINT userr_manager_fk FOREIGN KEY ( manager_id )
        REFERENCES userr ( id_user )
    NOT DEFERRABLE;

ALTER TABLE userr
    ADD CONSTRAINT userr_profession_fk FOREIGN KEY ( id_profession )
        REFERENCES profession ( id_profession )
    NOT DEFERRABLE;

ALTER TABLE work_record_history
    ADD CONSTRAINT work_history_work_record_fk FOREIGN KEY ( id_work_record )
        REFERENCES work_record ( id_work_record )
    NOT DEFERRABLE;

ALTER TABLE work_record_history
    ADD CONSTRAINT work_record_history_userr_fk FOREIGN KEY ( id_user )
        REFERENCES userr ( id_user )
    NOT DEFERRABLE;

ALTER TABLE work_record
    ADD CONSTRAINT work_record_place_of_work_fk FOREIGN KEY ( id_place_of_work )
        REFERENCES place_of_work ( id_place_of_work )
    NOT DEFERRABLE;

ALTER TABLE work_record
    ADD CONSTRAINT work_record_task_fk FOREIGN KEY ( id_task )
        REFERENCES task ( id_task )
    NOT DEFERRABLE;

ALTER TABLE work_record
    ADD CONSTRAINT work_record_userr_fk FOREIGN KEY ( id_user )
        REFERENCES userr ( id_user )
    NOT DEFERRABLE;


-- Inserting data into tables
-- Address Table
INSERT INTO address (id_address, address_name, address_number, address_city, address_country, postal_code) VALUES 
(1, 'Main St', 100, 'Springfield', 'USA', '11111');
INSERT INTO address (id_address, address_name, address_number, address_city, address_country, postal_code) VALUES 
(2, 'Second St', 200, 'Shelbyville', 'USA', '22222');
INSERT INTO address (id_address, address_name, address_number, address_city, address_country, postal_code) VALUES 
(3, 'Third St', 300, 'Ogdenville', 'USA', '33333');
INSERT INTO address (id_address, address_name, address_number, address_city, address_country, postal_code) VALUES 
(4, 'Fourth St', 400, 'North Haverbrook', 'USA', '44444');
INSERT INTO address (id_address, address_name, address_number, address_city, address_country, postal_code) VALUES 
(5, 'Fifth St', 500, 'Capitol City', 'USA', '55555');
INSERT INTO address (id_address, address_name, address_number, address_city, address_country, postal_code) VALUES 
(6, 'Sixth St', 600, 'Cypress Creek', 'USA', '66666');
INSERT INTO address (id_address, address_name, address_number, address_city, address_country, postal_code) VALUES 
(7, 'Seventh St', 700, 'West Springfield', 'USA', '77777');
INSERT INTO address (id_address, address_name, address_number, address_city, address_country, postal_code) VALUES 
(8, 'Eighth St', 800, 'East Springfield', 'USA', '88888');
INSERT INTO address (id_address, address_name, address_number, address_city, address_country, postal_code) VALUES 
(9, 'Ninth St', 900, 'South Springfield', 'USA', '99999');
INSERT INTO address (id_address, address_name, address_number, address_city, address_country, postal_code) VALUES 
(10, 'Tenth St', 1000, 'North Springfield', 'USA', '10101');

select *from address;

-- Person Table
INSERT INTO person (id_person, first_name, last_name, email, phone_number) VALUES 
(1, 'John', 'Doe', 'john.doe@example.com', '1234567890');
INSERT INTO person (id_person, first_name, last_name, email, phone_number) VALUES 
(2, 'Jane', 'Doe', 'jane.doe@example.com', '2345678901');
INSERT INTO person (id_person, first_name, last_name, email, phone_number) VALUES 
(3, 'Jim', 'Beam', 'jim.beam@example.com', '3456789012');
INSERT INTO person (id_person, first_name, last_name, email, phone_number) VALUES 
(4, 'Jack', 'Daniels', 'jack.daniels@example.com', '4567890123');
INSERT INTO person (id_person, first_name, last_name, email, phone_number) VALUES 
(5, 'Johnny', 'Walker', 'johnny.walker@example.com', '5678901234');
INSERT INTO person (id_person, first_name, last_name, email, phone_number) VALUES 
(6, 'Jameson', 'Irish', 'jameson.irish@example.com', '6789012345');
INSERT INTO person (id_person, first_name, last_name, email, phone_number) VALUES 
(7, 'Evan', 'Williams', 'evan.williams@example.com', '7890123456');
INSERT INTO person (id_person, first_name, last_name, email, phone_number) VALUES 
(8, 'Jose', 'Cuervo', 'jose.cuervo@example.com', '8901234567');
INSERT INTO person (id_person, first_name, last_name, email, phone_number) VALUES 
(9, 'Captain', 'Morgan', 'captain.morgan@example.com', '9012345678');
INSERT INTO person (id_person, first_name, last_name, email, phone_number) VALUES 
(10, 'George', 'Dickel', 'george.dickel@example.com', '0123456789');

select * from person;

-- Client Table
INSERT INTO client (id_client, company_name) VALUES 
(1, 'Doe Inc.');
INSERT INTO client (id_client, company_name) VALUES 
(2, 'Beam Co.');
INSERT INTO client (id_client, company_name) VALUES 
(3, 'Daniels Ltd.');
INSERT INTO client (id_client, company_name) VALUES 
(4, 'Walker LLC');
INSERT INTO client (id_client, company_name) VALUES 
(5, 'Irish Enterprises');
INSERT INTO client (id_client, company_name) VALUES 
(6, 'Williams Group');
INSERT INTO client (id_client, company_name) VALUES 
(7, 'Cuervo Bros.');
INSERT INTO client (id_client, company_name) VALUES 
(8, 'Morgan Shipping');
INSERT INTO client (id_client, company_name) VALUES 
(9, 'Dickel Distillery');
INSERT INTO client (id_client, company_name) VALUES 
(10, 'Smith Co.');

select * from client;

-- Profession Table
INSERT INTO profession (id_profession, profession_name) VALUES 
(1, 'Electrician');
INSERT INTO profession (id_profession, profession_name) VALUES 
(2, 'Plumber');
INSERT INTO profession (id_profession, profession_name) VALUES 
(3, 'Carpenter');
INSERT INTO profession (id_profession, profession_name) VALUES 
(4, 'Welder');
INSERT INTO profession (id_profession, profession_name) VALUES 
(5, 'Painter');
INSERT INTO profession (id_profession, profession_name) VALUES 
(6, 'Mason');
INSERT INTO profession (id_profession, profession_name) VALUES 
(7, 'Mechanic');
INSERT INTO profession (id_profession, profession_name) VALUES 
(8, 'Technician');
INSERT INTO profession (id_profession, profession_name) VALUES 
(9, 'Engineer');
INSERT INTO profession (id_profession, profession_name) VALUES 
(10, 'Architect');

select * from profession;

-- User Table with Hierarchical Relationship
INSERT INTO userr (id_user, skills, password_user, role_user, id_profession, id_address, manager_id) VALUES 
(1, 'Java, SQL', 'password1', 'A', 1, 1, NULL);
INSERT INTO userr (id_user, skills, password_user, role_user, id_profession, id_address, manager_id) VALUES 
(2, 'Python, R', 'password2', 'B', 2, 2, 1);
INSERT INTO userr (id_user, skills, password_user, role_user, id_profession, id_address, manager_id) VALUES 
(3, 'JavaScript, HTML', 'password3', 'A', 3, 3, 1);
INSERT INTO userr (id_user, skills, password_user, role_user, id_profession, id_address, manager_id) VALUES 
(4, 'C#, .NET', 'password4', 'B', 4, 4, 1);
INSERT INTO userr (id_user, skills, password_user, role_user, id_profession, id_address, manager_id) VALUES 
(5, 'Go, Rust', 'password5', 'A', 5, 5, 2);
INSERT INTO userr (id_user, skills, password_user, role_user, id_profession, id_address, manager_id) VALUES 
(6, 'Ruby, Rails', 'password6', 'B', 6, 6, 2);
INSERT INTO userr (id_user, skills, password_user, role_user, id_profession, id_address, manager_id) VALUES 
(7, 'PHP, Laravel', 'password7', 'A', 7, 7, 3);
INSERT INTO userr (id_user, skills, password_user, role_user, id_profession, id_address, manager_id) VALUES 
(8, 'Swift, iOS', 'password8', 'B', 8, 8, 3);
INSERT INTO userr (id_user, skills, password_user, role_user, id_profession, id_address, manager_id) VALUES 
(9, 'Kotlin, Android', 'password9', 'A', 9, 9, 4);
INSERT INTO userr (id_user, skills, password_user, role_user, id_profession, id_address, manager_id) VALUES 
(10, 'Perl, CGI', 'password10', 'B', 10, 10, 4);

select * from userr;

-- Materials Table
INSERT INTO materials (id_materials, material_name, material_description, material_quantity) VALUES 
(1, 'Copper Wire', 'Conductive copper wire', 50);
INSERT INTO materials (id_materials, material_name, material_description, material_quantity) VALUES 
(2, 'Electrical Tape', 'Insulating tape for wiring', 300);
INSERT INTO materials (id_materials, material_name, material_description, material_quantity) VALUES 
(3, 'Circuit Breaker', 'Electrical protection device', 200);
INSERT INTO materials (id_materials, material_name, material_description, material_quantity) VALUES 
(4, 'Conduit', 'Protective tubing for electrical wiring', 500);
INSERT INTO materials (id_materials, material_name, material_description, material_quantity) VALUES 
(5, 'Light Switch', 'Switch for controlling lights', 1000);
INSERT INTO materials (id_materials, material_name, material_description, material_quantity) VALUES 
(6, 'Power Outlet', 'Electrical socket for power supply', 400);
INSERT INTO materials (id_materials, material_name, material_description, material_quantity) VALUES 
(7, 'LED Bulb', 'Energy-efficient light-emitting diode bulb', 700);
INSERT INTO materials (id_materials, material_name, material_description, material_quantity) VALUES 
(8, 'Wire Connectors', 'Connectors for joining electrical wires', 800);
INSERT INTO materials (id_materials, material_name, material_description, material_quantity) VALUES 
(9, 'Extension Cord', 'Flexible electrical power cable', 600);
INSERT INTO materials (id_materials, material_name, material_description, material_quantity) VALUES 
(10, 'Fuse', 'Overcurrent protection device', 900);
INSERT INTO materials (id_materials, material_name, material_description, material_quantity) VALUES 
(11, 'GlueGun', 'Overcurrent protection device', 951.58);

select * from materials;


-- Task Table
INSERT INTO task (id_task, task_name, task_description, actual_status, date_of_creation, date_of_completion, comments, id_user, id_client, parent_task_id) VALUES 
(1, 'Electrical Work', 'Install wiring in Building A', 'Completed', TO_DATE('2024-05-01', 'YYYY-MM-DD'), TO_DATE('2024-05-10', 'YYYY-MM-DD'), 'N/A', 1, 1, NULL);
INSERT INTO task (id_task, task_name, task_description, actual_status, date_of_creation, date_of_completion, comments, id_user, id_client, parent_task_id) VALUES 
(2, 'Plumbing Work', 'Install pipes in Building B', 'Completed', TO_DATE('2024-05-02', 'YYYY-MM-DD'), TO_DATE('2024-05-11', 'YYYY-MM-DD'), 'N/A', 2, 2, NULL);
INSERT INTO task (id_task, task_name, task_description, actual_status, date_of_creation, date_of_completion, comments, id_user, id_client, parent_task_id) VALUES 
(3, 'Carpentry Work', 'Install doors in Building C', 'Completed', TO_DATE('2024-05-03', 'YYYY-MM-DD'), TO_DATE('2024-05-12', 'YYYY-MM-DD'), 'N/A', 3, 3, NULL);
INSERT INTO task (id_task, task_name, task_description, actual_status, date_of_creation, date_of_completion, comments, id_user, id_client, parent_task_id) VALUES 
(4, 'Welding Work', 'Weld frames in Building D', 'Completed', TO_DATE('2024-05-04', 'YYYY-MM-DD'), TO_DATE('2024-05-13', 'YYYY-MM-DD'), 'N/A', 4, 4, NULL);
INSERT INTO task (id_task, task_name, task_description, actual_status, date_of_creation, date_of_completion, comments, id_user, id_client, parent_task_id) VALUES 
(5, 'Painting Work', 'Paint walls in Building E', 'Completed', TO_DATE('2024-05-05', 'YYYY-MM-DD'), TO_DATE('2024-05-14', 'YYYY-MM-DD'), 'N/A', 5, 5, NULL);
INSERT INTO task (id_task, task_name, task_description, actual_status, date_of_creation, date_of_completion, comments, id_user, id_client, parent_task_id) VALUES 
(6, 'Masonry Work', 'Lay bricks in Building F', 'Completed', TO_DATE('2024-05-06', 'YYYY-MM-DD'), TO_DATE('2024-05-15', 'YYYY-MM-DD'), 'N/A', 6, 6, NULL);
INSERT INTO task (id_task, task_name, task_description, actual_status, date_of_creation, date_of_completion, comments, id_user, id_client, parent_task_id) VALUES 
(7, 'Mechanical Work', 'Repair machines in Building G', 'Completed', TO_DATE('2024-05-07', 'YYYY-MM-DD'), TO_DATE('2024-05-16', 'YYYY-MM-DD'), 'N/A', 7, 7, NULL);
INSERT INTO task (id_task, task_name, task_description, actual_status, date_of_creation, date_of_completion, comments, id_user, id_client, parent_task_id) VALUES 
(8, 'Technical Work', 'Install technical equipment in Building H', 'Completed', TO_DATE('2024-05-08', 'YYYY-MM-DD'), TO_DATE('2024-05-17', 'YYYY-MM-DD'), 'N/A', 8, 8, NULL);
INSERT INTO task (id_task, task_name, task_description, actual_status, date_of_creation, date_of_completion, comments, id_user, id_client, parent_task_id) VALUES 
(9, 'Engineering Work', 'Supervise construction in Building I', 'Completed', TO_DATE('2024-05-09', 'YYYY-MM-DD'), TO_DATE('2024-05-18', 'YYYY-MM-DD'), 'N/A', 9, 9, NULL);
INSERT INTO task (id_task, task_name, task_description, actual_status, date_of_creation, date_of_completion, comments, id_user, id_client, parent_task_id) VALUES 
(10, 'Architectural Work', 'Design Building J', 'Completed', TO_DATE('2024-05-10', 'YYYY-MM-DD'), TO_DATE('2024-05-19', 'YYYY-MM-DD'), 'N/A', 10, 10, NULL);
INSERT INTO task (id_task, task_name, task_description, actual_status, date_of_creation, date_of_completion, comments, id_user, id_client, parent_task_id) VALUES 
(12, 'Architectural Work', 'Design Building J', 'Completed', TO_DATE('2022-05-10', 'YYYY-MM-DD'), TO_DATE('2022-05-19', 'YYYY-MM-DD'),null , 10, 10, NULL);


select * from task;

-- Place of Work Table
INSERT INTO place_of_work (id_place_of_work, construction_name, id_address) VALUES 
(1, 'Building A', 1);
INSERT INTO place_of_work (id_place_of_work, construction_name, id_address) VALUES 
(2, 'Building B', 2);
INSERT INTO place_of_work (id_place_of_work, construction_name, id_address) VALUES 
(3, 'Building C', 3);
INSERT INTO place_of_work (id_place_of_work, construction_name, id_address) VALUES 
(4, 'Building D', 4);
INSERT INTO place_of_work (id_place_of_work, construction_name, id_address) VALUES 
(5, 'Building E', 5);
INSERT INTO place_of_work (id_place_of_work, construction_name, id_address) VALUES 
(6, 'Building F', 6);
INSERT INTO place_of_work (id_place_of_work, construction_name, id_address) VALUES 
(7, 'Building G', 7);
INSERT INTO place_of_work (id_place_of_work, construction_name, id_address) VALUES 
(8, 'Building H', 8);
INSERT INTO place_of_work (id_place_of_work, construction_name, id_address) VALUES 
(9, 'Building I', 9);
INSERT INTO place_of_work (id_place_of_work, construction_name, id_address) VALUES 
(10, 'Building J', 10);

select * from place_of_work;

INSERT INTO work_record (id_work_record, description, date_work_record, id_user, id_task, id_place_of_work) VALUES 
(1, 'Work description 1', TO_DATE('2024-05-01', 'YYYY-MM-DD'), 1, 1, 1);
INSERT INTO work_record (id_work_record, description, date_work_record, id_user, id_task, id_place_of_work) VALUES 
(2, 'Work description 2', TO_DATE('2024-05-02', 'YYYY-MM-DD'), 2, 2, 2);
INSERT INTO work_record (id_work_record, description, date_work_record, id_user, id_task, id_place_of_work) VALUES 
(3, 'Work description 3', TO_DATE('2024-05-03', 'YYYY-MM-DD'), 3, 3, 3);
INSERT INTO work_record (id_work_record, description, date_work_record, id_user, id_task, id_place_of_work) VALUES 
(4, 'Work description 4', TO_DATE('2024-05-04', 'YYYY-MM-DD'), 4, 4, 4);
INSERT INTO work_record (id_work_record, description, date_work_record, id_user, id_task, id_place_of_work) VALUES 
(5, 'Work description 5', TO_DATE('2024-05-05', 'YYYY-MM-DD'), 5, 5, 5);
INSERT INTO work_record (id_work_record, description, date_work_record, id_user, id_task, id_place_of_work) VALUES 
(6, 'Work description 6', TO_DATE('2024-05-06', 'YYYY-MM-DD'), 6, 6, 6);
INSERT INTO work_record (id_work_record, description, date_work_record, id_user, id_task, id_place_of_work) VALUES 
(7, 'Work description 7', TO_DATE('2024-05-07', 'YYYY-MM-DD'), 7, 7, 7);
INSERT INTO work_record (id_work_record, description, date_work_record, id_user, id_task, id_place_of_work) VALUES 
(8, 'Work description 8', TO_DATE('2024-05-08', 'YYYY-MM-DD'), 8, 8, 8);
INSERT INTO work_record (id_work_record, description, date_work_record, id_user, id_task, id_place_of_work) VALUES 
(9, 'Work description 9', TO_DATE('2024-05-09', 'YYYY-MM-DD'), 9, 9, 9);
INSERT INTO work_record (id_work_record, description, date_work_record, id_user, id_task, id_place_of_work) VALUES 
(10, 'Work description 10', TO_DATE('2024-05-10', 'YYYY-MM-DD'), 10, 10, 10);

select * from work_record;

-- Materials Used Table
INSERT INTO materials_used (quantity_used, id_work_record, id_materials) VALUES 
(10, 1, 1);
INSERT INTO materials_used (quantity_used, id_work_record, id_materials) VALUES 
(20, 2, 2);
INSERT INTO materials_used (quantity_used, id_work_record, id_materials) VALUES 
(30, 3, 3);
INSERT INTO materials_used (quantity_used, id_work_record, id_materials) VALUES 
(40, 4, 4);
INSERT INTO materials_used (quantity_used, id_work_record, id_materials) VALUES 
(50, 5, 5);
INSERT INTO materials_used (quantity_used, id_work_record, id_materials) VALUES 
(60, 6, 6);
INSERT INTO materials_used (quantity_used, id_work_record, id_materials) VALUES 
(70, 7, 7);
INSERT INTO materials_used (quantity_used, id_work_record, id_materials) VALUES 
(80, 8, 8);
INSERT INTO materials_used (quantity_used, id_work_record, id_materials) VALUES 
(90, 9, 9);
INSERT INTO materials_used (quantity_used, id_work_record, id_materials) VALUES 
(100, 10, 10);

select* from materials_used;


-- Certification Table
INSERT INTO certification (id_certification, id_profession, certification_name) VALUES 
(1, 1, 'Certified Electrician');
INSERT INTO certification (id_certification, id_profession, certification_name) VALUES 
(2, 2, 'Certified Plumber');
INSERT INTO certification (id_certification, id_profession, certification_name) VALUES 
(3, 3, 'Certified Carpenter');
INSERT INTO certification (id_certification, id_profession, certification_name) VALUES 
(4, 4, 'Certified Welder');
INSERT INTO certification (id_certification, id_profession, certification_name) VALUES 
(5, 5, 'Certified Painter');
INSERT INTO certification (id_certification, id_profession, certification_name) VALUES 
(6, 6, 'Certified Mason');
INSERT INTO certification (id_certification, id_profession, certification_name) VALUES 
(7, 7, 'Certified Mechanic');
INSERT INTO certification (id_certification, id_profession, certification_name) VALUES 
(8, 8, 'Certified Technician');
INSERT INTO certification (id_certification, id_profession, certification_name) VALUES 
(9, 9, 'Certified Engineer');
INSERT INTO certification (id_certification, id_profession, certification_name) VALUES 
(10, 10, 'Certified Architect');

select * from certification;

-- User-Profession Relationship Table
INSERT INTO user_profession (id_user, id_profession) VALUES 
(1, 1);
INSERT INTO user_profession (id_user, id_profession) VALUES 
(2, 2);
INSERT INTO user_profession (id_user, id_profession) VALUES 
(3, 3);
INSERT INTO user_profession (id_user, id_profession) VALUES 
(4, 4);
INSERT INTO user_profession (id_user, id_profession) VALUES 
(5, 5);
INSERT INTO user_profession (id_user, id_profession) VALUES 
(6, 6);
INSERT INTO user_profession (id_user, id_profession) VALUES 
(7, 7);
INSERT INTO user_profession (id_user, id_profession) VALUES 
(8, 8);
INSERT INTO user_profession (id_user, id_profession) VALUES 
(9, 9);
INSERT INTO user_profession (id_user, id_profession) VALUES 
(10, 10);

select * from user_profession;

-- Client-Task Relationship Table
INSERT INTO client_task (id_client, id_task, role) VALUES 
(1, 1, 'Owner');
INSERT INTO client_task (id_client, id_task, role) VALUES 
(2, 2, 'Owner');
INSERT INTO client_task (id_client, id_task, role) VALUES 
(3, 3, 'Owner');
INSERT INTO client_task (id_client, id_task, role) VALUES 
(4, 4, 'Owner');
INSERT INTO client_task (id_client, id_task, role) VALUES 
(5, 5, 'Owner');
INSERT INTO client_task (id_client, id_task, role) VALUES 
(6, 6, 'Owner');
INSERT INTO client_task (id_client, id_task, role) VALUES 
(7, 7, 'Owner');
INSERT INTO client_task (id_client, id_task, role) VALUES 
(8, 8, 'Owner');
INSERT INTO client_task (id_client, id_task, role) VALUES 
(9, 9, 'Owner');
INSERT INTO client_task (id_client, id_task, role) VALUES 
(10, 10, 'Owner');
INSERT INTO client_task (id_client, id_task, role) VALUES 
(10, 9, 'Customer');

select* from client_task;

-- Work Record Table


-- Work Record History Table
INSERT INTO work_record_history (modified_at, old_description, new_description, id_work_record, id_user) VALUES 
(TO_DATE('2024-05-11', 'YYYY-MM-DD'), 'Old description 1', 'New description 1', 1, 1);
INSERT INTO work_record_history (modified_at, old_description, new_description, id_work_record, id_user) VALUES 
(TO_DATE('2024-05-12', 'YYYY-MM-DD'), 'Old description 2', 'New description 2', 2, 2);
INSERT INTO work_record_history (modified_at, old_description, new_description, id_work_record, id_user) VALUES 
(TO_DATE('2024-05-13', 'YYYY-MM-DD'), 'Old description 3', 'New description 3', 3, 3);
INSERT INTO work_record_history (modified_at, old_description, new_description, id_work_record, id_user) VALUES 
(TO_DATE('2024-05-14', 'YYYY-MM-DD'), 'Old description 4', 'New description 4', 4, 4);
INSERT INTO work_record_history (modified_at, old_description, new_description, id_work_record, id_user) VALUES 
(TO_DATE('2024-05-15', 'YYYY-MM-DD'), 'Old description 5', 'New description 5', 5, 5);
INSERT INTO work_record_history (modified_at, old_description, new_description, id_work_record, id_user) VALUES 
(TO_DATE('2024-05-16', 'YYYY-MM-DD'), 'Old description 6', 'New description 6', 6, 6);
INSERT INTO work_record_history (modified_at, old_description, new_description, id_work_record, id_user) VALUES 
(TO_DATE('2024-05-17', 'YYYY-MM-DD'), 'Old description 7', 'New description 7', 7, 7);
INSERT INTO work_record_history (modified_at, old_description, new_description, id_work_record, id_user) VALUES 
(TO_DATE('2024-05-18', 'YYYY-MM-DD'), 'Old description 8', 'New description 8', 8, 8);
INSERT INTO work_record_history (modified_at, old_description, new_description, id_work_record, id_user) VALUES 
(TO_DATE('2024-05-19', 'YYYY-MM-DD'), 'Old description 9', 'New description 9', 9, 9);
INSERT INTO work_record_history (modified_at, old_description, new_description, id_work_record, id_user) VALUES 
(TO_DATE('2024-05-20', 'YYYY-MM-DD'), 'Old description 10', 'New description 10', 10, 10);

select * from work_record_history;

-- Feedback Table
INSERT INTO feedback (id_feedback, feedback_text, id_client, id_user) VALUES 
(1, 'Great work!', 1, NULL);
INSERT INTO feedback (id_feedback, feedback_text, id_client, id_user) VALUES 
(2, 'Satisfactory.', 2, NULL);
INSERT INTO feedback (id_feedback, feedback_text, id_client, id_user) VALUES 
(3, 'Needs improvement.', 3, NULL);
INSERT INTO feedback (id_feedback, feedback_text, id_client, id_user) VALUES 
(4, 'Excellent service!', 4, NULL);
INSERT INTO feedback (id_feedback, feedback_text, id_client, id_user) VALUES 
(5, 'Well done!', 5, NULL);
INSERT INTO feedback (id_feedback, feedback_text, id_client, id_user) VALUES 
(6, 'Could be better.', 6, NULL);
INSERT INTO feedback (id_feedback, feedback_text, id_client, id_user) VALUES 
(7, 'Very satisfied.', 7, NULL);
INSERT INTO feedback (id_feedback, feedback_text, id_client, id_user) VALUES 
(8, 'Highly recommend.', 8, NULL);
INSERT INTO feedback (id_feedback, feedback_text, id_client, id_user) VALUES 
(9, 'Okay service.', 9, NULL);
INSERT INTO feedback (id_feedback, feedback_text, id_client, id_user) VALUES 
(10, 'Superb job!', 10, NULL);
INSERT INTO feedback (id_feedback, feedback_text, id_client, id_user) VALUES 
(11, 'Superb job8156548!', 10, NULL);
select * from feedback;

ALTER TABLE materials ADD material_image BLOB;
select * from materials;

--------------------SELECT-----------------
--Napište dotaz pro spojování øetìzcù pomocí ||
select distinct first_name ||' '|| last_name as full_name 
from person;

--CONCAT
select distinct concat(first_name,CONCAT(' ',last_name)) as full_nameConc
from person;

---WHERE podmínky pro výbìr øídkù o Funkce LOWER, UPPER, INITCAP 
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


------ORDER BY atr [ASC/DESC] ,Tøídìní podle jednoho nebo vice atributù 
SELECT DISTINCT first_name, last_name, email
FROM person
ORDER BY last_name ASC;

SELECT DISTINCT first_name,last_name
FROM person
ORDER BY last_name DESC;

SELECT DISTINCT task_name, date_of_creation, date_of_completion
FROM task
ORDER BY task_name ASC;

-------Jednoøádkové funkce ,víceøádkové funkce MIN, MAX, AVG, SUM, COUNT
-- Jednoøádkové funkce
SELECT 
    LOWER(first_name) AS lower_first_name,
    UPPER(last_name) AS upper_last_name
FROM person;

-- Víceøádkové (agregaèní) funkce
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


SELECT 
    id_task,
    task_name,
    date_of_creation,
    SYSDATE AS current_date,
    MONTHS_BETWEEN(SYSDATE, date_of_creation) AS months_since_creation
FROM task;


SELECT 
    SYSDATE AS current_date,
    ADD_MONTHS(SYSDATE, 3) AS date_after_3_months
FROM DUAL;

SELECT 
    SYSDATE AS current_date,
    NEXT_DAY(SYSDATE, 'piatok') AS next_friday
FROM DUAL;

-- Nalezení posledního dne v mìsíci pro SYSDATE
SELECT 
    SYSDATE AS current_date,
    LAST_DAY(SYSDATE) AS last_day_of_current_month
FROM DUAL;

SELECT 
    SYSDATE AS current_date,
    ROUND(SYSDATE, 'MONTH') AS rounded_date,
    TRUNC(SYSDATE, 'MONTH') AS truncated_date
FROM DUAL;

----TO_CHAR, TO_NUMBER, TO_DATE

SELECT 
    id_task,
    task_name,
    TO_CHAR(date_of_creation, 'DD-MM-YYYY') AS creation_date_formatted
FROM 
    task;

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

-- Pøíklad: nahrazení NULL ve sloupci `comments` v tabulce `task` hodnotou 'No Comments'
SELECT 
    id_task,
    task_name,
    NVL(comments, 'No Comments') AS comments_or_default
FROM 
    task;

select * from task;


-- Pøíklad: pokud je `feedback_text` ne-NULL, vrátí 'Feedback Provided', jinak 'No Feedback'
SELECT 
    id_feedback,
    feedback_text,
    NVL2(feedback_text, 'Feedback Provided', 'No Feedback') AS feedback_status
FROM 
    feedback;
    
-- Pøíklad: pokud je `role` v tabulce `client_task` 'Owner', vrátí NULL, jinak vrátí hodnotu role
SELECT 
    id_client,
    id_task,
    role,
    NULLIF(role, 'Owner') AS role_or_null
FROM 
    client_task;

-- Pøíklad: vrátí první ne-NULL hodnotu z `feedback_text`, `comments`, nebo 'No Data' pokud jsou všechny NULL
SELECT 
    id_feedback,
    COALESCE(feedback_text, comments, 'No Data') AS first_non_null
FROM 
    feedback
LEFT JOIN 
    task ON feedback.id_user = task.id_user;
    
select *from feedback;
------------DECODE, CASE, IF-THEN-ELSE 
-- Pøíklad: Použití DECODE pro pøevod hodnoty `role_user` v tabulce `userr`
SELECT 
    id_user,
    role_user,
    DECODE(role_user, 'A', 'Admin', 'B', 'Basic User', 'Unknown Role') AS role_description
FROM 
    userr;

-- Pøíklad: Použití CASE pro pøevod hodnoty `actual_status` v tabulce `task`
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

    

-----Spojování 2x stejné tabulky s pøejmenováním (vazba mezi nadøízenými a podøízenými v jedné tabulce) 
---Hierarchické dotazování – stromová struktura zanoøení START WITH, CONNECT BY PRIOR, LEVEL
-- Spojení tabulky userr dvakrát pro vazbu mezi nadøízenými a podøízenými
SELECT 
    u1.id_user AS subordinate_id,
    u1.skills AS subordinate_skills,
    u2.id_user AS manager_id,
    u2.skills AS manager_skills
FROM 
    userr u1
LEFT JOIN 
    userr u2 ON u1.manager_id = u2.id_user;

-- Hierarchické dotazování pro zobrazení stromové struktury nadøízených a podøízených
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

-----COUNT, COUNT(DISTINCT ), NVL  Rozdíl mezi COUNT (*) a COUNT (atribut) Proè NVL u agregaèních funkcí 

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


-------Vnoøené dotazy ,Výsledek jako jediná hodnota ,Vícesloupcový poddotaz ,EXISTS, NOT EXISTS 
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


-------Jednoøádkové poddotazy 
---Zobrazíme poèet úkolù pro jednotlivé uživatele a pouze ty, kteøí mají více úkolù než prùmìrný poèet úkolù na uživatele:
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


-----Víceøádkové poddotazy IN, ANY, ALL ,NULL hodnoty v poddotazech 
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

--INLINE VIEW Poddotaz v podobì tabulky SELECT atr FROM (SELECT * FROM Tab) alt_tab 
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




-- Drop Constraints
ALTER TABLE materials_used DROP CONSTRAINT materials_used_materials_fk;
ALTER TABLE materials_used DROP CONSTRAINT materials_used_work_record_fk;
ALTER TABLE place_of_work DROP CONSTRAINT place_of_work_address_fk;
ALTER TABLE task DROP CONSTRAINT task_client_fk;
ALTER TABLE task DROP CONSTRAINT task_userr_fk;
ALTER TABLE task DROP CONSTRAINT task_parent_fk;
ALTER TABLE userr DROP CONSTRAINT userr_address_fk;
ALTER TABLE userr DROP CONSTRAINT userr_profession_fk;
ALTER TABLE userr DROP CONSTRAINT userr_manager_fk;
ALTER TABLE work_record_history DROP CONSTRAINT work_history_work_record_fk;
ALTER TABLE work_record_history DROP CONSTRAINT work_record_history_userr_fk;
ALTER TABLE work_record DROP CONSTRAINT work_record_place_of_work_fk;
ALTER TABLE work_record DROP CONSTRAINT work_record_task_fk;
ALTER TABLE work_record DROP CONSTRAINT work_record_userr_fk;
ALTER TABLE feedback DROP CONSTRAINT feedback_client_fk;
ALTER TABLE feedback DROP CONSTRAINT feedback_user_fk;
ALTER TABLE feedback DROP CONSTRAINT feedback_client_user_chk;
ALTER TABLE client DROP CONSTRAINT client_fk;
ALTER TABLE certification DROP CONSTRAINT certification_profession_fk;
ALTER TABLE certification DROP CONSTRAINT certification_profession_id_pk;
ALTER TABLE client_task DROP CONSTRAINT client_task_client_fk;
ALTER TABLE client_task DROP CONSTRAINT client_task_task_fk;
ALTER TABLE user_profession DROP CONSTRAINT user_profession_userr_fk;
ALTER TABLE user_profession DROP CONSTRAINT user_profession_profession_fk;

-- Drop Tables
DROP TABLE materials_used;
DROP TABLE work_record_history;
DROP TABLE work_record;
DROP TABLE client_task;
DROP TABLE task;
DROP TABLE user_profession;
DROP TABLE certification;
DROP TABLE userr;
DROP TABLE client;
DROP TABLE person;
DROP TABLE materials;
DROP TABLE profession;
DROP TABLE place_of_work;
DROP TABLE feedback;
DROP TABLE address;




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
    
    

-- Hierarchické dotazování pro zobrazení stromové struktury nadøízených a podøízených
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
    
    
--------Množinové operace v SQL – UNION, UNION ALL, INTERSECT, MINUS ,ORDER BY u množinových operací 
SELECT id_user FROM userr
UNION
SELECT id_user FROM user_profession
ORDER BY id_user;

SELECT id_user FROM userr
UNION ALL
SELECT id_user FROM user_profession
ORDER BY id_user;


SELECT id_client FROM client
INTERSECT
SELECT id_client FROM task
ORDER BY id_client;



SELECT id_client FROM client
MINUS
SELECT id_client FROM task
ORDER BY id_client;


----DATUMY

SELECT 
    id_task,
    task_name,
    date_of_creation,
    SYSDATE AS current_date,
    MONTHS_BETWEEN(SYSDATE, date_of_creation) AS months_since_creation
FROM task;


SELECT 
    SYSDATE AS current_date,
    ADD_MONTHS(SYSDATE, 3) AS date_after_3_months
FROM DUAL;

SELECT 
    SYSDATE AS current_date,
    NEXT_DAY(SYSDATE, 'piatok') AS next_friday
FROM DUAL;

SELECT 
    SYSDATE AS current_date,
    LAST_DAY(SYSDATE) AS last_day_of_current_month
FROM DUAL;


--FULL JOIN
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

