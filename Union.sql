-- Unions

SELECT first_name, last_name
FROM employee_demographics
UNION DISTINCT
SELECT first_name, last_name
FROM employee_salary
;


SELECT first_name, last_name, 'OLD Man' AS Lable
FROM employee_demographics
WHERE Age > 40 AND gender = 'Male'
UNION
SELECT first_name, last_name, 'OLD Lady' AS Lable
FROM employee_demographics
WHERE Age > 40 AND gender = 'Female'
UNION
SELECT first_name, last_name, 'Highly Paid Employee' AS Lable
FROM employee_salary
WHERE salary > 70000
ORDER BY first_name, last_name
;












