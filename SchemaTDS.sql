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