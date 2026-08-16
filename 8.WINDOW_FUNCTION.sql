-- WINDOW FUNCTION : WINDOW FUNCTIONS perform calculations across related rows while keeping every original rows in the output. WINDOW function is very powerful and are somewhat like a GROUP BY except they dont roll everything up into one row while grouping
-- PARTITION BY : This clause in MYSQL divides the result set into smaller groups so calculation can be performed independtly within each group. used with window functions like RANK(), DENSE_RANK(), LEAD(), LAG(). Each partition is processed seperatly for calculations. Create partitions(also called WINDOWS within the result set.)
 -- WINDOW functions allows us to look at a partition or a group but they keep their own unique rows in the output. 

 
 SELECT first_name, last_name, AVG(salary) OVER() -- The OVER clause is the most important part. An empty OVER() means consider all rows as one Window. 
 FROM employee_salary; -- If you run this you will see that the rows didn't collapse into single row, instead WINDOW function performed calculation acress the set of rows, every original row remains in the result. 
-- MYSQL allows you to further define the WINDOW using :
-- OVER( "entire dataset"
-- 		PARTITION BY ... "Divide the dataset into groups but dont collapse the rows"
-- 		ORDER BY ..."Defines the order in which rows are processed within the window"
-- )  
 
-- PART A: AGGREGATE WINDOW FUNCTION : AVG(), MAX(), MIN(), SUM(), COUNT()
-- AVG(): It calculates the average of a numeric column
-- Normal aggregate 
SELECT 
    AVG(salary)
FROM
    employee_salary;
-- WINDOW FUNCTION 
SELECT 
	first_name, 
	last_name, 
	dept_id, 
	AVG(salary) OVER ( ) AS avg_salary  -- Every employee get the overall average 
FROM 
	employee_salary;
-- With PARTITION BY - shows each employee's salary along with the average salary of each department
SELECT 
	first_name, 
    last_name, 
    dept_id, 
    AVG(salary) OVER (PARTITION BY dept_id) AS avg_salary 
FROM 
employee_salary;

-- MAX: Returns the maximum value within the WINDOW
SELECT first_name, last_name, MAX(age) as oldest_employee, gender
FROM employee_demographics
GROUP BY employee_id
ORDER BY MAX(age) DESC;

-- MAX with WINDOW function OVER()
SELECT 
	first_name, 
	last_name,
    age,
	MAX(age) OVER() AS oldest_employee, -- Calculate the maximum age across the window, BUT DON'T COLLAPSE THE ROWS.  -- MAX() with OVER() is a window function. Unlike a regular aggregate function, it does not collapse rows,-- so GROUP BY is not required. The maximum value is calculatedacross the window and displayed alongside every row.
    gender
FROM employee_demographics;

SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;

SELECT 
	first_name, 
	last_name,
    age,
	MAX(age) OVER() AS oldest_employee, -- Calculate the maximum age across the window, BUT DON'T COLLAPSE MY ROWS.  
    gender
FROM employee_demographics;

SELECT 
	dept_id,
	first_name, 
	last_name,
    salary,
	MAX(salary) OVER(PARTITION BY dept_id) AS highest_salary 
FROM employee_salary
ORDER BY highest_salary DESC;

-- MIN: Exactly the opposite of MAX(), this will return the minimum value within the WINDOW
SELECT 
	first_name, 
	last_name,
    age,
	MIN(age) OVER() AS youngest_employee, -- Calculate the minimum age across the window, BUT DON'T COLLAPSE MY ROWS.  
    gender
FROM employee_demographics;

-- SUM : Returns the sum of values within the window
SELECT first_name, last_name, salary, SUM(salary) OVER() AS total_employee
FROM employee_salary;

-- SUM has one more very useful application, i.e, RUNNING TOTAL, -- A RUNNING TOTAL IS GOING TO START AT A SPECIFIC VALUE AND ADD ON VALUES FROM SUBSEQUENT ROWS BASED ON THE PARTITION
SELECT dem.first_name, dem.last_name, gender,salary,
SUM(salary) OVER( PARTITION BY gender ORDER BY dem.employee_id) AS running_total   -- PARTITON BY: seperates the calculation by gender; ORDER BY: establish the sequence; SUM: accumulate the values  
FROM employee_demographics dem
JOIN employee_salary sal
ON dem.employee_id = sal.employee_id;

SELECT 
	employee_id,
    first_name,
    occupation,
    salary,
    SUM(salary) OVER (ORDER BY employee_id) AS eg2_running_total
FROM 
	employee_salary
;

-- COUNT(): count rows/values within the window 
SELECT 
first_name,
COUNT(*) OVER() AS total_employees
FROM employee_salary
;

-- With PARTITION BY
SELECT first_name, dept_id,
COUNT(*) OVER(PARTITION BY dept_id) AS emp_in_department
FROM employee_salary;

-- RANKING WINDOW FUNCTION: ROW_NUMBER(), RANK(), DENSE_RANK(), PERCENT_RANK(), LAG(), LEAD(), FIRST_VALUE(), LAST_VALUE() 
-- ROW_NUMBER(): Assigns a unique sequential number to every row ; SYNTAX: ROW_NUMBER() OVER (ORDER BY column_name)
SELECT 
	first_name, 
    salary,
    ROW_NUMBER() OVER(ORDER BY salary DESC) AS row_num -- sequential number is assigned on the basis of the ORDER BY clause   
FROM employee_salary;  

SELECT 
	dem.employee_id, 
    dem.first_name, 
    dem.last_name, 
    dem.gender, 
    sal.salary,
	ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS concept_understanding
FROM 
	employee_demographics dem
JOIN 
	employee_salary sal
ON dem.employee_id = sal.employee_id
;

-- RANK(): The RANK() functions are used to assign ranks to rows within a group based on a specific order (Assigns ranks to rows, skipping ranks for duplicate)
-- DENSE_RANK(): Gives same rank to rows with equal values. It then continues with the next number without skipping, keeping the ranking sequence continue.alter
SELECT 
	dem.employee_id, 
    dem.first_name,
    dem.last_name,
    gender,
    salary,
    ROW_NUMBER() OVER(ORDER BY salary DESC) AS row_num,
    RANK() OVER(ORDER BY salary DESC) AS rank_num,
    DENSE_RANK() OVER(ORDER BY salary DESC) AS dense_rank_num
FROM
	employee_demographics dem
JOIN 
	employee_salary sal
ON 
	dem.employee_id = sal.employee_id
;

-- PERCENT_RANK() :  Shows where a row stands compared to others in the same group; FORMULA: PERCENT_RANK = (Rank-1)/(Total rows in portion-1); Ye har row ki relative rank batata hai, 0 se 1 ke beech.

SELECT 
	dem.employee_id, 
    dem.first_name,
    dem.last_name,
    gender,
    salary,
    PERCENT_RANK() OVER(ORDER BY salary DESC) AS dense_rank_num -- The lowest salary will be 1 and the highest salary will be 0 because ORDER BY clause is in DESC order and all the other values will be between 0 and 1  
FROM
	employee_demographics dem
JOIN 
	employee_salary sal
ON 
	dem.employee_id = sal.employee_id
;

SELECT 
	first_name, 
    last_name, 
    age,
    ROW_NUMBER()OVER(PARTITION BY gender ORDER BY age) AS row_number1,
    RANK()OVER(PARTITION BY gender ORDER BY age) AS rank1, -- TO UNDERSTAND THE WORKING/FORMULA OF PERCENT_RANK 
    DENSE_RANK()OVER(PARTITION BY gender ORDER BY age) AS dense_rank1,
    PERCENT_RANK()OVER(PARTITION BY gender ORDER BY age) AS test_example
FROM employee_demographics;

-- LAG(): It allows you to access a value from a previous row without using SELFJOIN
-- SYNTAX : LAG(column-"the column you want to look at", offset - "tells SQL how many rows backwards you want to go", default_value) OVER(ORDER BY column) # WHY ORDER BY IS IMPORTANT? BECAUSE IT ARRANGE THE ROWS ACCORDING TO THE COLUMN GIVEN, OTHERWISE WITHOUT A MEANINGFUL ORDER SQL DOESN'T KNOW WHAT "PREVIOUS"MEANS!.
SELECT CONCAT(first_name,' ', last_name) AS full_name,
    salary,
    LAG(salary,2) OVER(ORDER BY employee_id) AS previous_salary
FROM employee_salary;

-- LAG can be used with string values also...
SELECT
    employee_id,
    first_name,
    LAG(first_name) OVER(
        ORDER BY employee_id -- ORDER BY tells SQL which row is previous/next, and the argument inside LAG()/LEAD() tells SQL which value from that row you want. 
    ) AS previous_employee
FROM employee_demographics;

-- LEAD() : retrieves a value from a subsequent values. 
SELECT CONCAT(first_name,' ', last_name) AS full_name,
    salary,
    LEAD(salary,2) OVER(ORDER BY employee_id) AS next_salary -- LAG/LEAD don't care WHAT the value is; they care WHERE the row is.
FROM employee_salary;

-- FIRST_VALUE(): returns the value from the first row in the WINDOW according to your ordering; difference between FIRST_VALUE AND MAX IS - FIRST_VALUE: row ordering ke according first value aati hae; MAX/MIN: mathematically max/min value deta hae
SELECT 
	first_name,
    salary,
    FIRST_VALUE(salary) OVER(ORDER BY salary) AS lowest_salary
    FROM employee_salary;
    
-- LAST_VALUE(): 
SELECT 
first_name,
salary,
LAST_VALUE(salary) OVER (ORDER BY salary)
FROM 
employee_salary; 
-- NOTE: SQL ka window kuch cases mein effectively current row tak hota hai.So we explicitly tell SQL: ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING, Meaning: Start from the very first row and include all the way to the very last row.

SELECT 
first_name,
salary,
LAST_VALUE(salary) OVER (ORDER BY salary ROWS BETWEEN unbounded preceding AND UNBOUNDED FOLLOWING) AS highest_salary
FROM 
employee_salary; 

 -- FIRST_VALUE() → first value is usually easy to identify
-- LAST_VALUE() → be careful about the window frame   







 