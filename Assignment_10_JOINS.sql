-- 1. Write a query to find the addresses (location_id, street_address, 
-- city, state_province, country_name) of all the departments.

select l.location_id, l.street_address, l.city, l.state_province, c.country_name, c.country_id
from departments d
join locations l
on d.location_id =l.location_id
join countries c
on l.country_id = c.country_id;

-- 2. Write a query to find the name (first_name, last name), 
-- department ID and name of all the employees
select CONCAT(e.first_name, ' ', e.last_name) AS full_name, d.department_id, d.department_name
from employees e
join departments d
on e.department_id = d.department_id;

-- 3. Write a query to find the name (first_name, last_name), 
-- job, department ID and name of the employees who works in London.
select CONCAT(e.first_name, ' ', e.last_name) AS full_name, 
		e.job_id, 
        d.department_id, 
        d.department_name,
        l.city
from employees e
join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
where l.city = 'london';

-- 4. Write a query to find the employee id, name (last_name) along with 
-- their manager_id and name (last_name).
SELECT e.employee_id,
       e.last_name AS employee_name,
       e.manager_id,
       m.last_name AS manager_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;

-- 5. Write a query to find the name (first_name, last_name) and 
-- hire date of the employees who was hired after 'Jones'.
select first_name, last_name , hire_date
from employees 
where hire_date > (select hire_date from employees where last_name = 'jones');

-- 6. Write a query to get the department name and number of employees in the department.
select d.department_name, count(e.employee_id) as total_emp
from employees e
join departments d
on e.department_id = d.department_id
group by d.department_name
order by count(e.employee_id) desc;

-- 7. Write a query to find the employee ID, job title, 
-- number of days between ending date and starting date for all jobs in department 90.
select e.employee_id , j.job_title, datediff(jh.end_date, jh.start_date) as dif_days ,e.department_id
from employees e
join job_history jh
on e.department_id = jh.department_id
join jobs j
on jh.job_id = j.job_id
where e.department_id = 90;

-- 8. Write a query to display the department ID and name and first name of manager.
select d.department_id , d.department_name, e.first_name
from departments d
join employees e
on d.manager_id = e.employee_id;

-- 9. Write a query to display the department name, manager name, and city.
select d.department_name, e.first_name, l.city
from employees e
join departments d
on d.manager_id = e.employee_id
join locations l
on d.location_id = l.location_id;

-- 10. Write a query to display the job title and average salary of employees.
select j.job_title, avg(salary)
from employees e
join jobs j
on e.job_id = j.job_id
group by j.job_title;

-- 11. Write a query to display job title, employee name, and the difference between 
-- salary of the employee and minimum salary for the job.
SELECT j.job_title,
       CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
       e.salary AS employee_salary,
       j.min_salary AS job_min_salary,
       e.salary - j.min_salary AS salary_difference
FROM employees e
JOIN jobs j ON e.job_id = j.job_id;

 
-- 12. Write a query to display the job history that were done by any employee 
-- who is currently drawing more than 10000 of salary
SELECT jh.employee_id,
       jh.start_date,
       jh.end_date,
       jh.job_id,
       jh.department_id
FROM job_history jh
JOIN employees e ON jh.employee_id = e.employee_id
WHERE e.salary > 10000;

-- 13. Write a query to display department name, name (first_name, last_name), hire date, salary
--  of the manager for all managers whose experience is more than 15 years.
SELECT d.department_name,
       CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
       e.hire_date,
       e.salary,
       YEAR(CURDATE()) - YEAR(e.hire_date) AS experience_years
FROM departments d
JOIN employees e ON d.manager_id = e.employee_id
WHERE YEAR(CURDATE()) - YEAR(e.hire_date) > 15;

select * from jobs;
select * from departments;
select * from countries;
select * from locations;
select * from regions;
select * from employees;
select * from jobs;
select * from job_history;
