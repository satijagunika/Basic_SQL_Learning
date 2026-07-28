-- UNIONS: Allows you to combine rows together, not like columns like we were doing before in JOINS. UNIONS allows you to combine the rows of data from seperate tables of from the same table.
 -- The UNION operation combines the results of two or more SELECT queries into a single result set. 
 -- There are two main types: UNION DISTINCT, which removes duplicate rows, and UNION ALL, which includes all rows, even duplicates.
 -- DISTINCT : is only going to take unique vales
 
 
 -- ****Requirements for UNION:*****
-- *Every SELECT statement within UNION must have the same number of columns
-- *The columns must also have similar data types
-- *The columns in every SELECT statement must also be in the same order

SELECT 
    first_name, last_name
FROM
    employee_demographics 
UNION SELECT 
    first_name, last_name
FROM
    employee_salary;

SELECT 
    first_name, last_name
FROM
    employee_demographics 
UNION ALL SELECT 
    first_name, last_name
FROM
    employee_salary;

SELECT 
    first_name, last_name, 'Old Man' AS label
FROM
    employee_demographics
WHERE
    age > 40 AND gender = 'Male' 
UNION SELECT 
    first_name, last_name, 'Old Women' AS label
FROM
    employee_demographics
WHERE
    age > 40 AND gender = 'female' 
UNION SELECT 
    first_name, last_name, 'highly pais employee' AS label
FROM
    employee_salary
WHERE
    salary > 70000;














