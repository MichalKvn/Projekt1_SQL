
CREATE TABLE t_Michal_Kavan_project_SQL_secondary_final AS 
SELECT 
	t.payroll_year,
	e.country,
	e.GDP,
	e.gini,
	e.population 
FROM economies e  
LEFT JOIN t_Michal_Kavan_project_SQL_primary_final t
	ON e.`year` = t.payroll_year
WHERE payroll_year IS NOT NULL
GROUP BY t.payroll_year, e.country;
