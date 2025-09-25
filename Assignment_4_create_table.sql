CREATE DATABASE create_table_database;
use create_table_database;

-- QUE1
CREATE TABLE countries(
	country_id int(10),
    country_name varchar(50),
    region_id int(20)
);

-- QUE2
CREATE TABLE IF NOT EXISTS countries(
	country_id int(10),
    country_name varchar(50),
    region_id int(20)
);

-- QUE3
CREATE TABLE dup_countries
LIKE countries;
SHOW TABLES;

-- QUE4
CREATE TABLE dup_countries AS
SELECT * FROM countries;
-- copy the structure including constraints,
CREATE TABLE dup_countries LIKE countries;
INSERT INTO dup_countries SELECT * FROM countries;

-- QUE5
CREATE TABLE countries1 (
    country_id VARCHAR(2) NULL,
    country_name VARCHAR(40) NULL,
    region_id DECIMAL(10, 0) NULL
);

-- QUE6
CREATE TABLE jobs(
	job_id int(10),
    job_title VARCHAR(40),
    min_salary int,
    max_salary int check(max_salary > 25000)
);

-- QUE7
CREATE TABLE countries2 (
    country_id VARCHAR(2) NULL,
    country_name ENUM('Italy', 'India', 'China'),
    region_id DECIMAL(10, 0) NULL
);

-- QUE8
CREATE TABLE job_history(
	employee_id int(2) UNIQUE NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    job_id varchar(10) NOT NULL,
    department_id int(10) NOT NULL
);
INSERT INTO job_history (job_id, start_date, end_date)
VALUES (101, '2025-09-01', STR_TO_DATE('23/09/2025', '%d/%m/%Y'));

-- QUE9
CREATE TABLE IF NOT EXISTS countries(
	country_id int(10) PRIMARY KEY,
    country_name varchar(50) NOT NULL,
    region_id int(20) NOT NULL
);

-- QUE10
DROP TABLE jobs;
CREATE TABLE jobs(
	job_id int(10) PRIMARY KEY,
    job_title VARCHAR(40) DEFAULT NULL,
    min_salary  decimal(6,0) check(min_salary > 8000 ),
    max_salary  decimal(6,0) DEFAULT NULL
);

-- QUE11
DROP TABLE countries;
CREATE TABLE countries(
	country_id int(2) PRIMARY KEY,
    country_name VARCHAR(50),
    region_id DECIMAL(4.0)
);

-- QUE12
DROP TABLE countries;
CREATE TABLE countries(
	country_id int(2) AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(50),
    region_id DECIMAL(4.0)
);

-- QUE13
DROP TABLE countries;
CREATE TABLE countries(
	country_id int(2) AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(50),
    region_id DECIMAL(4.0),
    UNIQUE (country_id, region_id)
);

-- QUE14
DROP TABLE job_history;
CREATE TABLE job_history(
	employee_id int(2) UNIQUE,
    start_date date NOT NULL,
    end_date date NOT NULL,
    job_id int(10) NOT NULL,
    department_id int(10) NOT NULL,
    FOREIGN KEY (job_id) REFERENCES jobs(job_id)
);
describe jobs;
DESC jobs;

-- QUE15
CREATE TABLE departments (
    department_id DECIMAL(4.0),
    department_name VARCHAR(50) NULL,
    manager_id DECIMAL(6.0) ,
    location_id DECIMAL(4.0) NULL,
    PRIMARY KEY (department_id, manager_id)
);
-- DROP TABLE employee;
CREATE TABLE employee (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(15),
    last_name VARCHAR(10),
    phone_number INT,
    hire_date DATE,
    job_id INT,
    salary DECIMAL(6,2),
    commission DECIMAL(5,2),
    manager_id INT,
    department_id INT
);

-- QUE16
CREATE TABLE department (
    department_id DECIMAL(4.0),
    department_name VARCHAR(50) NULL,
    manager_id DECIMAL(6.0) ,
    location_id DECIMAL(4.0) NULL,
    PRIMARY KEY (department_id, manager_id)
);
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    hire_date DATE NOT NULL,
    job_id INT NOT NULL,
    salary DECIMAL(10,2),
    commission DECIMAL(5,2),
    manager_id INT,
    department_id DECIMAL(4.0),
    FOREIGN KEY (department_id) REFERENCES department(department_id),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id)
) ENGINE = InnoDB;

-- 	QUE 20
CREATE TABLE jobs1 (
    job_id INT NOT NULL PRIMARY KEY,
    job_title VARCHAR(35) NOT NULL DEFAULT '',
    min_salary DECIMAL(6,0) DEFAULT 8000,
    max_salary DECIMAL(6,0) DEFAULT NULL
) ENGINE = InnoDB;
CREATE TABLE IF NOT EXISTS employee (
    employee_id INT NOT NULL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    job_id INT NOT NULL,
    salary DECIMAL(10,2),
    FOREIGN KEY (job_id) REFERENCES jobs1(job_id)
	ON UPDATE CASCADE
	ON DELETE RESTRICT
) ENGINE = InnoDB;

-- QUE 18

















