-- funciones de texto
SELECT
    name,
    UPPER(name) AS name_upper
FROM customers;
SELECT
    name,
    LOWER(name) AS name_lower
FROM customers;
SELECT
    name,
    LENGTH(name) AS name_length
FROM customers;
SELECT
    CONCAT(name, ' - ', city) AS customer_location
FROM customers;
SELECT
    name,
    SUBSTRING(name FROM 1 FOR 3) AS first_three
FROM customers;

SELECT
    name,
    LEFT(name, 2) AS first_two
FROM customers;
SELECT
    TRIM(name) AS clean_name
FROM customers;

SELECT
    country,
    REPLACE(country, 'Spain', 'España') AS new_country
FROM customers;
SELECT
    INITCAP('juan perez') AS formatted_name;

SELECT
    name,
    UPPER(LEFT(name, 3)) AS code
FROM customers;
SELECT
    UPPER(name) || ' - ' || UPPER(country) AS customer_label
FROM customers;

-- UPPER(name) || ' - ' || UPPER(country) también concatena