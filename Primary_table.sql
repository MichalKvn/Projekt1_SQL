
-- 1. odvětví se mzdami dle let

CREATE OR REPLACE VIEW odvětví_a_mzdy AS 
SELECT 
	cp.payroll_year,
	round(avg(cp.value)) AS salary,
	cpib.name
FROM czechia_payroll cp 
LEFT JOIN czechia_payroll_industry_branch cpib 
	ON cp.industry_branch_code  = cpib.code
WHERE cp.value_type_code = 5958 AND name IS NOT NULL
GROUP BY payroll_year, name;

SELECT 
	*
FROM odvětví_a_mzdy


-- 2. potraviny dle let

CREATE OR REPLACE VIEW potraviny AS
SELECT 
	year(cpr.date_from) AS common_year,
	cpc.name,
	round(avg(cpr.value),2) AS price,
	cpc.price_value,
	cpc.price_unit
FROM czechia_price cpr
LEFT JOIN czechia_price_category cpc 
	ON cpr.category_code = cpc.code 
WHERE year(cpr.date_from) IN (
    SELECT DISTINCT year(date_to) 
    FROM czechia_price)
    	AND region_code IS NULL
GROUP BY common_year, name;

SELECT 
	*
FROM potraviny

-- 3. spojení 

CREATE TABLE t_Michal_Kavan_project_SQL_primary_final AS 
SELECT 
	p.common_year AS payroll_year,
	om.name,
	om.salary,
	p.name AS product,
	p.price,
	p.price_value,
	p.price_unit
FROM potraviny p
LEFT JOIN odvětví_a_mzdy om
	ON p.common_year = om.payroll_year
GROUP BY payroll_year, product, om.name	

SELECT 
	*
FROM t_Michal_Kavan_project_SQL_primary_final
	
	
	
