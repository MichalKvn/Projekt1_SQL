
SELECT 
	t1.name,
    t1.payroll_year AS year_1,
    t1.salary AS salary_1,
    t2.payroll_year AS year_2,
    t2.salary AS salary_2,
    CASE
        WHEN t1.salary < t2.salary THEN 'rise'
        WHEN t1.salary > t2.salary THEN 'fall'
        ELSE 'no_data'
    END AS rise_fall
FROM 
    (SELECT payroll_year, salary, name FROM t_Michal_Kavan_project_SQL_primary_final GROUP BY payroll_year, name) t1
JOIN 
    (SELECT payroll_year, salary, name FROM t_Michal_Kavan_project_SQL_primary_final GROUP BY payroll_year, name) t2
ON 
    t1.name = t2.name AND t1.payroll_year = t2.payroll_year - 1
WHERE 
    CASE
        WHEN t1.salary < t2.salary THEN 'rise'
        WHEN t1.salary > t2.salary THEN 'fall'
        WHEN t1.salary = t2.salary THEN 'no_change'
        ELSE 'no_data'
    END = 'fall';