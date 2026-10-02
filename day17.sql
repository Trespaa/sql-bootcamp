-- consultas más complejas
-- Clientes por encima del gasto medio
WITH customer_sales AS (
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
    total_spent
FROM customer_sales
WHERE total_spent > (
    SELECT AVG(total_spent)
    FROM customer_sales
)
ORDER BY total_spent DESC;

-- cast() convertir un tipo
SELECT
    CAST(amount AS INTEGER)
FROM orders;

-- STRING_AGG() junta los productos en una sola caja por persona
SELECT
    customer_id,
    STRING_AGG(product, ', ') AS products
FROM orders
GROUP BY customer_id;

-- INFORME
SELECT
    c.name,
    STRING_AGG(o.product, ', ') AS products,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.amount), 0) AS total_spent
FROM customers AS c
LEFT JOIN orders AS o
    ON c.id = o.customer_id
GROUP BY c.id, c.name
ORDER BY total_spent DESC;

-- PERCENT_RANK()
WITH customer_sales AS (
    SELECT
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
    PERCENT_RANK() OVER (
        ORDER BY total_spent
    ) AS percentile
FROM customer_sales;

-- NTILE() divide las filas por grupos
--NTILE(4) OVER (ORDER BY total_spent DESC)


-- FIRST_VALUE(total_spent) OVER (ORDER BY total_spent DESC) First_value()Obtiene el mayor gasto y lo muestra junto a cada cliente

-- Comparar con el mejor cliente
WITH customer_sales AS (
    SELECT
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
    FIRST_VALUE(total_spent) OVER (
        ORDER BY total_spent DESC
    ) - total_spent AS difference_from_top
FROM customer_sales;