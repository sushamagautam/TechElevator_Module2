BEGIN TRANSACTION;

CREATE TABLE employee (
        employee_id serial NOT NULL,
        job_id serial NOT NULL,                 --FK for job_title table
        last_name varchar(40) NOT NULL,
        first_name varchar(35) NOT NULL,
        gender varchar(10) NOT NULL,
        date_of_birth date NOT NULL,
        hire_date date NOT NULL,
        department_id serial,                   --FK for department table
        
        CONSTRAINT pk_employee_employee_id PRIMARY KEY (employee_id)

);

CREATE TABLE job_title(
        job_id serial NOT NULL,
        title varchar (45),
        
        CONSTRAINT pk_job_title_job_id PRIMARY KEY (job_id)

);

CREATE TABLE department (
        department_id serial NOT NULL,
        name varchar(40) NOT NULL,
        
        CONSTRAINT pk_department_department_id PRIMARY KEY (department_id)

);

CREATE TABLE project (
        project_id serial NOT NULL,             --FK for employee_project
        name varchar(45),
        start_date DATE NOT NULL,
        
        CONSTRAINT pk_project_project_id Primary Key (project_id)

);

CREATE TABLE employee_project (
        employee_id serial NOT NULL,
        project_id serial NOT NULL,
        
        CONSTRAINT pk_employee_project_employee_id_project_id PRIMARY KEY (employee_id, project_id)
       
);


INSERT INTO job_title (job_id, title) VALUES (1, 'Doctor');
INSERT INTO job_title (job_id, title) VALUES (2, 'Developer');
INSERT INTO job_title (job_id, title) VALUES (3, 'Lawyer');
INSERT INTO job_title (job_id, title) VALUES (4, 'UX Designer');
INSERT INTO job_title (job_id, title) VALUES (5, 'Business Analyst');


INSERT INTO employee (last_name, first_name, gender, job_id, department_id, date_of_birth, hire_date) VALUES ('Smith', 'Bob', 'Male', 4, 3, '1989-01-12', '2017-10-14');
INSERT INTO employee (last_name, first_name, gender, job_id, department_id, date_of_birth, hire_date) VALUES ('Phil', 'Sherlock', 'Male', 2, 3, '1985-07-19', '2018-10-28');
INSERT INTO employee (last_name, first_name, gender, job_id, department_id, date_of_birth, hire_date) VALUES ('Calma', 'Alexis', 'Female', 2, 1, '1983-05-12', '2015-05-15');
INSERT INTO employee (last_name, first_name, gender, job_id, department_id, date_of_birth, hire_date) VALUES ('Robland', 'Sean', 'Male', 5, 3, '1978-01-12', '2014-12-14');
INSERT INTO employee (last_name, first_name, gender, job_id, department_id, date_of_birth, hire_date) VALUES ('Simpson', 'Mary', 'Femle', 1, 2, '1986-12-12', '2016-08-19');
INSERT INTO employee (last_name, first_name, gender, job_id, department_id, date_of_birth, hire_date) VALUES ('Holmes', 'Sunny', 'Male', 4, 3,'1854-01-06','1881-10-14');
INSERT INTO employee (last_name, first_name, gender, job_id, department_id, date_of_birth, hire_date) VALUES ('Watson', 'John', 'Male', 2, 3, '1852-07-07','1881-10-14');
INSERT INTO employee (last_name, first_name, gender, job_id, department_id, date_of_birth, hire_date) VALUES ('Hooper', 'Molly', 'Female', 2, 1, '1858-12-21', '1882-06-12');


INSERT INTO department (department_id, name) VALUES(1, 'Jefferson Hospital');
INSERT INTO department (department_id, name) VALUES(2, 'Comcast');
INSERT INTO department (department_id, name) VALUES(3, 'Family court');
INSERT INTO department (department_id, name) VALUES(4, 'Accenture');

INSERT INTO project (project_id, name, start_date) VALUES (1, 'Project huntsville', '1986-08-18' );
INSERT INTO project (project_id, name, start_date) VALUES (2, 'Project bakersville', '1950-08-18' );
INSERT INTO project (project_id, name, start_date) VALUES (3, 'Project countryville', '1971-08-18' );
INSERT INTO project (project_id, name, start_date) VALUES (4, 'Project cityville', '1991-08-18' );



ALTER TABLE employee
ADD FOREIGN KEY (job_id)
REFERENCES job_title (job_id);

ALTER TABLE employee
ADD FOREIGN KEY (department_id)
REFERENCES department (department_id);

ALTER TABLE employee_project
ADD FOREIGN KEY (employee_id)
REFERENCES employee (employee_id);

ALTER TABLE employee_project
ADD FOREIGN KEY (project_id)
REFERENCES project(project_id);


COMMIT;