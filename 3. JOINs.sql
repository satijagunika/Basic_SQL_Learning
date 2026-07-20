-- JOINS : JOINS allow you to combine two tables or more together if they have a common column, now by common column we dont mean the column with the same header, common column means the data in it is same or the data type matches

SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary
;
 
-- INNER JOIN : Most common and simple join, INNER JOIN is going to return rows that are the same in both columns of both the tables 
SELECT *
FROM employee_demographics
 JOIN employee_salary -- By default JOIN means INNER JOIN in SQL
	ON employee_demographics.employee_id = employee_salary.employee_id;
    
-- Query using Aliasing
SELECT *
FROM employee_demographics AS demo
 JOIN employee_salary AS sal
	ON demo.employee_id = sal.employee_id;
    
-- OUTER JOIN    
-- LEFT JOIN :
SELECT *
FROM employee_demographics AS demo
 LEFT JOIN employee_salary AS sal
	ON demo.employee_id = sal.employee_id;
	
-- RIGHT JOIN :
SELECT *
FROM employee_demographics AS demo
 RIGHT JOIN employee_salary AS sal
	ON demo.employee_id = sal.employee_id;
    
-- SELF JOIN : Tying the table to itself 
SELECT emp1.employee_id AS emp_santa, 
emp1.first_name AS first_name_santa, 
emp1.last_name AS last_name_santa,
emp2.employee_id AS emp_name, 
emp2.first_name AS first_name, 
emp2.last_name AS last_name 
FROM employee_salary emp1
 JOIN employee_salary emp2
	ON emp1.employee_id +1 = emp2.employee_id;
    
-- Joining multiple tables together 
select *
FROM employee_demographics AS demo
 INNER JOIN employee_salary AS sal
	ON demo.employee_id = sal.employee_id
 INNER JOIN parks_departments AS pd
	ON 	sal.dept_id = pd.department_id;

SELECT *
FROM parks_departments;

-- SELECT *
-- FROM employee_demographics AS demo
--  FULL OUTER JOIN employee_salary AS sal
-- 	ON demo.employee_id = sal.employee_id;

SELECT emp1.employee_id AS employee_id,
emp1.first_name AS employee_first_name,
emp1.last_name AS employee_first_name,
mgr1.employee_id AS manager_id,
mgr1.first_name AS manager_first_name,
mgr1.last_name AS manager_last_name
FROM employee_salary emp1
 JOIN employee_salary mgr1
	ON emp1.employee_id = mgr1.employee_id
;