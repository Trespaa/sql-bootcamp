--probando el comando SELECT y FROM

SELECT name, age
    FROM customers;

--Probando SELECT y AS para renombrar (solo cambia cómo se muestra el nombre de la columna en el resultado la tabla sigue teniendo name)

SELECT name AS customer_name
FROM customers;

--Probando todo junto
SELECT name, city, country AS customer_country
    FROM customers 