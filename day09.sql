-- Subqueries / Subconsultas
--ejercicio 1:Encuentra los clientes que tienen una edad superior a la edad media
SELECT name,
        age
FROM customers
WHERE age > (SELECT 
                AVG(age)
                FROM customers)
ORDER BY age DESC;

-- CLIENTES CON EDAD MÁXIMA, usamos MIN para la mínima
SELECT
    name,
    age
FROM customers
WHERE age = (
    SELECT MAX(age)
    FROM customers
);

--encontrar pedidos cuya compra sea mayor que la compra media de todos los pedidos
SELECT
    product,
    amount
FROM orders
WHERE amount > (
    SELECT AVG(amount)
    FROM orders
)
ORDER BY amount DESC;

--ENCONTRAR CLIENTES QUE SE HAYAN GASTADO +500 EUROS (NOT IN hace lo opuesto)
SELECT
    name
FROM customers
WHERE id IN (
    SELECT customer_id
    FROM orders
    WHERE amount > 500
);
-- subconsulta correlacionada: utiliza info de la consulta exterior en la interior
SELECT
    c.name
FROM customers AS c
WHERE (
    SELECT COALESCE(SUM(o.amount), 0)
    FROM orders AS o
    WHERE o.customer_id = c.id
) > 100;

-- EXIST Y NOT EXIST, se diferencian del IN porque el IN pregunta si su valor está dentro de esa lista y el exist pregunta si hay alguna fila que cumpla
SELECT
    c.name
FROM customers AS c
WHERE EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.id
);
SELECT
    c.name
FROM customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.id
);

-- EJERCICIO:Encuentra los clientes que hayan realizado algún pedido superior a 50 €
SELECT name,
        country
FROM customers
WHERE id IN (SELECT customer_id
            FROM orders
            WHERE amount > 50);