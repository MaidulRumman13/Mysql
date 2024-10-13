-- Group By
SELECT *
FROM employee_demographics;

SELECT gender
FROM employee_demographics
GROUP BY gender
;

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender
;


-- Order By

SELECT *
FROM employee_demographics
ORDER BY first_name DESC
-- By defualt ascending order
;

SELECT *
FROM employee_demographics
ORDER BY gender, age DESC
;

SELECT *
FROM employee_demographics
ORDER BY 5, 4
-- here  5 & 4 are the position of the columns but write the columns name is the best way
;
