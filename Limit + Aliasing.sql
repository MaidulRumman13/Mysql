-- Limit & Aliasing

SELECT *
FROM employee_demographics
order by age desc
limit 2, 1
;

-- Aliasing
select gender, avg(age) as avg_age
from employee_demographics
group by  gender
having avg_age > 40
;