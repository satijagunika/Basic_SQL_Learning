-- SUBQUERIES: Query within another Query
-- A subquery is embeded inside another query and acts as a input or output for that query. subqueries are also called innerqueries and they can be used in various complex operation in SQL.

SELECT *
FROM employee_demographics
WHERE employee_id IN (                 -- What does IN DO? IN simply means "Is this value present in the list". 
					  SELECT employee_id  -- SQL executes the inner query first
						FROM employee_salary -- Think of SQL storing this temperoary. This temperorary result exists only while the query is running 
                        WHERE dept_id = 1
);

-- Q. Which is better Join os subquery?
-- JOINs: It's ofter easier to understand when combinning related tables. 2. Database optimizers usually executes joins efficiently. 3. It becomes more flexible if you later need columns from both tables
-- SUBQUERIES: You only need a list or a single value from another table. 2. It makes the logic easier to read. 3. You're solving problem onvolving aggregates, fiktering or existence check.

-- Subqueries can return different types of results:
-- 1. Single row subquery: Returns one value, often used with =
-- 2. Multi row subquery: Returns multiple value, used with IN, ANY, ALL
-- 3. Correlated subquery: Executes one for each row of the outer query and refrence column for it

-- USING SUBQUERY IN SELECT STATEMENT 
SELECT first_name, salary,
	(SELECT AVG(salary)
		FROM employee_salary) AS avg_salary
FROM employee_salary;

DESCRIBE employee_salary; -- To understand the data type  

-- ROUND() : The ROUND function rounds a number to a spcified number of decimal places. SYNTAX: ROUND(number, decimals)
SELECT round(345.156,0); -- returns 345

SELECT 
    first_name,
    last_name,
    salary,
    ROUND((SELECT AVG(salary)
			 FROM employee_salary),
            2) AS avg_salary
FROM
    employee_salary;
    
-- CAST() : The CAST FUNCTION converts a function of any type into the specifies data type. SYNTAX: CAST(Value AS Datatype)
SELECT first_name, 
	   salary,
	   CAST(
		   (SELECT AVG(salary) 
           FROM employee_salary) 
	   AS DECIMAL(10,2)) AS avg_salary
FROM employee_salary;

-- FORMAT(): The FORMAT FUNCTIONformats a number to a format like "##, ####, ###.##", rounded to a specific number of decimal places, then it returns the result as a string
-- SYNTAX: FORMAT(number, decimal place)
SELECT first_name,
	   salary,
       FORMAT((SELECT AVG(salary) -- FORMAT() returns a string not a number. So use it only for display purpose. 
				FROM employee_salary),2)
                AS avg_salary
		FROM employee_salary;
 
-- What data type does AVG() returns? -- AVG() returns a numeric value. If the source column is an integer, the result is typically returned as a decimal because an average can contain fractional values. 

-- USING SUBQUERY IN FROM STATEMENT 
SELECT avg_age
FROM 
(SELECT gender,
AVG(age) as avg_age,
MAX(age) as max_age,
MIN(age) as min_age,
COUNT(age)
FROM employee_demographics
GROUP BY gender) AS agg_tables;