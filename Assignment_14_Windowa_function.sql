-- Ranking Functions:
-- Find the top 3 highest paid employees in each department using RANK().
select *
from (
    select employee_id, first_name, last_name, department_id, salary,
           rank() over (partition by department_id order by salary desc) as salary_rank
    from employees
) as ranked
where salary_rank <= 3;

-- Assign a unique row number to each employee within their department using ROW_NUMBER() based on salary descending.
select employee_id, first_name, last_name, department_id, salary,
       row_number() over (partition by department_id order by salary desc) as row_num
from employees;

-- List departments where at least two employees share the same salary rank using DENSE_RANK().
select distinct department_id
from (
    select department_id,
           dense_rank() over (partition by department_id order by salary desc) as rank_group,
           count(*) over (partition by department_id, salary) as salary_count
    from employees
) as ranked
where salary_count >= 2;

-- Divide employees into 4 equal salary groups using NTILE(4) and display the group number along with employee details.
select employee_id, first_name, last_name, department_id, salary,
       ntile(4) over (order by salary desc) as salary_group
from employees;

-- Find the top 3 highest paid employees in each department using RANK().
select *
from (
    select employee_id, first_name, last_name,department_id, salary,
           rank() over (partition by department_id order by salary desc) as salary_rank
    from employees
) as ranked
where salary_rank <= 3;

-- Assign a unique row number to each employee within their department using ROW_NUMBER() based on salary descending.
select employee_id, first_name, last_name, department_id, salary,
       row_number() over (partition by department_id order by salary desc) as row_num
from employees;

-- List departments where at least two employees share the same salary rank using DENSE_RANK().
select distinct department_id
from (
    select department_id,
           dense_rank() over (partition by department_id order by salary desc) as rank_group,
           count(*) over (partition by department_id, salary) as salary_count
    from employees
) as ranked
where salary_count >= 2;

-- Divide employees into 4 equal salary groups using NTILE(4) and display the group number along with employee details.
select employee_id, first_name, last_name, department_id, salary,
       ntile(4) over (order by salary desc) as salary_group
from employees;

-- Aggregate Window Functions
-- For each employee, show their salary and the average salary of their department using AVG() as a window function.
select employee_id, first_name, last_name, department_id, salary,
       avg(salary) over (partition by department_id) as dept_avg_salary
from employees;

-- Show the running total of salaries for each department ordered by hire date using SUM() window function.
select employee_id, first_name, last_name, department_id, hire_date, salary,
       sum(salary) over (partition by department_id order by hire_date) as running_total_salary
from employees;

-- Find the maximum salary in each department and compare it with each employee’s salary.
select employee_id, first_name, last_name, department_id, salary,
       max(salary) over (partition by department_id) as max_dept_salary,
       salary / max(salary) over (partition by department_id) as salary_ratio
from employees;

-- For each employee, show their salary and the average salary of their department using AVG() as a window function.
select employee_id as employee_id, first_name, last_name, department_id, salary,
       avg(salary) over (partition by department_id) as dept_avg_salary
from employees;

-- Show the running total of salaries for each department ordered by hire date using SUM() window function.
select employee_id, first_name, last_name,department_id, hire_date, salary,
       sum(salary) over (partition by department_id order by hire_date) as running_total_salary
from employees;

-- Find the maximum salary in each department and compare it with each employee’s salary.
 select employee_id, first_name, last_name, department_id, salary,
       max(salary) over (partition by department_id) as max_dept_salary,
       round(salary / max(salary) over (partition by department_id), 2) as salary_ratio
from employees;


