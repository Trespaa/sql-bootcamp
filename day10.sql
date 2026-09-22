-- CTEs: Common Table Expression. Crear una consulta temporal con un nombre y después utilizarla como si fuera una tabla.
WITH average_age AS (
    SELECT AVG(age) AS avg_age
    FROM customers
)
SELECT
    name,
    age
FROM customers
WHERE age > (
    SELECT avg_age
    FROM average_age
);

--calcular cuánto ha gastado cada cliente
WITH customer_spending AS (
    SELECT  customer_id,
            SUM(amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT c.name,
        COALESCE(cs.total_spent, 0) AS total_spent
FROM customers AS c
LEFT JOIN customer_spending AS cs 
    ON c.id = cs.customer_id;

-- CTE + WHERE
WITH customer_spending AS (
    SELECT
        customer_id,
        SUM(amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.name,
    cs.total_spent
FROM customers AS c
INNER JOIN customer_spending AS cs
    ON c.id = cs.customer_id
WHERE cs.total_spent > 100
ORDER BY cs.total_spent DESC;

-- Varias CTEs
WITH
customer_spending AS (
    SELECT
        customer_id,
        SUM(amount) AS total_spent
    FROM orders
    GROUP BY customer_id
),
customer_orders AS (
    SELECT
        customer_id,
        COUNT(order_id) AS total_orders
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.name,
    COALESCE(cs.total_spent, 0) AS total_spent,
    COALESCE(co.total_orders, 0) AS total_orders
FROM customers AS c
LEFT JOIN customer_spending AS cs
    ON c.id = cs.customer_id
LEFT JOIN customer_orders AS co
    ON c.id = co.customer_id
ORDER BY total_spent DESC;

-- Segmentación con CTE
WITH customer_spending AS (
    SELECT
        c.id,
        c.name,
        COALESCE(SUM(o.amount), 0) AS total_spent
    FROM customers AS c
    LEFT JOIN orders AS o
        ON c.id = o.customer_id
    GROUP BY c.id, c.name
)
SELECT
    name,
    total_spent,
    CASE
        WHEN total_spent > 500 THEN 'VIP'
        WHEN total_spent >= 100 THEN 'Regular'
        ELSE 'Basic'
    END AS segment
FROM customer_spending
ORDER BY total_spent DESC;
