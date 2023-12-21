
-- Czechia_only
CREATE OR REPLACE VIEW czechia_only AS
SELECT 
	t.payroll_year,
	e.GDP,
	t.name,
	t.salary,
 	t.product,
 	t.price,
 	t.price_value,
 	t.price_unit
FROM t_Michal_Kavan_project_SQL_secondary_final e
JOIN t_Michal_Kavan_project_SQL_primary_final t
	ON t.payroll_year = e.payroll_year
WHERE country = 'Czech Republic'
	AND name IS NOT NULL;

-- Comparison

CREATE OR REPLACE VIEW overall_comparison AS
SELECT 
    t1.payroll_year AS 'year_0',
    t1.GDP,
    t1.name,
    t1.salary,
    t1.product,
    t1.price,
    t1.price_value,
    t1.price_unit,
    t2.payroll_year AS 'year_plus1',
    t2.GDP AS 'GDP_plus1',
    t2.name AS 'name_plus1',
    t2.salary AS 'salary_plus1',
    t2.product AS 'product_plus1',
    t2.price AS 'value_plus1',
    t2.price_value AS 'price_value_plus1',
    t2.price_unit AS 'price_unit_plus1'
FROM 
    czechia_only t1
JOIN 
    czechia_only t2
ON 
    t1.name = t2.name 
    AND t1.product = t2.product 
    AND t1.payroll_year = t2.payroll_year - 1
    AND t1.price_value = t2.price_value
    AND t1.price_unit = t2.price_unit;

-- Final_select
SELECT 
	`year_plus1`,
 	avg((`GDP_plus1` - `GDP`)/ `GDP_plus1`) * 100 AS GDP_percent_increase,
 	avg((`salary_plus1` - `salary`)/ `salary_plus1`) * 100 AS salary_percent_increase,
 	avg((`value_plus1` - `price`)/ `value_plus1`) * 100 AS product_value_percent_increase
FROM overall_comparison
GROUP BY `year_plus1`;


