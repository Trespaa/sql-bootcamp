-- EFICIENCIA
-- índices


-- índice compuesto
--CREATE INDEX idx_customer_date
--ON orders(customer_id, order_date);

SELECT
    indexname,
    indexdef
FROM pg_indexes
WHERE tablename = 'orders';


-- Ahora podemos investigar cómo PostgreSQL ejecuta una consulta
EXPLAIN
SELECT *
FROM orders
WHERE customer_id = 1;

EXPLAIN ANALYZE
SELECT *
FROM orders
WHERE customer_id = 1;

-- comandos:
--Seq Scan
--Index Scan
--Sort
--Hash Join
--Nested Loop
--Aggregate