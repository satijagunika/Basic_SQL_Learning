SELECT *
FROM parks_and_recreation.employee_demographics;

-- PEMDAS in SELECT STATEMENT : Order of operation for arithematic and math in SQL, P: Paranthesis, E: Exponenet, M: Multiplication, D: Division, A: Addition, S: Subtraction  
SELECT employee_id, age,
age+10,
(age+10) * 10 - 10 + 10 AS Pemdas_Example
FROM parks_and_recreation.employee_demographics;

-- DISTICT in SELECT Statement
 -- DISTINCT with only one column 
SELECT DISTINCT gender
FROM parks_and_recreation.employee_demographics;
-- result: Female and male, because there are only two unique values in the gender column 

 -- DISTINCT with two column 
 SELECT distinct first_name, gender
FROM parks_and_recreation.employee_demographics;


-- WHERE : The WHERE clause is used to help filter the records, so when we use WHERE clause we are only going to return the rows that filter a specific condition
select*
FROM employee_salary
WHERE salary >= 50000
;
-- = is used to show that the value should be equal to the value mentioned after that, in case we dont want the same value we can use the != which means not equal
 select*
FROM employee_demographics
WHERE gender = "Female"; -- while looking for string records always add '' around the text else the query will throw an error 
 
select*
FROM employee_demographics
WHERE gender != "Female"; -- output of this query will show only Male gender as the arithematic operation used means not equal to the value mentioned 

-- The defualt date setting in MySQL is "YYYY-MM-DD", WHERE clause can have more then one filter
select*
FROM employee_demographics
WHERE gender != "Female"
AND birth_date > 1985-01-01; -- AND is a logical operator  

-- 'AND', 'OR', 'NOT' - These are called logical operators, 
SELECT*
FROM employee_demographics
WHERE gender = " Female"
OR birth_date > 1985-01-01; -- We don't need 'quotes' for integers 

-- ISOLATED CONDITIONAL STATEMENT: It's just a teaching term used by instructors to describe grouping conditions using parentheses () so SQL evaluates them together first
SELECT *
FROM employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) OR age > 55;

SELECT *
FROM employee_salary
WHERE salary >= 50000  -- IN SQL numbers cannot have commas  
;

-- LIKE STATEMENT : Two special conditions : % means anything and _ means exactly the same 
SELECT *
FROM employee_demographics
WHERE first_name LIKE '%a%';

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a__'; -- 2 underscore means 2 more alphabets after a

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a__%'; -- you can also combine _ and % together 

-- GROUP BY
SELECT gender, avg(age) , MAX(age), MIN(age), count(age)
FROM employee_demographics
GROUP BY gender;

-- ORDER BY 
SELECT *
FROM employee_demographics
ORDER BY first_name; -- text column used hence it goes from A to Z if order by is used using ASC 

-- HAVING V/S WHERE



 
