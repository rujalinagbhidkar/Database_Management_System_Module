use aggregate_functions;
use hr;

-- Write a SQL query to find the number of employees hired in each year.
SELECT * FROM employees;
SELECT year(hire_date) as HD, count(*) as emp
from employees
group by year(hire_date);

-- Write a SQL query to find the number of employees in each department.
SELECT department_id , count(employee_id) as total_emp
from employees
group by department_id
having count(employee_id)
order by total_emp;

-- Write a SQL query to find the department with the highest total salary.
select department_id as dept_id, 
	   SUM(salary) as total_salary
from employees
group by department_id
order by total_salary desc;

-- Write a query to list the number of jobs available in the employees table.
SELECT DISTINCT job_id AS total_jobs_available
FROM employees;

-- Write a query to get the total salaries payable to employees.
SELECT SUM(salary) AS total_salaries_payable
FROM employees;

-- Write a query to get the minimum salary from the employees table.
SELECT MIN(salary) AS minimun_sal
from employees;

-- Write a query to get the maximum salary of an employee working as a Programmer. 
select MAX(salary) 
from employees
where job_id = 'IT_PROG';

-- Write a query to get the average salary and number of employees working the department 90. 
select department_id, AVG(salary) as avg_salary
from employees
where department_id = 90;

-- Write a query to get the highest, lowest, sum, and average salary of all employees. 
select count(*) AS employees_salary,
max(salary) as max_salary,
min(salary) as min_salary,
sum(salary) as total_salary,
avg(salary) as avg_salary
from employees;

-- Write a query to get the number of employees with the same job
select job_id, count(employee_id) as total_emp
from employees
group by job_id
having count(employee_id)
order by total_emp desc;

-- Write a query to get the difference between the highest and lowest salaries. 
select max(salary) - min(salary) as salary_diff
from employees;

-- Write a query to find the manager ID and the salary of the lowest-paid employee for that manager. 
select manager_id, count(employee_id) as total_emp, min(salary) as min_salary
from employees
group by manager_id
having count(employee_id) and min(salary)
order by min_salary;

-- Write a query to get the department ID and the total salary payable in each department.
select department_id, sum(salary) as total_sal
from employees
group by department_id
order by total_sal;

-- Write a query to get the average salary for each job ID excluding programmer. 
select job_id , avg(salary) as avg_sal
from employees
where job_id != 'IT_PROG'
group by job_id
order by avg_sal desc;

-- Write a query to get the total salary, maximum, minimum, average salary of 
-- employees (job ID wise), for department ID 90 only. 
select job_id, department_ID, 
	Sum(salary) as TS,
    min(salary) AS MIN,
    max(salary) AS MAX,
    avg(salary) AS AVGS
from employees
where department_id = 90
group by job_id;

-- Write a query to get the job ID and maximum salary of the employees where maximum 
-- salary is greater than or equal to $4000.
SELECT job_id,
       MAX(salary) AS max_salary
FROM employees
GROUP BY job_id
HAVING MAX(salary) >= 4000;

-- Write a query to get the average salary for all departments employing more than 10 employees. 
SELECT department_id,count(employee_id) as emp,
       AVG(salary) AS average_salary
FROM employees
GROUP BY department_id 
HAVING COUNT(*) > 10;
