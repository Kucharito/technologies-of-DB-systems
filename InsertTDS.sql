
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