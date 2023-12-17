
SELECT 
    payroll_year,
    product,
    change_,
    round((change_/value) * 100, 2) AS average_percent_change
FROM (
    SELECT
        payroll_year,
        product,
        value,
        lag(value) OVER (PARTITION BY product ORDER BY payroll_year) AS lag_value,
        value - lag(value) OVER (PARTITION BY product ORDER BY payroll_year) AS change_
    FROM
        t_Michal_Kavan_project_SQL_primary_final
) AS subquery
WHERE change_ IS NOT NULL AND change_ <> 0
GROUP BY product, payroll_year
ORDER BY average_percent_change
LIMIT 1;
