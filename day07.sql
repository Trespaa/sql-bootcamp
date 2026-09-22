-- REPASO DE LOS OTROS 6

-- GASTO SUPERIOR A 200 EUROS
SELECT
    c.name,
    SUM(o.amount) AS total_spent
FROM customers AS c
INNER JOIN orders AS o
    ON c.id = o.customer_id
GROUP BY c.id, c.name
HAVING SUM(o.amount) > 200
ORDER BY total_spent DESC;

-- TICKET MEDIO POR PAÍS
SELECT
    c.country,
    ROUND(AVG(o.amount), 2) AS average_order
FROM customers AS c
INNER JOIN orders AS o
    ON c.id = o.customer_id
GROUP BY c.country
ORDER BY average_order DESC;

--MINI PROYECTO: Informe de negocio
SELECT
    c.name,
    c.country,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.amount), 0) AS total_spent,
    COALESCE(ROUND(AVG(o.amount), 2), 0) AS average_order,
    CASE
        WHEN COALESCE(SUM(o.amount), 0) > 500
            THEN 'VIP'
        WHEN COALESCE(SUM(o.amount), 0) >= 100
            THEN 'Regular'
        ELSE 'Basic'
    END AS segment
FROM customers AS c
LEFT JOIN orders AS o
    ON c.id = o.customer_id
GROUP BY
    c.id,
    c.name,
    c.country
ORDER BY total_spent DESC;