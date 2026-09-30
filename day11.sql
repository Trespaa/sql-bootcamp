SELECT
    product,
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month
FROM orders;

SELECT
    DATE_TRUNC('month', order_date) AS month, --redondea al mes
    SUM(amount) AS total_revenue
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;


-- ticket medio mensual
SELECT
    DATE_TRUNC('month', order_date) AS month,
    COUNT(*) AS total_orders,
    SUM(amount) AS total_revenue,
    ROUND(AVG(amount), 2) AS average_order
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

-- order_date + INTERVAL '7 days'