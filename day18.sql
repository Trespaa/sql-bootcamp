-- Análisis temporal avanzado

--Ventas mensuales
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(amount) AS revenue
    FROM orders
    GROUP BY DATE_TRUNC('month', order_date)
)
SELECT *
FROM monthly_sales
ORDER BY month;

WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(amount) AS revenue
    FROM orders
    GROUP BY DATE_TRUNC('month', order_date)
)
SELECT
    month,
    revenue,
    LAG(revenue) OVER (
        ORDER BY month
    ) AS previous_month
FROM monthly_sales;

-- crecimiento
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(amount) AS revenue
    FROM orders
    GROUP BY DATE_TRUNC('month', order_date)
)
SELECT
    month,
    revenue,
    ROUND( (revenue - LAG(revenue) OVER ( ORDER BY month))
            /NULLIF(LAG(revenue) OVER (ORDER BY month ), 0) 
            * 100, 2) AS growth_percentage
FROM monthly_sales;


--ACUMULADO
SUM(revenue) OVER (
    ORDER BY month
)
-- MEDIA MOVIL
AVG(revenue) OVER (
    ORDER BY month
    ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
)