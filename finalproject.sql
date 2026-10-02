-- INFORME DE CLIENTES
WITH customer_sales AS (
    SELECT
        c.id,
        c.name,
        c.country,
        COUNT(o.order_id) AS total_orders,
        COALESCE(SUM(o.amount), 0) AS total_spent,
        COALESCE(ROUND(AVG(o.amount), 2), 0) AS average_order
    FROM customers AS c
    LEFT JOIN orders AS o
        ON c.id = o.customer_id
    GROUP BY c.id, c.name, c.country
),
customer_analysis AS (
    SELECT
        *,
        RANK() OVER (
            ORDER BY total_spent DESC
        ) AS ranking,
        CASE
            WHEN total_orders = 0 THEN 'Inactive'
            WHEN total_orders = 1 THEN 'Occasional'
            ELSE 'Frequent'
        END AS customer_type
    FROM customer_sales
)
SELECT *
FROM customer_analysis
ORDER BY ranking;


-- INFORME MENSUAL
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(amount) AS revenue
    FROM orders
    GROUP BY 1
)
SELECT
    month,
    revenue,
    LAG(revenue) OVER (
        ORDER BY month
    ) AS previous_month,
    revenue - LAG(revenue) OVER (
        ORDER BY month
    ) AS difference,
    SUM(revenue) OVER (
        ORDER BY month
    ) AS cumulative_revenue
FROM monthly_sales
ORDER BY month;

-- INFORME DE PRODUCTOS
WITH product_sales AS (
    SELECT
        product,
        COUNT(*) AS total_orders,
        SUM(amount) AS revenue
    FROM orders
    GROUP BY product
)
SELECT
    product,
    total_orders,
    revenue,
    RANK() OVER (
        ORDER BY revenue DESC
    ) AS ranking
FROM product_sales
ORDER BY ranking;