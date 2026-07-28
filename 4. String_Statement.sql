-- STRING FUNCTIONS
-- LENGTH() : The LENGTH() function returns the length of a string (in bytes).
SELECT 
    first_name, LENGTH(first_name) AS no_of_characters
FROM
    employee_demographics
ORDER BY LENGTH(first_name);

-- UPPER(): The UPPER() function converts a string to upper-case. This function is equal to the UCASE() function.
SELECT 
    UPPER(first_name)
FROM
    employee_salary;

-- LOWER() : The LOWER() function converts a string to lower-case. The LCASE() function is equal to the LOWER() function.
SELECT 
    LOWER(first_name)
FROM
    employee_demographics;

-- TRIM() : The TRIM() function removes leading and trailing spaces from a string.
SELECT TRIM('           SKY            ');

-- LTRIM(): The LTRIM() function removes leading spaces from a string.
SELECT LTRIM('           SKY            ');
-- RTRIM() : The RTRIM() function removes trailing spaces from a string.
SELECT RTRIM('           SKY            ');

-- LEFT() : The LEFT() function extracts a number of characters from a string (starting from left).
-- RIGHT(): The RIGHT() function extracts a number of characters from a string (starting from right).
-- SUBSTRING() : The SUBSTRING() function extracts a substring from a string (starting at any position). Note: The position of the first character in the string is 1; The position of the last character in the string is -1.

SELECT 
    first_name,
    LEFT(first_name, 4),
    RIGHT(first_name, 4),
    SUBSTRING(first_name, 3, 2),
    birth_date,
    SUBSTRING(birth_date, 6, 2) AS birth_month
FROM
    employee_demographics;

-- REPLACE() : The REPLACE function replaces all occurence of a substring within a string, with a new string. 
SELECT 
    first_name, REPLACE(first_name, 'a', 'z')
FROM
    employee_demographics;

-- LOCATE(): The LOCATE function returns the position of the first occurence of a substring in a string. If the substring is not found within the original string, this string returns 0. This function performs a case sensitive search.
SELECT 
    first_name, LOCATE('an', first_name)
FROM
    employee_demographics; 
    
-- CONCAT(): Tthe CONCAT function adds two or more expressions together; syntax: CONCAT(exp1, exp2, exp3, ...)
SELECT 
    first_name,
    last_name,
    CONCAT(first_name, ' ', last_name) AS full_name
FROM
    employee_demographics;

-- CONCAT_WS(): Tthe CONCAT_WS function adds two or more expressions together with a seperator; syntax: CONCAT_WS(seperator, exp1, exp2, exp3, ...)
SELECT 
    first_name,
    last_name,
    CONCAT_WS(' ', first_name, last_name) AS full_name
FROM
    employee_demographics;

-- Difference Between CONCAT() and CONCAT_WS() in SQL
-- Both CONCAT() and CONCAT_WS() are string functions used to combine multiple values into a single string. 
-- The primary difference lies in how they handle separators and NULL values.
-- CONCAT() is used to combine multiple strings, but separators must be added manually, and in MySQL it returns NULL if any argument is NULL.
-- CONCAT_WS() ("With Separator") automatically inserts a specified separator between values and ignores NULL values, making it a better choice for formatting full names, addresses, or other structured text.