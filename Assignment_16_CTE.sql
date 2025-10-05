/*
1) Hello, Employees (staging CTE)
Task: Build a CTE that returns EMPLOYEE_ID, full_name, JOB_ID, DEPARTMENT_ID, SALARY.
 Output: employee_id, full_name, job_id, department_id, salary.
 Hint: CONCAT(COALESCE(FIRST_NAME,''),' ',LAST_NAME).
*/
with employee_cte as (
    select employee_id,
           concat(coalesce(first_name, ''), ' ', last_name) as full_name,
           job_id,
           department_id,
           salary
    from employees
)
select * from employee_cte;


/*
2) Department Headcount (include 0)
Task: CTE with employees grouped by DEPARTMENT_ID. Left-join to departments to show all departments.
 Output: department_id, department_name, headcount.
 Hint: COALESCE(headcount,0).
 */
with headcount_cte as (
    select department_id, count(*) as headcount
    from employees
    group by department_id
)
select d.department_id,
       d.department_name,
       coalesce(h.headcount, 0) as headcount
from departments d
left join headcount_cte h on d.department_id = h.department_id;

/*
3) Avg Salary by Job
Task: CTE aggregates average salary per JOB_ID; join to jobs for titles.
 Output: job_id, job_title, emp_count, avg_salary.
 Hint: ROUND(AVG(SALARY),2).
 */
 with salary_cte as (
    select job_id,
           count(*) as emp_count,
           round(avg(salary), 2) as avg_salary
    from employees
    group by job_id
)
select s.job_id,
       j.job_title,
       s.emp_count,
       s.avg_salary
from salary_cte s
join jobs j on s.job_id = j.job_id;
 
 /*
 4) Employee → Manager (1 hop)
Task: Stage employees in a CTE; self-join to get direct manager name.
 Output: employee_id, employee_name, manager_id, manager_name.
 Hint: Left join; top boss may have MANAGER_ID = 0 or NULL.
*/
with employee_cte as (
    select employee_id,
           concat(coalesce(first_name, ''), ' ', last_name) as employee_name,
           manager_id
    from employees
)
select e.employee_id,
       e.employee_name,
       e.manager_id,
       concat(coalesce(m.first_name, ''), ' ', m.last_name) as manager_name
from employee_cte e
left join employees m on e.manager_id = m.employee_id;

/*
5) Employees Without a Department
Task: Use a CTE to list employees where DEPARTMENT_ID IS NULL OR DEPARTMENT_ID=0.
 Output: employee_id, full_name, job_id, department_id.
*/
with no_dept_cte as (
    select employee_id,
           concat(coalesce(first_name, ''), ' ', last_name) as full_name,
           job_id,
           department_id
    from employees
    where department_id is null or department_id = 0
)
select * from no_dept_cte;


/*
6) Departments Without Employees
Task: Distinct DEPARTMENT_ID from employees in a CTE; anti-join to departments.
 Output: department_id, department_name.
*/
with active_depts as (
    select distinct department_id
    from employees
    where department_id is not null and department_id <> 0
)
select d.department_id, d.department_name
from departments d
left join active_depts a on d.department_id = a.department_id
where a.department_id is null;


/*
7) Map Employees to Region (clean text)
Task: CTE joins employees → departments → locations → countries → regions and trims REGION_NAME.
 Output: employee_id, full_name, department_name, city, country_name, region_name.
 Hint: TRIM(REPLACE(REGION_NAME,'\r','')).
 */
 with region_map_cte as (
    select e.employee_id,
           concat(coalesce(e.first_name, ''), ' ', e.last_name) as full_name,
           d.department_name,
           l.city,
           c.country_name,
           trim(replace(r.region_name, '\r', '')) as region_name
    from employees e
    join departments d on e.department_id = d.department_id
    join locations l on d.location_id = l.location_id
    join countries c on l.country_id = c.country_id
    join regions r on c.region_id = r.region_id
)
select * from region_map_cte;
 
 
/*
8) Simple Pay-Band Check
Task: CTE joins employees to jobs; return rows where salary < min_salary OR salary > max_salary.
 Output: employee_id, full_name, job_title, salary, min_salary, max_salary.
*/
with pay_band_cte as (
    select e.employee_id,
           concat(coalesce(e.first_name, ''), ' ', e.last_name) as full_name,
           j.job_title,
           e.salary,
           j.min_salary,
           j.max_salary
    from employees e
    join jobs j on e.job_id = j.job_id
)
select *
from pay_band_cte
where salary < min_salary or salary > max_salary;


/*
9) Top Earners (overall)
Task: CTE selecting employee_id, full_name, salary, then order and limit to top 5.
 Output: employee_id, full_name, salary.
 Hint: Use the CTE just to keep the final SELECT clean.
 */
 with top_earners_cte as (
    select employee_id,
           concat(coalesce(first_name, ''), ' ', last_name) as full_name,
           salary
    from employees
)
select *
from top_earners_cte
order by salary desc
limit 5;
 

/*
10) Jobs Present in Each Department
Task: CTE groups employees by DEPARTMENT_ID, JOB_ID and counts. Join jobs for title.
 Output: department_name, job_title, employees_in_role.
  */
  with job_dept_cte as (
    select department_id, job_id, count(*) as employees_in_role
    from employees
    group by department_id, job_id
)
select d.department_name, j.job_title, c.employees_in_role
from job_dept_cte c
join departments d on c.department_id = d.department_id
join jobs j on c.job_id = j.job_id;
  
  
  
/*
11) Headcount by Region
Task: Reuse the “map to region” idea in a CTE; then group by region.
 Output: region_name, headcount.
 Hint: Handle NULL region as “Unknown”.
 */
with region_map_cte as (
    select r.region_name
    from employees e
    join departments d on e.department_id = d.department_id
    join locations l on d.location_id = l.location_id
    join countries c on l.country_id = c.country_id
    left join regions r on c.region_id = r.region_id
)
select coalesce(trim(replace(region_name, '\r', '')), 'unknown') as region_name,
       count(*) as headcount
from region_map_cte
group by region_name;


/*
12) Commission Snapshot
Task: In a CTE, compute a flag has_commission = commission_pct > 0. Then count by flag.
 Output: has_commission, headcount.
 Optional: Break down by department as well.
 */
 with commission_cte as (
    select employee_id,
           department_id,
           case when commission_pct > 0 then 'yes' else 'no' end as has_commission
    from employees
)
select has_commission, count(*) as headcount
from commission_cte
group by has_commission;

-- optional breakdown by department
select department_id, has_commission, count(*) as headcount
from commission_cte
group by department_id, has_commission;
 

/*
13) Employees with Any Job History
Task: CTE with distinct EMPLOYEE_ID from job_history (exclude dummy row). Join to employees.
 Output: employee_id, full_name, history_row_count.
 Hint: COUNT(*) OVER (PARTITION BY EMPLOYEE_ID) or aggregate before join.
 */
 with history_cte as (
    select employee_id, count(*) as history_row_count
    from job_history
    where start_date <> '0000-00-00' and end_date <> '0000-00-00'
    group by employee_id
)
select e.employee_id,
       concat(coalesce(e.first_name, ''), ' ', e.last_name) as full_name,
       h.history_row_count
from history_cte h
join employees e on h.employee_id = e.employee_id;
 

/*
14) Latest History Row (gentle)
Task: Clean job_history in a CTE (exclude zero/invalid dates) and pick the latest row per employee using ROW_NUMBER.
 Output: employee_id, last_hist_job_id, last_hist_department_id, last_hist_end_date.
 Hint: Order by END_DATE DESC, START_DATE DESC.
 */
with clean_history_cte as (
    select employee_id, job_id, department_id, end_date,
           row_number() over (partition by employee_id order by end_date desc, start_date desc) as rn
    from job_history
    where start_date <> '0000-00-00' and end_date <> '0000-00-00'
)
select employee_id,
       job_id as last_hist_job_id,
       department_id as last_hist_department_id,
       end_date as last_hist_end_date
from clean_history_cte
where rn = 1;


/*
15) Locations per Country
Task: CTE groups locations by COUNTRY_ID; join to countries.
 Output: country_id, country_name, location_count.
 Hint: COALESCE(country_name,'Unknown').
 */
 with location_cte as (
    select country_id, count(*) as location_count
    from locations
    group by country_id
)
select l.country_id,
       coalesce(c.country_name, 'unknown') as country_name,
       l.location_count
from location_cte l
left join countries c on l.country_id = c.country_id;
 
