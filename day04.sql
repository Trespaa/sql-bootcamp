-- CASE es como un if else. Tanto CASE como FILTER van antes que FROM
SELECT name, age,
    CASE
    WHEN age < 25 THEN 'young_clients'
    WHEN age > 25 THEN 'old clients'
    END AS age_group
FROM customers;


SELECT name, age,
    CASE
    WHEN age < 25 THEN 'young'
    WHEN age > 30 THEN 'OLD'
    ELSE 'MIDDLE'
    END AS age_group
FROM customers;

SELECT name, country,
    CASE
    WHEN country in ('Spain', 'UK', 'France') THEN 'EUROPA'
    ELSE 'OTHER'
    END AS continent
FROM customers;

SELECT
    COUNT(CASE 
        WHEN age > 30 THEN 1 
        ELSE 0 
    END) AS old_count
FROM customers;

-- TAMBIEN VALE FILTER, siempre va con WHERE
SELECT 
    COUNT(*) FILTER (WHERE age > 30) AS old_count
    FROM customers;

SELECT
    COUNT(*) FILTER (WHERE age < 25) AS young_customers,
    COUNT(*) FILTER (WHERE age BETWEEN 25 AND 30) AS middle_customers,
    COUNT(*) FILTER (WHERE age > 30) AS senior_customers
FROM customers;

-- Para ordenar y agrupar
SELECT
    CASE
        WHEN age < 25 THEN 'Young'
        WHEN age <= 30 THEN 'Middle'
        ELSE 'Senior'
    END AS age_group,
    COUNT(*) AS number_of_customers
FROM customers
GROUP BY
    CASE
        WHEN age < 25 THEN 'Young'
        WHEN age <= 30 THEN 'Middle'
        ELSE 'Senior'
    END;

SELECT
    name,
    age,
    CASE
        WHEN age > 30 THEN 'Senior'
        ELSE 'Other'
    END AS category
FROM customers
ORDER BY
    CASE
        WHEN age > 30 THEN 1
        ELSE 2
    END;

-- MINI EJERCICIO 
SELECT 
    name, 
    country, 
    age,
    CASE
        WHEN age < 25 THEN 'young'
        WHEN age > 30 THEN 'senior'
        ELSE 'adult'
    END AS age_group,
    
    CASE
        WHEN country = 'Spain' THEN 'Spain'
        WHEN country = 'France' THEN 'France'
        WHEN country = 'UK' THEN 'UK'
    END AS country_group
FROM customers;