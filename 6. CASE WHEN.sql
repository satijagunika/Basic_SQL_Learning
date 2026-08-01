-- Topics covered: CASE STATEMENT, BETWEEN, COALESCE(), IFNULL(), ISNULL() 
-- BETWEEN : The BETWEEN operator is used in the WHERE clause to select vales within a specified range. The range is inclusive - the beginning and the end values of the range are included in the result.
SELECT 
    *
FROM
    employee_demographics
WHERE
    age BETWEEN 31 AND 50;-- need two values for between operator, the result consisted of employee data whose age id between 31 and 50 

SELECT 
    *
FROM
    employee_demographics
WHERE
    birth_date BETWEEN '1962-01-01' AND '1979-12-31';-- The date format in mySQL is 'YYYY-MM-DD' and always use single quote arounds date so that SQL consider it as date and not as number! 

SELECT 
    *
FROM
    employee_salary
WHERE
    salary BETWEEN 50000 AND 80000;

-- COALESCE : The COALESACE function returns the first non-null valuein a list. ANSI SQL standard works across multiple database and can accept two or more arguments.
SELECT 
    emp_data.employee_id,
    emp_data.first_name,
    emp_data.last_name,
    emp_data.age,
    emp_data.gender,
    salary.salary
FROM
    employee_salary AS salary
        JOIN
    employee_demographics AS emp_data ON salary.employee_id = emp_data.employee_id;

-- CASE WHEN 
SELECT 
    first_name,
    last_name,
    age,
    CASE
        WHEN age <= 30 THEN 'young'
        WHEN age BETWEEN 31 AND 50 THEN 'old'
        WHEN age >= 51 THEN 'On Death Door'
    END AS age_bracker
FROM
    employee_demographics;

SELECT 
    first_name,
    last_name,
    CASE
        WHEN salary > 50000 THEN salary * 1.05
        WHEN salary < 50000 THEN salary * 1.07
    END AS new_salary
FROM
    employee_salary;