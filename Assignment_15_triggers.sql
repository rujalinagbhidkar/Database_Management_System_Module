-- How can MySQL triggers be used to automatically update employee records when a department is changed?
delimiter $$
create trigger update_employee_on_department_change
after update on departments
for each row
begin
    update employees
    set department_id = new.department_id
    where department_id = old.department_id;
end $$
delimiter ;

-- What MySQL trigger can be used to prevent an employee from being deleted if they are currently assigned to a department?
delimiter $$
create trigger prevent_employee_delete
before delete on employees
for each row
begin
    if old.department_id is not null then
        signal sqlstate '45000'
        set message_text = 'cannot delete employee assigned to a department';
    end if;
end;
delimiter ;

-- How can a MySQL trigger be used to send an email notification to HR when an employee is hired or terminated?
-- What MySQL trigger can be used to automatically assign a new employee to a department based on their job title?

delimiter $$
create trigger assign_department_by_title
before insert on employees
for each row
begin
    if new.job_title = 'sales executive' then
        set new.department_id = 1;
    elseif new.job_title = 'hr manager' then
        set new.department_id = 2;
    elseif new.job_title = 'engineer' then
        set new.department_id = 3;
    end if;
end;
delimiter ;

-- How can a MySQL trigger be used to calculate and update the total salary budget for a department whenever a new employee is hired or their salary is changed?
create table department_budget (
    department_id int primary key,
    total_salary decimal(12,2)
);

delimiter $$
create trigger update_budget_on_insert
after insert on employees
for each row
begin
    update department_budget
    set total_salary = total_salary + new.salary
    where department_id = new.department_id;
end;
delimiter ;

delimiter $$
create trigger update_budget_on_salary_change
after update on employees
for each row
begin
    update department_budget
    set total_salary = total_salary - old.salary + new.salary
    where department_id = new.department_id;
end;
delimiter ;

-- What MySQL trigger can be used to enforce a maximum number of employees that can be assigned to a department?
delimiter $$
create trigger enforce_max_employees
before insert on employees
for each row
begin
    declare emp_count int;
    select count(*) into emp_count from employees where department_id = new.department_id;
    if emp_count >= 10 then
        signal sqlstate '45000'
        set message_text = 'maximum employee limit reached for this department';
    end if;
end;
delimiter ;

-- How can a MySQL trigger be used to update the department manager whenever an employee under their supervision is promoted or leaves the company?
-- What MySQL trigger can be used to automatically archive the records of an employee who has been terminated or has left the company?
create table employee_archive like employees;

delimiter $$
create trigger archive_on_termination
before delete on employees
for each row
begin
    insert into employee_archive
    select * from employees where employee_id = old.employee_id;
end;
delimiter ;