SELECT *
    FROM orders;
SELECT *
    FROM customers;

-- INNER JOIN devuelve solo los elementos que coinciden en ambas tablas
SELECT
    customers.name,
    orders.product,
    orders.amount
FROM customers
INNER JOIN orders
    ON customers.id = orders.customer_id;

--EJERCICIO 1
SELECT  
    customers.name,
    customers.country,
    orders.product,
    orders.amount
FROM customers
INNER JOIN orders
    ON orders.customer_id = customers.id;

-- REESCRIBIR CON AS
SELECT
    c.name,
    o.product,
    o.amount
FROM customers AS c
INNER JOIN orders AS o
    ON c.id = o.customer_id;
    
-- ejercicio 2 reescribir el ejercicio uno con c y o
SELECT 
    c.name,
    c.country,
    o.product,
    o.amount
FROM customers AS c 
INNER JOIN orders AS o  
    ON c.id = o.customer_id

-- encontrar clientes sin pedidos
SELECT
    c.name
FROM customers AS c
LEFT JOIN orders AS o
    ON c.id = o.customer_id
WHERE o.order_id IS NULL;

-- right join conserva todos los registros de la tabla derecha, aunque no tengan coincidencia en la izquierda.
SELECT
    c.name,
    o.product,
    o.amount
FROM customers AS c
RIGHT JOIN orders AS o
    ON c.id = o.customer_id;

--Un FULL OUTER JOIN devuelve todos los registros de ambas tablas, tengan coincidencia o no.
SELECT
    c.name,
    o.product,
    o.amount
FROM customers AS c
FULL OUTER JOIN orders AS o
    ON c.id = o.customer_id;

-- aplica a un join + where o join + order by o join + group by
SELECT
    c.name,
    c.country,
    o.product,
    o.amount
FROM customers AS c
INNER JOIN orders AS o
    ON c.id = o.customer_id
WHERE c.country = 'Spain'; 

SELECT
    c.name,
    o.product,
    o.amount
FROM customers AS c
INNER JOIN orders AS o
    ON c.id = o.customer_id
ORDER BY o.amount DESC;

SELECT
    c.name,
    SUM(o.amount) AS total_spent
FROM customers AS c
INNER JOIN orders AS o
    ON c.id = o.customer_id
GROUP BY c.name;

-- Cuando un cliente no tiene pedidos, SUM() puede devolver NULL. COALESCE() permite sustituir NULL por otro valor.
SELECT
    c.name,
    COALESCE(SUM(o.amount), 0) AS total_spent
FROM customers AS c
LEFT JOIN orders AS o
    ON c.id = o.customer_id
GROUP BY c.name;

-- contar pedidos: Usamos COUNT(o.order_id) en lugar de COUNT(*) porque queremos contar únicamente pedidos. Con LEFT JOIN, COUNT(*) contaría también la fila de un cliente sin pedidos.
SELECT
    c.name,
    COUNT(o.order_id) AS number_of_orders
FROM customers AS c
LEFT JOIN orders AS o
    ON c.id = o.customer_id
GROUP BY c.name;

-- con el filtro HAVING
SELECT
    c.name,
    SUM(o.amount) AS total_spent
FROM customers AS c
INNER JOIN orders AS o
    ON c.id = o.customer_id
GROUP BY c.name
HAVING SUM(o.amount) > 100;
