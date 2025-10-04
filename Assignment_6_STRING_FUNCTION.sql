USE DATA_DATABASE;
-- 1 Write a query to display the FIRST_NAME and LAST_NAME concatenated as Full Name for all employees.
select concat (first_name ," ", last_name) as full_Name from employees;

-- 2 Write a query to display the FIRST_NAME in lowercase and the LAST_NAME in uppercase for all employees.
select lower(first_name) , upper(last_name)  from employees;

-- 3 Write a query to display the COUNTRY_NAME of all countries in uppercase.
select upper(COUNTRY_NAME) from countries;

-- 4 Write a query to display the FIRST_NAME and the length of the first name for all employees.
select first_name , length(first_name) from employees;

-- 5 Write a query to display the EMAIL and the length of the email address for employees whose email length is greater than 10
select email , length(email) from employees where length(email) > 10;

-- 6 Write a query to extract the first three characters from the FIRST_NAME of all employees.
select first_name , substring(first_name,1,3) as substring from employees;

-- 7 Write a query to extract the last four characters of the PHONE_NUMBER for all employees.
select phone_number , substring(phone_number,(length(phone_number)-4), length(phone_number)) as subphone from employees;

-- 8 Write a query to find the position of the letter 'a' in the LAST_NAME of all employees.
select last_name, instr(last_name,'a') as positon from employees;

-- 9 Write a query to find the position of the substring 'IT' in the job title of all employees.
select job_id, instr (job_id,'IT') as position from employees;

-- 10 Write a query to find the position of the substring 'IT' in the job title of all employees.
select job_id , replace(job_id,'IT','X')as modify_name from employees;

-- 11 Write a query to replace the region name 'Europe' with 'EU' in the REGION_NAME column.
select region_name , replace(region_name,'europe','eu')as modify_name from region;

-- 12 Write a query to remove any leading and trailing spaces from the FIRST_NAME of all employees and display the cleaned-up names.
select first_name , trim(first_name) from employees;

-- 13 Write a query to remove any trailing spaces from the CITY names of all locations.
select first_name , rtrim(first_name) from employees;

-- 14 Write a query to extract the first five characters from the EMAIL of all employees using the LEFT function.
select email, left(email,5) as email from employees;

-- 15 Write a query to extract the last three characters from the COUNTRY_NAME of all countries using the RIGHT function.
select country_name , right(country_name,3) as country_name from countries;

-- 16 Write a query to extract the domain (everything after '@') from the EMAIL column of all employees.
SELECT EMAIL,
       SUBSTRING_INDEX(EMAIL, '@', -1) AS domain
FROM EMPLOYEES;

-- 17 Write a query to extract the domain (everything after '@') from the EMAIL column of all employees.
select phone_number, substring_index(phone_number, '.',1) as copy from employees;

-- 18 Write a query to compare the FIRST_NAME and LAST_NAME of employees and display 0 if they are the same and a non-zero value if they are different.
select first_name,last_name, if(first_name = last_name,'0','1') from employees;

-- 19 Write a query to compare the REGION_NAME of regions and display 0 if it is 'Asia' and 1 otherwise.
use hr;
select region_name, if(region_name = 'Asia','0','1') from regions;

-- 20 Write a query to display the FIRST_NAME, LAST_NAME, and JOB_TITLE concatenated as a single string, with each value separated by a hyphen (-), for all employees.
select * from employees;
select first_name,last_name,job_id, concat (first_name,'-',last_name,'-',job_id) as com from employees;

-- 21 Write a query to extract the username (portion before @) from the EMAIL column and display it along with the FIRST_NAME for all employees.
select first_name ,concat(substring_index(email,'@',1),' ', first_name)as com from employees;

-- 22 Write a query to replace all occurrences of 'e' with 'E' in the LAST_NAME of employees whose LAST_NAME contains 'e'.
select last_name, replace(last_name,'e','E') as replacee from employees where last_name like '%e';

-- 23 Write a query to find the position of the first occurrence of the letter 'o' in the FIRST_NAME of employees and display the name along with the position.
SELECT FIRST_NAME,
       INSTR(FIRST_NAME, 'o') AS position_of_o
FROM EMPLOYEES;

-- 24 Write a query to display the CITY name for all locations, removing any leading and trailing spaces, and also display the first three characters of the cleaned-up city name.
select city,left(trim(city),3) as clean from locations;

-- 25 Write a query to find employees whose LAST_NAME contains the letter 'n' and display their LAST_NAME along with the position of the first occurrence of 'n'.
select last_name , instr(last_name,'n') as pos from employees;

-- 26 Write a query to find the position of the letter 'a' in the FIRST_NAME for all employees. Display the employee's first name and the position of the letter 'a'.
select first_name , instr(first_name,'a') as pos from employees;

-- 27 Write a query to display the position of the first occurrence of 'e' in the JOB_TITLE for all jobs, and display only those where the letter 'e' occurs after the 5th character.
select job_id , instr(job_id,'e') as pos  from employees where instr(job_id,'e') > 5;

-- 28 Write a query to compare the FIRST_NAME and LAST_NAME of employees and display only those employees where the first name comes alphabetically before the last name.
select first_name,last_name from employees where first_name < last_name;

-- 29 Write a query to find all departments where the DEPARTMENT_NAME is either 'IT' or 'HR' using the FIND_IN_SET function.
use hr;
select department_name
from departments
where find_in_set(department_name, 'IT,HR');

-- 30 Write a query to display the FIRST_NAME and the length of the name for employees whose FIRST_NAME length is greater than 6.
select first_name , length(first_name) as length from employees where length(first_name) > 6;

-- 31 Write a query to find all countries where the COUNTRY_NAME contains either 'China', 'India', or 'Japan'
select country_name from countries where COUNTRY_NAME in ('China', 'India', 'Japan');

-- 32 Write a query to find all employees who have DEPARTMENT_ID present in the list (50, 60, 70)
select department_id from employees where department_id in (50,60,70);

-- 33 Write a query to extract the first two characters from the COUNTRY_NAME function and the last two characters displaying them along with the full COUNTRY_NAME.
select country_name , left(country_name,2), right(country_name,2) from countries;

-- 34 Write a query to display employees whose LAST_NAME contains the letter 'o' at a position greater than half the length of their last name.
SELECT LAST_NAME
FROM EMPLOYEES
WHERE INSTR(LAST_NAME, 'o') > LENGTH(LAST_NAME) / 2;

-- 35 Write a query to find employees whose FIRST_NAME contains the letter 'a' and the letter 'e' and display the positions of both.
select first_name , instr(first_name,'a') as posA , instr(first_name,'e') as posE  from employees;

-- 36  Write a query to extract the domain from the EMAIL column for employees and only display employees whose domain is 'example.com'.
select email, substring_index(email, '@' ,1) as email from employees where substring_index(email, '@' ,1) = 'example.com';

-- 37 Write a query to count the number of employees who belong to department IDs 50, 60, or 70
select department_id , count(department_id in (50,60,70)) as coun from employees GROUP BY department_id;

-- 38 Write a query to display all COUNTRY_NAMEs from the countries table where REGION_ID is either 1 or 3 
select country_name from countries where region_id in (1,3);

-- 39 Write a query to find employees who either work in departments 50, 60, or 70 or have a salary greater than 10,000.
select * from employees;
select first_name from employees where department_id in (50,60,70) or salary > 10000;

-- 40 Write a query to find employees whose DEPARTMENT_ID is either 50 or 60 and their MANAGER_ID is either 103 or 108.
select first_name from employees where department_id in (50,60) or manager_id in (103,108);