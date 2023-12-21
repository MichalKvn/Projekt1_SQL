
SELECT 
    payroll_year,
    product,
    change_,
    round((change_/price) * 100, 2) AS average_percent_change
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
GROUP BY product, payroll_year
ORDER BY average_percent_change
LIMIT 1;
