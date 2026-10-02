-- CASOS REALES DE NEGOCIO Y ENTREVISTAS

-- Clientes de alto valor
WITH customer_sales AS (
    SELECT
        c.id,
        c.name,
        COALESCE(SUM(o.amount), 0) AS revenue
    FROM customers AS c
    LEFT JOIN orders AS o
        ON c.id = o.customer_id
    GROUP BY c.id, c.name
)
SELECT *
FROM customer_sales
WHERE revenue > 500;

-- clientes inactivos
SELECT
    c.name
FROM customers AS c
LEFT JOIN orders AS o
    ON c.id = o.customer_id
WHERE o.order_id IS NULL;

-- producto estrella
SELECT
    product,
    SUM(amount) AS revenue
FROM orders
GROUP BY product
ORDER BY revenue DESC
LIMIT 1;

-- mejor mes
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(amount) AS revenue
    FROM orders
    GROUP BY 1
)
SELECT *
FROM monthly_sales
ORDER BY revenue DESC
LIMIT 1;

-- clientes por país
SELECT
    c.country,
    COUNT(DISTINCT c.id) AS customers,
    COALESCE(SUM(o.amount), 0) AS revenue
FROM customers AS c
LEFT JOIN orders AS o
    ON c.id = o.customer_id
GROUP BY c.country
ORDER BY revenue DESC;

-- encuentra duplicados
SELECT
    name,
    COUNT(*) AS repetitions
FROM customers
GROUP BY name
HAVING COUNT(*) > 1;

-- encuentra clientes sin pedidos
SELECT
    c.name
FROM customers AS c
LEFT JOIN orders AS o
    ON c.id = o.customer_id
WHERE o.order_id IS NULL;

-- encuentra la venta máxima por cliente
SELECT
    customer_id,
    MAX(amount) AS max_order
FROM orders
GROUP BY customer_id;

-- encuentra el pedido anterior
SELECT
    customer_id,
    order_date,
    amount,
    LAG(amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
    ) AS previous_amount
FROM orders;

-- Dame los 2 pedidos más caros de cada cliente
WITH ranked_orders AS (
    SELECT
        customer_id,
        product,
        amount,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY amount DESC
        ) AS rn
    FROM orders
)
SELECT
    customer_id,
    product,
    amount
FROM ranked_orders
WHERE rn <= 2;

-- top 1 pedido por cliente
WITH ranked_orders AS (
    SELECT
        customer_id,
        product,
        amount,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY amount DESC
        ) AS rn
    FROM orders
)
SELECT *
FROM ranked_orders
WHERE rn = 1;