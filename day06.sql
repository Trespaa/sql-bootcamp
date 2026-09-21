-- relación entre tablas customers.id = orders.customer_id

-- Calcular el gasto total de cada cliente (COALESCE() devuelve el primer valor que no sea NULL)
SELECT
    c.name,
    COALESCE(SUM(o.amount), 0) AS total_spent
FROM customers AS c
LEFT JOIN orders AS o
    ON c.id = o.customer_id
GROUP BY c.id, c.name
ORDER BY total_spent DESC;

-- Contar pedidos por cliente
SELECT
    c.name,
    COUNT( o.order_id ) AS total_orders
FROM customers AS c
LEFT JOIN orders AS o 
    ON c.id=o.customer_id
GROUP BY c.id, c.name
ORDER BY total_orders DESC;

-- Clasificaremos a los clientes según su gasto con CASE WHEN + JOIN
SELECT
    c.name,
    COALESCE(SUM(o.amount), 0) AS total_spent,
CASE 
    WHEN COALESCE(SUM(o.amount), 0) > 500
        THEN 'high_value'
    WHEN COALESCE(SUM(o.amount), 0) >= 100
        THEN 'medium_value'
    ELSE 'low_value'
END AS customer_segment
FROM customers AS c
LEFT JOIN orders as o
    ON c.id=o.customer_id
GROUP BY c.id, c.name
ORDER BY total_spent DESC;

--MINI PROYECTO DÍA 6
SELECT
    c.name,
    c.country,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.amount), 0) AS total_spent,
CASE
    WHEN COALESCE(SUM(o.amount), 0) > 500
        THEN 'VIP'
    WHEN COALESCE(SUM(o.amount), 0) >= 100
        THEN 'REGULAR'
    ELSE 'LOW'
END AS segment
FROM customers AS c
LEFT JOIN orders AS o
    ON c.id = o.customer_id
GROUP BY 
    c.id,
    c.name,
    c.country
ORDER BY total_spent DESC;