CREATE DATABASE ALTER_TABLE_ASS0GNMENT;
USE ALTER_TABLE_ASS0GNMENT;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    address VARCHAR(100)
);
-- Create 'employees' table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age VARCHAR(10),  -- This will be modified later to INT
    salary DECIMAL(10, 2),
    department_id INT
);

-- Create 'contacts' table
CREATE TABLE contacts (
    contact_id INT PRIMARY KEY,
    name VARCHAR(50),
    address VARCHAR(100)  -- This will be renamed later to 'home_address'
);

-- Create 'departments' table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- Create 'students' table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

-- Create 'users' table
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50),
    email VARCHAR(100)  -- This will have a unique constraint added later
);

-- Create 'inventory' table
CREATE TABLE inventory (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    quantity INT  -- Default value will be set later
);

-- Create 'products' table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50),
    price DECIMAL(10, 2)
);

-- Create 'locations' table
CREATE TABLE locations (
    location_id INT,
    street_address VARCHAR(100),
    postal_code VARCHAR(20),
    city VARCHAR(50),
    state_province VARCHAR(50),  -- This will be renamed to 'state' later
    country_id VARCHAR(2),
    PRIMARY KEY (location_id)
);

-- Create 'job_history' table
CREATE TABLE job_history (
    employee_id INT,
    job_id VARCHAR(10),
    department_id INT,
    start_date DATE,
    end_date DATE
);

-- Create 'jobs' table
CREATE TABLE jobs (
    job_id VARCHAR(10) PRIMARY KEY,
    job_title VARCHAR(50),
    min_salary DECIMAL(10, 2),
    max_salary DECIMAL(10, 2)
);

-- QUE1
ALTER TABLE customers
ADD phone_number VARCHAR(20);

-- QUE2
ALTER TABLE employees
MODIFY age int;

-- QUE3
ALTER TABLE contacts
RENAME COLUMN address TO home_address;

-- QUE4
ALTER TABLE employees
ADD CONSTRAINT fk_department 
FOREIGN KEY (department_id )
REFERENCES departments (department_id) ;

-- 	QUE5
ALTER TABLE students
DROP PRIMARY KEY;

-- QUE6
ALTER TABLE users
ADD CONSTRAINT uc_email UNIQUE (email);

-- QUE7
ALTER TABLE inventory
MODIFY quantity INT DEFAULT 0;

-- QUE8
ALTER TABLE customers
MODIFY COLUMN last_name VARCHAR(50) FIRST;

-- QUE9
ALTER TABLE products
MODIFY product_id INT AUTO_INCREMENT, AUTO_INCREMENT = 1001;

-- QUE10
ALTER TABLE employees
ADD CONSTRAINT chk_salary CHECK (salary >= 2000);

-- QUE12
-- GETTING AN ERROR ncorrect date value: 
-- '0000-00-00' for column 'START_DATE' at row 11
ALTER TABLE job_history
ADD CONSTRAINT job_id
FOREIGN KEY (job_id) 
REFERENCES jobs(job_id);

-- QUE13
ALTER TABLE job_history
DROP FOREIGN KEY job_id;

-- 	QUE14
CREATE INDEX job_id 
ON job_history (job_id);

-- QUE15
ALTER TABLE job_history
DROP index job_id;

-- QUE16
ALTER TABLE customers
MODIFY COLUMN email VARCHAR(150);

-- QUE17
ALTER TABLE employees
ADD COLUMN status VARCHAR(10) DEFAULT 'active';

-- QUE18
ALTER TABLE customers
DROP COLUMN phone_number ;

-- QUE19
ALTER TABLE departments
MODIFY department_name VARCHAR(50) NOT NULL;

-- QUE20
ALTER TABLE users
DROP INDEX ec_email;

-- QUE21
RENAME TABLE inventory TO product_inventory;

-- QUE22
ALTER TABLE job_history
ADD CONSTRAINT employee_id
FOREIGN KEY (employee_id)
REFERENCES employees(employee_id)
ON DELETE CASCADE;

-- QUE23
ALTER TABLE employees
MODIFY COLUMN status VARCHAR(10) DEFAULT 'inactive';

-- QUE24
ALTER TABLE employees
DROP FOREIGN KEY fk_department;

-- QUE25
ALTER TABLE employees
MODIFY salary DECIMAL(10, 2) AFTER last_name;

-- QUE26
ALTER TABLE employees
ALTER column status DROP DEFAULT;

-- QUE27
ALTER TABLE users
RENAME COLUMN email TO unique_email_constraint;

-- QUE28
SET FOREIGN_KEY_CHECKS = 0;
SET FOREIGN_KEY_CHECKS = 1;

-- QUE29
ALTER TABLE employees
MODIFY COLUMN age SMALLINT NULL;