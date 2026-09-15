-- utilizamos COUNT() cuenta registros y AS renombra
SELECT COUNT(*) AS NUMBER_OF_CUSTOMERS
    FROM customers;

-- Calcula la edad media de los clientes de España.
SELECT AVG(age) AS average_age
    FROM customers
    WHERE country = 'Spain';

-- para obtener el valor mínimo y máximo. MIN() y MAX() y AVG()
SELECT  COUNT(*) AS number_of_clients,
        MIN(age) AS youngest, 
        MAX(age) AS oldest, 
        AVG(age) AS average
    FROM customers;

-- GROPU BY agrupa por alguna característica
SELECT country, AVG(age) AS average_age
    FROM customers
    GROUP BY country;

-- Calcula cuántos clientes hay en cada país.

SELECT country, COUNT(*) AS number_of_customers
    FROM customers
    GROUP BY country;

--Calcula la edad media de los clientes de cada país con más de 2 clientes
SELECT country, AVG(age) AS edad_media_cliente
    FROM customers
    GROUP BY country
    HAVING COUNT(*)>2;

-- Calcula la edad media por país, pero muestra solamente los países cuya edad media sea superior a 25 años.
SELECT country, AVG(age) AS edad_media_cliente
    FROM customers
    GROUP BY country
    HAVING AVG(age)>25;

--Queremos saber qué países tienen más de 1 cliente y cuál es la edad media de esos clientes.
SELECT  country, 
        AVG(age) AS edad_media_cliente, 
        COUNT(*) AS numero_clientes
    FROM customers
    GROUP BY country
    HAVING COUNT(*)>1;