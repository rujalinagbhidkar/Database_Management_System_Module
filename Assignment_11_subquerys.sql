-- 1. Write a query to find the name (first_name, last_name) and the salary of the 
-- employees who have a higher salary than the employee whose last_name='Bull'. 
select concat(first_name ,' ', last_name) as full_name, salary 
from employees
where salary > (
	SELECT salary 
    from employees
    where last_name = 'bull');

-- 2. Write a query to find the name (first_name, last_name) of 
-- all employees who works in the IT department.
select concat(first_name ,' ', last_name) as full_name, job_id
from employees
where job_id IN (
	select job_id
    from employees
    where job_id = 'IT_PROG');

-- 3. Write a query to find the name (first_name, last_name) of the employees who 
-- have a manager and worked in a USA based department. 
select concat(e.first_name, ' ', e.last_name) as full_name
from employees e
where e.manager_id is not null
  and e.department_id in (
      select d.department_id
      from departments d
      join locations l on d.location_id = l.location_id
      join countries c on l.country_id = c.country_id
      where c.country_id = 'US'
  );


-- 4. Write a query to find the name (first_name, last_name) 
-- of the employees who are managers. 
SELECT CONCAT(first_name, ' ', last_name) AS full_name, manager_id
FROM employees
WHERE employee_id IN (
    SELECT manager_id
    FROM departments
);

-- 5. Write a query to find the name (first_name, last_name), and 
-- salary of the employees whose salary is greater than the average salary. 
SELECT CONCAT(first_name, ' ', last_name) AS full_name, salary
FROM employees
WHERE salary > (
    SELECT avg(salary)
    FROM employees
);

-- 6. Write a query to find the name (first_name, last_name), and salary of the employees 
-- whose salary is equal to the minimum salary for their job grade. 
SELECT CONCAT(first_name, ' ', last_name) AS full_name, salary
FROM employees
WHERE salary = (
    SELECT min(salary)
    FROM employees
);

-- 7. Write a query to find the name (first_name, last_name), and salary of the employees 
-- who earns more than the average salary and works in any of the IT departments. 
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
)
AND department_id IN (
    SELECT department_id
    FROM departments
    WHERE department_name LIKE '%IT%'
);

-- 8. Write a query to find the name (first_name, last_name), and salary of the 
-- employees who earns more than the earning of Mr. Bell.
select concat(first_name ,' ', last_name) as full_name, salary 
from employees
where salary > (
	SELECT salary 
    from employees
    where last_name = 'bell');


-- 9. Write a query to find the name (first_name, last_name), and salary of the
-- employees who earn the same salary as the minimum salary for all departments. 
select concat (first_name ,' ', last_name) as full_salary , salary
from employees
where salary = (
		select min(salary)
		from employees
);

-- 10. Write a query to find the name (first_name, last_name), and salary of the 
-- employees whose salary is greater than the average salary of all departments.
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (
    SELECT AVG(dept_avg)
    FROM (
        SELECT AVG(salary) AS dept_avg
        FROM employees
        GROUP BY department_id
    ) AS dept_avgs
);


-- 11. find employee name and salary of those earning more than all shipping clerks
-- assuming 'sh_clerk' is a job_title
select employee_name, salary
from company_data
where salary > all (
    select salary
    from company_data
    where job_title = 'sh_clerk'
)
order by salary asc;

-- 12. find names of employees who are not supervisors
-- assuming supervisors are not listed as subordinates in the same table
-- and no supervisor_id column exists, we exclude repeated employee_ids
select distinct employee_name
from company_data
where employee_id not in (
    select distinct employee_id
    from company_data
    where job_title like '%supervisor%'
);

-- 13. display employee id, name, and department name
select employee_id, employee_name, department_name
from company_data;

-- 14. display employee id, name, salary of employees earning above department average
select employee_id, employee_name, salary
from company_data e
where salary > (
    select avg(salary)
    from company_data
    where department_code = e.department_code
);

-- 15. fetch even numbered records from employees table
-- assuming even employee_id indicates even record
select *
from company_data
where mod(employee_id, 2) = 0;
-- 16. Find the 5th maximum salary in the employees table.
SELECT DISTINCT salary
FROM company_data
ORDER BY salary DESC
LIMIT 1 OFFSET 4;

-- 17. Find the 4th minimum salary in the employees table.
SELECT DISTINCT salary
FROM company_data
ORDER BY salary ASC
LIMIT 1 OFFSET 3;

-- 18. Write a query to select the last 10 records from a table. 
SELECT *
FROM company_data
ORDER BY order_id DESC
LIMIT 10;

-- 19. Write a query to list the department ID and name of all the departments where no employee is working. 
-- 20. Get 3 maximum distinct salaries from the employees table.
SELECT DISTINCT salary
FROM company_data
ORDER BY salary DESC
LIMIT 3;

-- 21. Get 3 minimum distinct salaries from the employees table.
SELECT DISTINCT salary
FROM company_data
ORDER BY salary ASC
LIMIT 3;

-- 22. Write a query to get nth max salaries of employees.
SELECT DISTINCT salary
FROM company_data
ORDER BY salary DESC
-- if n = 10 
LIMIT 1 OFFSET 9;


-- find employees where employee salary is greater than average department salary
select employee_id, salary
from employees 
where (select salary from employees where salary > AVG(salary));

-- write a query to find who are earning more than average salary department average salary
select first_name , department_id, department_name , salary, avg(department_salry)
where salary > (
selrct
;
