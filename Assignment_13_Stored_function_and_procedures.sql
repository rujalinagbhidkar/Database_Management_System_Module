-- Write a stored procedure to retrieve all employees from the Employees table for a given department ID.
delimiter $$
create procedure get_employees_by_dept(in dept int)
begin
    select * from employees where dept_id = dept;
end $$
delimiter ;

-- Create a function that calculates the total salary expenditure for a given department ID.
delimiter $$
create function total_salary_by_dept(dept int)
returns decimal(10,2)
deterministic
begin
    declare total decimal(10,2);
    select sum(salary) into total from employees where dept_id = dept;
    return total;
end $$
delimiter ;

-- Develop a stored procedure that accepts an employee ID as an input parameter and increases the salary of that employee by a specified percentage.
delimiter $$
create procedure increase_salary(in emp int, in percent decimal(5,2))
begin
    update employees
    set salary = salary + (salary * percent / 100)
    where emp_id = emp;
end $$
delimiter ;

-- Write a function to determine the average salary for employees in a specific job title category.
delimiter $$
create function avg_salary_by_title(title varchar(50))
returns decimal(10,2)
deterministic
begin
    declare avg_sal decimal(10,2);
    select avg(salary) into avg_sal from employees where job_title = title;
    return avg_sal;
end $$
delimiter ;

-- Create a stored procedure that takes an employee's first name and last name as input parameters and returns the full name in uppercase letters.
delimiter $$
create procedure get_upper_name(in fname varchar(50), in lname varchar(50))
begin
    select upper(concat(fname, ' ', lname)) as full_name;
end $$
delimiter ;


-- Write a stored procedure to insert a new employee into the Employees table with the provided first name, last name, and department ID.
delimiter $$
create procedure insert_employee(
    in fname varchar(50),
    in lname varchar(50),
    in dept int
)
begin
    insert into employees (emp_id, first_name, last_name, dept_id)
    values (
        (select ifnull(max(emp_id), 100) + 1 from employees),
        fname, lname, dept
    );
end $$
delimiter ;


-- Create a function to calculate the total number of employees in a specific department.
delimiter $$
create function total_employees_by_dept(dept int)
returns int
deterministic
begin
    declare total int;
    select count(*) into total from employees where dept_id = dept;
    return total;
end $$
delimiter ;

-- Develop a stored procedure that accepts an employee ID as input and deletes that employee's record from the Employees table.
delimiter $$
create procedure delete_employee_by_id(in emp int)
begin
    delete from employees where emp_id = emp;
end $$
delimiter ;

-- Write a function to determine the highest salary in the Employees table.
delimiter $$
create function highest_salary()
returns decimal(10,2)
deterministic
begin
    declare max_sal decimal(10,2);
    select max(salary) into max_sal from employees;
    return max_sal;
end $$
delimiter ;

-- Create a stored procedure that takes a department ID as an input parameter and returns the list of employees sorted by their salary in descending order within that department.
delimiter $$
create procedure employees_by_salary_desc(in dept int)
begin
    select * from employees
    where dept_id = dept
    order by salary desc;
end $$
delimiter ;

-- Write a stored procedure to update the job title of an employee based on their employee ID.
delimiter $$
create procedure update_job_title(
    in emp int,
    in new_title varchar(50)
)
begin
    update employees
    set job_title = new_title
    where emp_id = emp;
end $$
delimiter ;

-- Create a function that returns the number of employees hired in a specific year.
delimiter $$
create function employees_hired_in_year(hire_year int)
returns int
deterministic
begin
    declare count_year int;
    select count(*) into count_year
    from employees
    where year(hire_date) = hire_year;
    return count_year;
end $$
delimiter ;

-- Develop a stored procedure that accepts an employee ID as input and retrieves the employee's details, including their name, department, and salary.
delimiter $$
create procedure get_employee_details(in emp int)
begin
    select e.first_name, e.last_name, d.dept_name, e.salary
    from employees e
    join departments d on e.dept_id = d.dept_id
    where e.emp_id = emp;
end $$
delimiter ;

-- Write a function to calculate the average tenure (in years) of employees in the company.
delimiter $$
create function average_tenure()
returns decimal(5,2)
deterministic
begin
    declare avg_years decimal(5,2);
    select avg(timestampdiff(year, hire_date, curdate())) into avg_years
    from employees;
    return avg_years;
end $$
delimiter ;

-- Create a stored procedure that takes a department ID as an input parameter and returns the department name along with the count of employees in that department.
delimiter $$
create procedure get_dept_summary(in dept int)
begin
    select d.dept_name, count(e.emp_id) as employee_count
    from departments d
    left join employees e on d.dept_id = e.dept_id
    where d.dept_id = dept
    group by d.dept_name;
end $$
delimiter ;

-- Write a stored procedure to retrieve the top N highest-paid employees in the company, where N is an input parameter.
delimiter $$
create procedure top_n_paid_employees(in n int)
begin
    select * from employees
    order by salary desc
    limit n;
end $$
delimiter ;

-- Create a function that calculates the total bonus amount for all employees based on their performance ratings.
delimiter $$
create function total_bonus()
returns decimal(10,2)
deterministic
begin
    declare total decimal(10,2);
    select sum(bonus) into total from employees;
    return total;
end $$
delimiter ;

-- Develop a stored procedure that accepts a salary threshold as an input parameter and retrieves all employees with salaries above that threshold.
delimiter $$
create procedure employees_above_salary(in threshold decimal(10,2))
begin
    select * from employees
    where salary > threshold;
end $$
delimiter ;

-- Write a function to determine the average age of employees in the company based on their birthdates.
delimiter $$
create function average_age()
returns decimal(5,2)
deterministic
begin
    declare avg_age decimal(5,2);
    select avg(timestampdiff(year, birth_date, curdate())) into avg_age
    from employees;
    return avg_age;
end $$
delimiter ;

-- Create a stored procedure that takes an employee's last name as an input parameter and returns all employees with a similar last name.
delimiter $$
create procedure find_employees_by_lastname(in lname varchar(50))
begin
    select * from employees
    where last_name like concat('%', lname, '%');
end $$
delimiter ;

-- Write a stored procedure to update the email address of an employee based on their employee ID.
delimiter $$
create procedure update_email_by_id(
    in emp int,
    in new_email varchar(100)
)
begin
    update employees
    set email = new_email
    where emp_id = emp;
end $$
delimiter ;

-- Create a function that calculates the total experience (in years) of all employees combined in the company.
delimiter $$
create function total_experience()
returns int
deterministic
begin
    declare total_years int;
    select sum(timestampdiff(year, hire_date, curdate())) into total_years
    from employees;
    return total_years;
end $$
delimiter ;

-- Develop a stored procedure that accepts a department ID as input and returns the department name along with 
-- the average salary of employees in that department.Write a function to determine the number of employees who have 
-- been with the company for more than a specified number of years.
delimiter $$
create procedure dept_avg_salary(in dept int)
begin
    select d.dept_name, avg(e.salary) as average_salary
    from departments d
    join employees e on d.dept_id = e.dept_id
    where d.dept_id = dept
    group by d.dept_name;
end $$
delimiter ;


-- Create a stored procedure that takes a job title as an input parameter and returns the count of employees holding that job title.
delimiter $$
create function employees_above_tenure(years int)
returns int
deterministic
begin
    declare count_emp int;
    select count(*) into count_emp
    from employees
    where timestampdiff(year, hire_date, curdate()) > years;
    return count_emp;
end $$
delimiter ;

-- Write a stored procedure to retrieve the details of employees who have a salary within a specified range.
delimiter $$
create procedure count_by_job_title(in title varchar(50))
begin
    select count(*) as total_employees
    from employees
    where job_title = title;
end $$
delimiter ;

-- Create a function that calculates the total number of working hours for an employee in a given month.
delimiter $$
create procedure employees_in_salary_range(in min_sal decimal(10,2), in max_sal decimal(10,2))
begin
    select * from employees
    where salary between min_sal and max_sal;
end $$
delimiter ;

-- Develop a stored procedure that accepts an employee ID as input and retrieves the employee's department name and manager's name.
-- assumes a table 'attendance' with columns: emp_id, work_date, hours_worked
delimiter $$
create function monthly_hours(emp int, month_val int, year_val int)
returns int
deterministic
begin
    declare total_hours int;
    select sum(hours_worked) into total_hours
    from attendance
    where emp_id = emp
    and month(work_date) = month_val
    and year(work_date) = year_val;
    return total_hours;
end $$
delimiter ;

-- Write a function to determine the total number of employees hired in each year, grouped by the year of hire.
delimiter $$
create procedure get_dept_and_manager(in emp int)
begin
    select d.dept_name, d.manager_name
    from employees e
    join departments d on e.dept_id = d.dept_id
    where e.emp_id = emp;
end $$
delimiter ;

-- Create a stored procedure that takes a city name as an input parameter and returns the list of employees residing in that city.
delimiter $$
create procedure hires_per_year()
begin
    select year(hire_date) as year_hired, count(*) as total
    from employees
    group by year(hire_date);
end $$
delimiter ;

-- Write a stored procedure that calculates the average salary increase percentage for employees who have been with the company for more than five years.
delimiter $$
create procedure employees_by_city(in city_name varchar(50))
begin
    select * from employees
    where city = city_name;
end $$
delimiter ;

-- Create a function that calculates the total sales revenue generated by each employee in the Sales department, considering both individual and team contributions.
delimiter $$
create procedure avg_salary_increase()
begin
    select avg((new_salary - old_salary) / old_salary * 100) as avg_increase_percent
    from salary_history
    where emp_id in (
        select emp_id from employees
        where timestampdiff(year, hire_date, curdate()) > 5
    );
end $$
delimiter ;

-- Develop a stored procedure that accepts a date range as input and retrieves all employee attendance records within that period, including late arrivals and early departures.
delimiter $$
create function total_sales_revenue(emp int)
returns decimal(10,2)
deterministic
begin
    declare total decimal(10,2);
    select sum(individual_sales + team_sales) into total
    from sales
    where emp_id = emp;
    return total;
end $$
delimiter ;

-- Write a function that determines the average number of projects handled by employees in each department and identifies departments with exceptionally high or low project volumes.
delimiter $$
create procedure attendance_by_date_range(in start_date date, in end_date date)
begin
    select * from attendance
    where work_date between start_date and end_date
    and (hour(arrival_time) > 9 or hour(departure_time) < 17);
end $$
delimiter ;
