
CREATE TABLE t_Michal_Kavan_project_SQL_primary_final AS 
SELECT 
	cp.payroll_year,
	cpib.name,
	cp.value as salary,  
	year(cp2.date_from),
	cpc.name as product, 
	cpc.price_value, 
	cpc.price_unit, 
	cp2.value 
FROM 
	czechia_payroll cp 
LEFT JOIN czechia_price cp2 
	ON cp.payroll_year = year(cp2.date_from)
LEFT JOIN czechia_price_category cpc 
	ON cp2.category_code = cpc.code
LEFT JOIN czechia_payroll_industry_branch cpib 
	ON cp.industry_branch_code = cpib.code 
WHERE cp.value_type_code = 5958 AND cpc.name IS NOT NULL
GROUP BY cp.payroll_year, product, cpib.name;
