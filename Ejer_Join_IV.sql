-- Reportes
-- Reportes parte 1:

-- 1) Obtener el nombre y apellido de los primeros 5 actores disponibles.
--  Utilizar alias para mostrar los nombres de las columnas en español.
select actor_id AS "Identificador",first_name AS "Nombre",last_name AS "Apellido"
FROM actor
WHERE actor_id BETWEEN 1 AND 5;

-- 2) Obtener un listado que incluya nombre, apellido y correo electrónico de los clientes (customers) inactivos.
-- Utilizar alias para mostrar los nombres de las columnas en español.
SELECT first_name AS "Nombre" , last_name AS "Apellido", active AS "Activo"
FROM customer
WHERE active = 0;

-- 3) Obtener un listado de films incluyendo título, año y descripción de los films que tienen un rental_duration mayor a cinco.
-- Ordenar por rental_duration de mayor a menor. Utilizar alias para mostrar los nombres de las columnas en español.
SELECT title AS "Título", release_year AS "Año", special_features AS "Descripción", rental_duration AS "Duración"
FROM film
WHERE rental_duration > 5;

-- 4) Obtener un listado de alquileres (rentals) que se hicieron durante el mes de mayo de 2005, 
-- incluir en el resultado todas las columnas disponibles.
SELECT *
FROM rental
WHERE MONTH(rental_date)= 05 AND YEAR(rental_date)= 2005;

-- Reportes parte 2: Sumemos complejidad
-- Si llegamos hasta acá, tenemos en claro la estructura básica de un SELECT. En los siguientes reportes vamos a sumar complejidad.
-- ¿Probamos?

-- 1) Obtener la cantidad TOTAL de alquileres (rentals). Utilizar un alias para mostrarlo en una columna llamada “cantidad”.
SELECT COUNT(rental_id) AS "Cantidad"
FROM rental;

-- 2) Obtener la suma TOTAL de todos los pagos (payments).
-- Utilizar un alias para mostrarlo en una columna llamada total,
-- junto a una columna con la cantidad de alquileres con el alias Cantidad y una columna que indique el Importe promedio por alquiler.
SELECT COUNT(payment_id) AS "Cantidad", ROUND(AVG(amount),2) AS "Imp.Promedio", SUM(amount) AS "Total"
FROM payment;

-- 3) Generar un reporte que responda la pregunta: ¿cuáles son los diez clientes que más dinero gastan y en cuántos alquileres lo hacen?
SELECT p.customer_id, c.first_name, c.last_name, SUM(p.amount) AS Monto, COUNT(p.rental_id) AS Cantidad
FROM payment AS P
INNER JOIN customer AS c
ON p.customer_id = c.customer_id
GROUP BY p.customer_id
ORDER BY Monto DESC
LIMIT 10;

-- 4) Generar un reporte que indique: ID de cliente, cantidad de alquileres y monto total
--  para todos los clientes que hayan gastado más de 150 dólares en alquileres.
SELECT rental.customer_id, CONCAT(customer.first_name,', ' ,customer.last_name) AS Cliente, 
COUNT(rental.rental_id) AS CaAlq, SUM(payment.amount) AS Gasto_Mas_150
FROM rental
INNER JOIN payment
ON rental.rental_id = payment.rental_id
INNER JOIN customer
ON rental.customer_id = customer.customer_id
GROUP BY rental.customer_id
HAVING Gasto_Mas_150 >= 150
ORDER BY Gasto_Mas_150 DESC;

 -- 5) Generar un reporte que muestre por mes de alquiler (rental_date de tabla rental),
 -- la cantidad de alquileres y la suma total pagada (amount de tabla payment)
 -- para el año de alquiler 2005 (rental_date de tabla rental).
SET lc_time_names = 'es_ES';
SELECT MONTHNAME(rental.rental_date) AS Mes, YEAR(rental.rental_date) AS Anio, 
FORMAT(COUNT(rental.rental_id),0,'es_ES') AS CaAlq, 
FORMAT(SUM(payment.amount),2,'es_ES') AS Total
FROM rental
INNER JOIN payment
ON rental.rental_id = payment.rental_id
WHERE YEAR(rental.rental_date) ='2005'
GROUP BY Mes, Anio;
 
 -- ComPrueba
SELECT COUNT(rental_id)
FROM rental
WHERE MONTH(rental_date)='06' AND YEAR(rental_date) = '2005';

-- 6) Generar un reporte que responda a la pregunta: 
-- ¿cuáles son los 5 inventarios más alquilados? (columna inventory_id en la tabla rental).
-- Para cada una de ellas indicar la cantidad de alquileres.
SELECT rental.inventory_id, inventory.film_id, film.title, COUNT(rental.rental_id) AS CaAlq
FROM rental
INNER JOIN inventory
ON rental.inventory_id = inventory.inventory_id
INNER JOIN film
ON inventory.inventory_id = film.film_id
GROUP BY rental.inventory_id
ORDER BY CaAlq DESC
LIMIT 5;

-- ComPrueba
SELECT *
FROM rental
WHERE inventory_id = 14




