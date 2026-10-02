-- PRIMER MINI PROYECTO DE DATA ANALYST
-- ventas
SELECT
    SUM(amount) AS total_revenue
FROM orders;

-- ticket medio
SELECT
    ROUND(AVG(amount), 2) AS average_order
FROM orders;

-- mejor cliente
SELECT
    c.name,
    SUM(o.amount) AS total_spent
FROM customers AS c
JOIN orders AS o
    ON c.id = o.customer_id
GROUP BY c.id, c.name
ORDER BY total_spent DESC
LIMIT 1;

-- quién nunca ha comprado
SELECT
    c.name
FROM customers AS c
LEFT JOIN orders AS o
    ON c.id = o.customer_id
WHERE o.order_id IS NULL;

-- producto más comprado
SELECT
    product,
    SUM(amount) AS revenue
FROM orders
GROUP BY product
ORDER BY revenue DESC
LIMIT 1;


-- evolución ventas
SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(amount) AS revenue
FROM orders
GROUP BY 1
ORDER BY 1;

