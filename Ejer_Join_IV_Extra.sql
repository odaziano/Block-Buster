-- Ejercitación consultas - Bases de datos Desafio extra - Join
-- Consignas:

-- 1) Obtener los artistas que han actuado en una o más películas.
SELECT a.id, a.apellido, a.nombre, COUNT(axp.pelicula_id) AS CaPeli
FROM artista_x_pelicula AS axp
INNER JOIN artista AS a
ON axp.artista_id = a.id
GROUP BY axp.artista_id
HAVING CaPeli >= 1;

-- 2) Obtener las películas donde han participado más de un artista según nuestra base de datos. 
SELECT p.id AS Id_Pelicula, p.titulo, p.anio, COUNT(a.id) AS CaArti
FROM pelicula AS p
INNER JOIN artista_x_pelicula AS axp
ON p.id = axp.pelicula_id
INNER JOIN artista AS a
ON axp.artista_id = a.id
GROUP BY p.id
HAVING CaArti >1;

-- 3) Obtener aquellos artistas que han actuado en alguna película, incluso aquellos que aún no lo han hecho,
-- según nuestra base de datos.
SELECT a.id AS ID_Artista, CONCAT(TRIM(a.apellido),', ',TRIM(a.nombre)) AS 'Apellido y Nombre', 
COALESCE(p.id,'Sin Datos') AS ID_Pelicula, COALESCE(p.titulo,'Sin Datos') AS 'Título', 
COALESCE(p.anio,'Sin Datos') AS 'Año'
FROM artista AS a
LEFT JOIN artista_x_pelicula AS axp
ON a.id = axp.artista_id
LEFT JOIN pelicula AS p
ON axp.pelicula_id = p.id;

-- 4) Obtener las películas que no se le han asignado artistas en nuestra base de datos.
SELECT p.id AS ID_Película, p.titulo AS Título, p.anio AS Año, axp.artista_id AS ID_Artista,
CONCAT(TRIM(a.apellido),', ',TRIM(a.nombre)) AS 'Apellido y Nombre'
FROM pelicula AS p
LEFT JOIN artista_x_pelicula AS axp
ON p.id = axp.pelicula_id
LEFT JOIN artista AS a
ON axp.artista_id = a.id
HAVING ID_Artista IS NULL;

-- 5) Obtener aquellos artistas que no han actuado en alguna película, según nuestra base de datos.
SELECT a.id AS ID_Artista, CONCAT(TRIM(a.apellido),', ',TRIM(a.nombre)) AS 'Apellido y Nombre', 
axp.pelicula_id AS ID_Película
FROM artista AS a
LEFT JOIN artista_x_pelicula AS axp
ON a.id = axp.artista_id
HAVING ID_Película IS NULL;

-- 6) Obtener aquellos artistas que han actuado en dos o más películas según nuestra base de datos.
SELECT a.id, a.apellido, a.nombre, COUNT(axp.pelicula_id) AS CaPeli
FROM artista_x_pelicula AS axp
INNER JOIN artista AS a
ON axp.artista_id = a.id
GROUP BY axp.artista_id
HAVING CaPeli >= 2;

-- 7) Obtener aquellas películas que tengan asignado uno o más artistas, incluso aquellas que aún no le han asignado un artista en nuestra base de datos.
SELECT p.id AS ID_Película, p.titulo AS Título, p.anio AS Año, axp.artista_id AS ID_Artista,
CONCAT(TRIM(a.apellido),', ',TRIM(a.nombre)) AS 'Apellido y Nombre'
FROM pelicula AS p
LEFT JOIN artista_x_pelicula AS axp
ON p.id = axp.pelicula_id
LEFT JOIN artista AS a
ON axp.artista_id = a.id
HAVING ID_Artista IS NOT NULL
ORDER BY ID_Película;
