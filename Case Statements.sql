-- Case Statements

SELECT first_name,
last_name,
age,
CASE
	WHEN age <= 30 THEN 'Young'
    WHEN age BETWEEN 31 AND 50 THEN 'OLD'
    WHEN age >= 50 THEN 'On Last Stage of Life'
END AS age_bracket
FROM employee_demographics
;

-- Pay Increase and Bonus
-- < 50000 = 5%
-- >50000 =7%
-- Finance = 10% Bonus

SELECT first_name, last_name, salary, 
CASE
	WHEN salary < 50000 THEN salary + (salary *0.05)
    WHEN salary > 50000 THEN salary *1.07
END AS new_salary,
CASE 
	WHEN dept_id =  6 THEN salary * 0.1
END AS bonus
FROM employee_salary
;

SELECT *
FROM employee_salary;

SELECT *
FROM parks_departments;















