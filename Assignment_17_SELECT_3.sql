-- Basic Select Statement
create database hr1select;
use hr1select;

show tables;

-- 1. Write a query to display the names (first_name, last_name) using alias name “First Name", "Last Name"
select concat(first_name,' ', last_name) as full_name from employees;

-- 2. Write a query to get a unique department ID from the employee table.
select DISTINCT department_id from employees;

-- 3. Write a query to get all employee details from the employee table order by first name, descending.
select * from employees order by first_name desc;

-- 4. Write a query to get the names (first_name, last_name), salary, PF of all the employees (PF is calculated as 15% of salary).
select concat(first_name,' ', last_name) as full_name,salary,salary*0.15 as PF from employees;

-- 5. Write a query to get the employee ID, names (first_name, last_name), salary in ascending order of salary
select employee_id,concat(first_name,' ', last_name) as full_name,salary from employees order by salary ;

-- 6. Write a query to get the total salaries payable to employees
select sum(salary) as total_salary from employees;

-- 7. Write a query to get the maximum and minimum salary from the employees table.
select max(salary),min(salary) from employees;

-- 8. Write a query to get the average salary and number of employees in the employees table
select count(employee_id) as no_of_emp, avg(salary) from employees;

-- 9. Write a query to get the number of employees working with the company.
select count(employee_id) as working_emp from employees;

-- 10. Write a query to get the number of jobs available in the employees table. 
select count(job_id) as ava_job from employees;

-- 11. Write a query to get all first names from the employees table in upper case. 
select upper(first_name) from employees;

-- 12. Write a query to get the first 3 characters of first name from the employees table. 
select substring(first_name,1,3) as first_three_char from employees;

-- 13. Write a query to calculate 171*214+625. 
select 171 * 214 + 625 as result;

-- 14. Write a query to get the names (for example Ellen Abel, Sundar Ande etc.) of all the employees from the employees table. 
select employee_id,concat(last_name,' ', first_name) as full_name from employees;

-- 15. Write a query to get the first name from the employees table after removing white spaces from both sides.
select trim(first_name) from employees;

-- 16. Write a query to get the length of the employee names (first_name, last_name) from the employees table.
select concat(last_name,' ', first_name) as full_name, length(concat(last_name,' ', first_name)) from employees;

-- 17. Write a query to check if the first_name field of the employees table contains numbers. 
select concat(last_name,' ', first_name) as full_name from employees where first_name REGEXP '[0-9]';

-- 18. Write a query to select the first 10 records from a table.
select * from employees limit 10;

-- 19. Write a query to get the monthly salary (round 2 decimal places) of each and every employee Note : Assume the salary field provides the 'annual salary' information.
select first_name, last_name, round(salary / 12, 2) as monthly_salary from employees;

-- -------------------------------------------------------------------------------------------------------------------------
-- UPDATE

-- 1. Write a SQL statement to change the email column of the employees table with 'not available' for all employees.
UPDATE employees SET email = 'not available';
select * from employees;

-- 2. Write a SQL statement to change the email and commission_pct column of employees table with 'not available' and 0.10 for all employees.
UPDATE employees SET email = 'not available', commission_pct = 0.10;
select*from employees;

-- 3. Write a SQL statement to change the email and commission_pct column of employees table with 'not available' and 0.10 for those employees whose department_id is 110.
update employees set email = 'not available', commission_pct = 0.10 where department_id = 110;
select*from employees;

-- 4. Write a SQL statement to change the email column of employees table with 'not available' for those employees whose department_id is 80 and gets a commission_pct is less than .20
update employees set email = 'not available' where department_id = 80 and commission_pct < 0.20;

-- 5. Write a SQL statement to change the email column of the employees table with 'not available' for those employees who belong to the 'Accounting' department.
UPDATE employees SET email = 'not available' WHERE department_id = (SELECT department_id FROM departments WHERE department_name = 'Accounting');
select*from departments;

-- 6. Write a SQL statement to change the salary of an employee to 8000 whose ID is 105, if the existing salary is less than 5000.
update employees set salary = 8000 where employee_id = 105;

-- 7. Write a SQL statement to change the job ID of the employee whose ID is 118, to SH_CLERK if the employee belongs to the department, whose ID is 30 and the existing job ID does not start with SH.
update employees set job_id ='SH_check' where employee_id=118 and department_id = 30 and job_id not like 'SH%';
desc employees;

-- 8. Write a SQL statement to increase the salary of employees under the department 40, 90 and 110 according to the company rules that salary will be increased by 25% for department 40, 15% for department 90 and 10% for department 110 and the rest of the departments will remain the same.
update Employees
set Salary = case 
    when Department_ID = 40 then Salary * 1.25
    when Department_ID = 90 then Salary * 1.15
    when Department_ID = 110 then Salary * 1.10
    else Salary
end
where Department_ID in(40, 90, 110);

-- 9. Write a SQL statement to increase the minimum and maximum salary of PU_CLERK by 2000 as well as the salary for those employees by 20% and commission percent by .10.
update Jobs
set 
  Min_Salary = case 
    when Job_Title = 'PU_CLERK' then Min_Salary + 2000
    else Min_Salary
  end,
  Max_Salary = case 
    when Job_Title = 'PU_CLERK' then Max_Salary + 2000
    else Max_Salary
  end
where Job_Title = 'PU_CLERK';

update Employees
set 
    Salary = case 
        when Job_Title = 'PU_CLERK' then Salary * 1.20
        else Salary
    end,
    Commission_Pct = CASE 
        when Job_Title = 'PU_CLERK' then Commission_Pct + 0.10
        else Commission_Pct
    end
where Job_Title = 'PU_CLERK';


-- ALTER TABLE

-- 1. Write a SQL statement to rename the table countries to country_new.
alter table countries rename country_new;
show tables;

-- 2. Write a SQL statement to add a column region_id to the table locations.
alter table locations add column region_id int;
desc locations;

-- 3. Write a SQL statement to add a column ID as the first column of the table locations.
alter table locations add column Id int first;
desc locations;

-- 4. Write a SQL statement to add a column region_id after state_province to the table locations.
alter table locations modify column region_id int after state_province;
desc locations;

-- 5. Write a SQL statement to change the data type of the column country_id to integer in the table locations.
alter table locations modify column COUNTRY_ID int;
desc locations;

-- 6. Write a SQL statement to drop the column city from the table locations.
alter table locations drop column city;
desc locations;

-- 7. Write a SQL statement to change the name of the column state_province to state, keeping the data type and size same.
alter table locations rename column state_province to state;
desc locations;

-- 8. Write a SQL statement to add a primary key for the columns location_id in the locations table.
alter table locations drop primary key;
alter table locations add constraint primary key(LOCATION_ID);
desc locations;

-- Here is the sample table employees.


-- 9. Write a SQL statement to add a primary key for a combination of columns location_id and country_id.
alter table locations drop primary key;
alter table locations add constraint primary key(LOCATION_ID,country_id);
desc locations;

-- 10. Write a SQL statement to drop the existing primary from the table locations on a combination of columns location_id and country_id.
alter table locations drop primary key;
desc locations;

-- 11. Write a SQL statement to add a foreign key on the job_id column of the job_history table referencing the primary key job_id of jobs table.
alter table job_history add constraint
fk_job foreign key(job_id) references jobs (job_id);
desc job_history;

-- 12. Write a SQL statement to add a foreign key constraint named fk_job_id on the job_id column of the job_history table referencing the primary key job_id of jobs table.
alter table job_history add constraint fk_job_id foreign key(job_id)
references jobs(job_id);
desc job_history;

-- 13. Write a SQL statement to drop the existing foreign key fk_job_id from the job_history table on job_id column which is referencing the job_id of jobs table.
alter table job_history drop foreign key fk_job_id;
desc job_history;
alter table job_history drop foreign key fk_job;

-- 14. Write a SQL statement to add an index named indx_job_id on job_id column in the table job_history.
alter table job_history add index index_job_id (job_id);
show indexes from job_history;

-- 15. Write a SQL statement to drop the index indx_job_id from job_history table.
alter table job_history drop index index_job_id;
show indexes from job_history;
