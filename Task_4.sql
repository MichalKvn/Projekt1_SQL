
-- percent_food
CREATE OR REPLACE VIEW food_percent_change AS
SELECT 
    payroll_year,
    product,
    round((change_/price) * 100, 2) AS food_percent_change
FROM (
    SELECT
        payroll_year,
        product,
        price,
        lag(price) OVER (PARTITION BY product ORDER BY payroll_year) AS lag_value,
        price - lag(price) OVER (PARTITION BY product ORDER BY payroll_year) AS change_
    FROM
        t_Michal_Kavan_project_SQL_primary_final
) AS subquery
WHERE change_ IS NOT NULL AND change_ <> 0
GROUP BY product, payroll_year;


-- percent_salary
CREATE OR REPLACE VIEW salary_percent_change AS
SELECT
    payroll_year,
    name,
    salary,
    salary_previous,
    salary_change,
    round((salary_change / salary) * 100, 2) AS salary_percent_change
FROM (
    SELECT
        payroll_year,
        name,
        salary,
        lag(salary) OVER (PARTITION BY name ORDER BY payroll_year) AS salary_previous,
        salary - lag(salary) OVER (PARTITION BY name ORDER BY payroll_year) AS salary_change
    FROM
        t_Michal_Kavan_project_SQL_primary_final
) AS subquery
WHERE name IS NOT NULL 
	AND salary_previous IS NOT NULL 
GROUP BY name, payroll_year;

-- filtering
SELECT
    f.payroll_year,
    avg(f.food_percent_change),
    avg(s.salary_percent_change)
FROM
    food_percent_change f
JOIN
    salary_percent_change s 
   ON f.payroll_year = s.payroll_year
GROUP BY f.payroll_year;

-- filtering (higher > 10%)
SELECT
    f.payroll_year,
    avg(f.food_percent_change),
    avg(s.salary_percent_change)
FROM
    food_percent_change f
JOIN
    salary_percent_change s 
   ON f.payroll_year = s.payroll_year
GROUP BY f.payroll_year
HAVING avg(f.food_percent_change) - avg(s.salary_percent_change) > 10;
