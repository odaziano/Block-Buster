-- 1) Utilizando la base de datos de movies, queremos conocer, por un lado, 
-- los títulos y el nombre del género de todas las series de la base de datos.
SELECT s.title, g.name
FROM series AS s
INNER JOIN genres AS g
ON s.genre_id = g.id;

-- 2) Por otro, necesitamos listar los títulos de los episodios junto con 
-- el nombre y apellido de los actores que trabajan en cada uno de ellos.
SELECT e.title, ae.episode_id, a.first_name, a.last_name
FROM episodes AS e
INNER JOIN actor_episode AS ae
ON e.id = ae.episode_id
INNER JOIN actors AS a
ON ae.actor_id = actor_id;

-- 3) Para nuestro próximo desafío, necesitamos obtener a todos los actores o actrices
-- (mostrar nombre y apellido) que han trabajado en cualquier película de la saga de La Guerra de las galaxias.
SELECT a.first_name, a.last_name, m.title
FROM actors AS a
INNER JOIN actor_movie AS am
ON a.id = am.actor_id
INNER JOIN movies AS m
ON m.id = am.actor_id
WHERE m.title LIKE "%La Guerra%";
-- ComPrueba
SELECT * FROM movies
WHERE title LIKE "%Guerra%";

-- 4) Crear un listado a partir de la tabla de películas, mostrar un reporte de la 
-- cantidad de películas por nombre de género.
SELECT g.id AS "ID Género", g.name AS "Nombre Género", COUNT(m.genre_id) AS "Cant_Pelic"
FROM movies AS m
INNER JOIN genres AS g
ON m.genre_id = g.id
GROUP BY m.genre_id;
-- ComPrueba
SELECT *
FROM movies
WHERE genre_id=10 ;
