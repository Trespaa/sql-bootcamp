-- análisis de clientes 
SELECT
    c.name,
    COUNT(o.order_id) AS total_orders,
    CASE
        WHEN COUNT(o.order_id) = 0 THEN 'Inactive'
        WHEN COUNT(o.order_id) = 1 THEN 'Occasional'
        ELSE 'Frequent'
    END AS customer_type
FROM customers AS c
LEFT JOIN orders AS o
    ON c.id = o.customer_id
GROUP BY c.id, c.name;

SELECT
    c.name,
    MIN(o.order_date) AS first_order,
    MAX(o.order_date) AS last_order
FROM customers AS c
LEFT JOIN orders AS o
    ON c.id = o.customer_id
GROUP BY c.id, c.name;

SELECT
    c.name,
    MAX(o.order_date) - MIN(o.order_date) AS days_between_orders
FROM customers AS c
LEFT JOIN orders AS o
    ON c.id = o.customer_id
GROUP BY c.id, c.name;

-- NULLIF evita un problema matemático y lo transofrma en null.
-- 10/NULLIF(0,0);

SELECT
    c.name,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.amount), 0) AS total_spent,
    COALESCE(ROUND(AVG(o.amount), 2), 0) AS average_order,
    CASE
        WHEN COUNT(o.order_id) = 0 THEN 'Inactive'
        WHEN COUNT(o.order_id) = 1 THEN 'Occasional'
        ELSE 'Frequent'
    END AS customer_type
FROM customers AS c
LEFT JOIN orders AS o
    ON c.id = o.customer_id
GROUP BY c.id, c.name
ORDER BY total_spent DESC;