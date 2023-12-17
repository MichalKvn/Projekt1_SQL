
SELECT 
    t.payroll_year,
    t.name,
    t.salary,
    t.product,
    ROUND((t.salary / t.value), 2) AS number_of_pieces,
    t.price_unit
FROM 
    t_Michal_Kavan_project_SQL_primary_final t
WHERE 
    t.product IN ('Chléb konzumní kmínový', 'Mléko polotučné pasterované') 
    AND t.name IS NOT NULL 
    AND t.payroll_year = (
        SELECT MAX(payroll_year) 
        FROM t_Michal_Kavan_project_SQL_primary_final 
        WHERE name = t.name AND product = t.product
    )
UNION
SELECT 
    t.payroll_year,
    t.name,
    t.salary,
    t.product,
    ROUND((t.salary / t.value), 2) AS number_of_pieces,
    t.price_unit
FROM 
    t_Michal_Kavan_project_SQL_primary_final t
WHERE 
    t.product IN ('Chléb konzumní kmínový', 'Mléko polotučné pasterované') 
    AND t.name IS NOT NULL 
    AND t.payroll_year = (
        SELECT MIN(payroll_year) 
        FROM t_Michal_Kavan_project_SQL_primary_final 
        WHERE name = t.name AND product = t.product
    )
