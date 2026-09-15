-- filtrando busqueda con el comando WHERE con palabras
SELECT *
    FROM customers
    WHERE country = 'Spain';

-- filtrando busqueda con el comando WHERE con condiciones IN- OR - AND
SELECT *
    FROM customers
    WHERE age = 31
    OR age =24;

 SELECT *
    FROM customers
    WHERE age in (31, 24, 22);

SELECT *
    FROM customers
    WHERE country = 'Spain'
    AND age > 25;

SELECT *
    FROM customers
    WHERE country IN ('Spain', 'France', 'UK');

-- filtrando busqueda con el comando WHERE con condiciones BETWEEN y LIKE(busca palabras que empiecen por x letra)
SELECT *
    FROM customers
    Where age BETWEEN 20 and 30;

SELECT *
    FROM customers
    Where name LIKE 'A%'; -- % indica cualquier número caracteres posterior a A, depende donde coloquemos el/los % hace una cosa u otra (A%, %A% o %A)

-- ordena la lista con el comando ORDER BY y solo nos da los 3 primeros con LIMIT
SELECT *
    FROM customers
    ORDER BY age DESC
    LIMIT 3;

-- EJERCICIO busca los 2 clientes más jóvenes de España
SELECT *
    FROM customers
    WHERE country = 'Spain'
    ORDER BY age ASC
    LIMIT 2