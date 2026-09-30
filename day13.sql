-- window functions
SELECT
    order_id,
    customer_id,
    product,
    amount,
    SUM(amount) OVER (
        PARTITION BY customer_id
    ) AS customer_total
FROM orders;
-- SUM(amount) OVER () significa alcula la suma teniendo en cuenta todas las filas
SELECT
    order_id,
    amount,
    SUM(amount) OVER () AS total_revenue
FROM orders;

-- PARTITION BY Divide las filas en grupos para hacer el cálculo.

-- suma acumulada
SELECT
    order_id,
    amount,
    SUM(amount) OVER (
        ORDER BY amount
    ) AS running_total
FROM orders;

SELECT
    order_id,
    product,
    amount,
    ROW_NUMBER() OVER (         -- row_number asigna un número a cada fila
        ORDER BY amount DESC
    ) AS position
FROM orders;

-- Función	        Empates	    Deja huecos
-- ROW_NUMBER()	    ❌	        ❌
-- RANK()	        ✅	        ✅
-- DENSE_RANK()	    ✅	        ❌

SELECT
    c.name,
    o.product,
    o.amount,

    SUM(o.amount) OVER (
        PARTITION BY c.id
    ) AS customer_total,

    ROW_NUMBER() OVER (
        PARTITION BY c.id
        ORDER BY o.amount DESC
    ) AS order_position

FROM customers AS c

INNER JOIN orders AS o
    ON c.id = o.customer_id

ORDER BY c.name, order_position;