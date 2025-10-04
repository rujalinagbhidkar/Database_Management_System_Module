-- 1. write a SQL query to find the details of those salespeople who come from the 
-- 'Paris' City or 'Rome' City. Return salesman_id, name, city, commission.
select * from salespeople
where city = 'Paris' or city = 'Rome';

-- 2.write a SQL query to find the details of the salespeople who come from 
-- either 'Paris' or 'Rome'. Return salesman_id, name, city, commission.
SELECT salesman_id, name, city, commission
FROM salespeople
WHERE city IN ('Paris', 'Rome');

-- 3. write a SQL query to find the details of those salespeople who live in cities other than 
-- Paris and Rome. Return salesman_id, name, city, commission.  
SELECT salesman_id, name, city, commission
FROM salespeople
WHERE city  NOT IN ('Paris', 'Rome');

-- 4. write a SQL query to retrieve the details of all customers whose 
-- ID belongs to any of the values 3007, 3008 or 3009. 
-- Return customer_id, cust_name, city, grade, and salesman_id.  
select * from customer
where customer_id in (3007,3008,3009);

-- 5. write a SQL query to find salespeople who receive commissions 
-- between 0.12 and 0.14 (begin and end values are included). 
-- Return salesman_id, name, city, and commission.  
select * from salespeople
where commission between 0.12 and 0.14;

-- 6. write a SQL query to select orders between 500 and 4000 
-- (begin and end values are included). Exclude orders amount 
-- 948.50 and 1983.43. Return ord_no, purch_amt, ord_date, customer_id, and salesman_id. 
select * from orders_table 
where purch_amt between 500 and 4000  
  and purch_amt not in (948.50 , 1983.43);

-- 7. write a SQL query to retrieve the details of the salespeople whose names begin with 
-- any letter between 'A' and 'L' (not inclusive). Return salesman_id, name, city, commission. 
SELECT salesman_id, name, city, commission
FROM salespeople
WHERE LEFT(name, 1) BETWEEN 'B' AND 'K';

-- 8.write a SQL query to find the details of all salespeople except those whose 
-- names begin with any letter between 'A' and 'L' (not inclusive). 
-- Return salesman_id, name, city, commission.  
SELECT salesman_id, name, city, commission
FROM salespeople
WHERE LEFT(name, 1) NOT BETWEEN 'B' AND 'K';

-- 9.write a SQL query to retrieve the details of the customers whose names 
-- begins with the letter 'B'. Return customer_id, cust_name, city, grade, salesman_id.. 
select * from customer
where cust_name like 'B%';

-- 10. write a SQL query to find the details of the customers whose names end
-- with the letter 'n'. Return customer_id, cust_name, city, grade, salesman_id.
select * from customer
where cust_name like '%n';

-- 11. write a SQL query to find the details of those salespeople whose names 
-- begin with ‘N’ and the fourth character is 'l'. Rests may be any character. 
-- Return salesman_id, name, city, commission. 
select * from customer
where cust_name like 'n__l%';

-- 12.write a SQL query to find those rows where col1 contains the escape 
-- character underscore ( _ ). Return col1.
SELECT col1
FROM patterns
WHERE col1 LIKE '%\_%';

-- 13. write a SQL query to identify those rows where col1 does not contain the escape 
-- character underscore ( _ ). Return col1.
SELECT col1
FROM patterns
WHERE col1 NOT LIKE '%\_%';

-- 14.write a SQL query to find rows in which col1 contains the forward 
-- slash character ( / ). Return col1.
SELECT col1
FROM patterns
WHERE col1 LIKE '%/%';

-- 15. write a SQL query to identify those rows where col1 does not 
-- contain the forward slash character ( / ). Return col1.
SELECT col1
FROM patterns
WHERE col1 NOT LIKE '%/%';

-- 16. write a SQL query to find those rows where col1 contains 
-- the string ( _/ ). Return col1.
SELECT col1
FROM patterns
WHERE col1 LIKE '%_/%';

-- 17. write a SQL query to find those rows where col1 does not 
-- contain the string ( _/ ). Return col1.
SELECT col1
FROM patterns
WHERE col1 NOT LIKE '%_/%';

-- 18. write a SQL query to find those rows where col1 contains 
-- the character percent ( % ). Return col1.
SELECT col1
FROM patterns
WHERE col1 LIKE '%\%%';

-- 19. write a SQL query to find those rows where col1 does not 
-- contain the character percent ( % ). Return col1.
SELECT col1
FROM patterns
WHERE col1 NOT LIKE '%\%%';


-- 20. write a SQL query to find all those customers who does not have any grade. 
-- Return customer_id, cust_name, city, grade, salesman_id.
SELECT customer_id, cust_name, city, grade, salesman_id
FROM customer
WHERE grade IS NULL;

-- 21. write a SQL query to locate all customers with a grade value. 
-- Return customer_id, cust_name,city, grade, salesman_id.
SELECT customer_id, cust_name, city, grade, salesman_id
FROM customer
WHERE grade IS NOT NULL;

-- 22. write a SQL query to locate the employees whose last name begins with the letter 'D'. 
-- Return emp_idno, emp_fname, emp_lname and emp_dept. 
SELECT emp_idno, emp_fname, emp_lname, emp_dept
FROM employees_table
WHERE emp_lname LIKE 'D%';

