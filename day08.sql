-- GROUP BY + HAVING avanzado
SELECT
    country,
    city,
    COUNT(*) AS total_customers
FROM customers
GROUP BY country, city;

SELECT
    country,
    COUNT(*) AS total_customers
FROM customers
GROUP BY country
HAVING COUNT(*) > 1;

-- WHERE vs HAVING: Where filtra antes de agrupar (group by) y having lo hace después


-- ventas por paises incluyendo los que no han comprado
SELECT
    c.country,
    COALESCE(SUM(o.amount), 0) AS total_revenue
FROM customers AS c
LEFT JOIN orders AS o
    ON c.id = o.customer_id
GROUP BY c.country
ORDER BY total_revenue DESC;

-- EJERCICIO:Queremos un informe por país que muestre: país,número de clientes, 
-- número de pedidos, ingresos totales, gasto medio por pedido

SELECT 
    c.country, -- muestra el país
    COUNT(DISTINCT c.id) AS total_customer, --si cogemos solo el c.id, contaría a un cliente que haya hecho varias compras varias veces en vez de solo 1.
    COUNT(o.order_id) AS total_order, -- muestra el número de pedidos
    COALESCE(SUM(o.amount), 0) AS total_revenue, -- ingresos totales incluyendo el 0.ADD
    COALESCE(ROUND(AVG(o.amount), 2), 0) AS averga_order --gasto medio con 2 decimales
FROM customers AS c
LEFT JOIN orders AS o 
    ON c.id = o.customer_id
GROUP BY country
HAVING COUNT(DISTINCT c.id) < 4
ORDER BY total_revenue DESC;
