-- Consultas
-- SELECT, GROUP BY y JOIN

-- 1) Listar las canciones cuya duración sea mayor a 2 minutos.
SELECT id, nombre, milisegundos/60000 AS Minutos
FROM canciones
WHERE milisegundos/60000 > 2;

-- 2) Listar las canciones cuyo nombre comience con una vocal. 
SELECT *
FROM canciones
WHERE LEFT(nombre,1) IN ('A','E','I','O','U')
ORDER BY nombre;

SELECT *
FROM canciones
WHERE nombre LIKE "A%" OR nombre LIKE "E%" OR nombre LIKE "I%" OR nombre LIKE "O%" OR nombre LIKE "U%"
ORDER BY nombre;

-- 3) Listar las canciones ordenadas por compositor en forma descendente. Luego, por nombre en forma ascendente.
-- Incluir únicamente aquellas canciones que tengan compositor. 
SELECT id, nombre, compositor
FROM canciones
WHERE compositor != ""
ORDER BY compositor DESC, nombre ASC;

-- 4) Canciones
-- 		a) Listar la cantidad de canciones de cada compositor. 
SELECT compositor, COUNT(*)
FROM canciones
WHERE compositor != ""
GROUP BY compositor
ORDER BY compositor ASC;

-- 		b) Modificar la consulta para incluir únicamente los compositores que tengan más de 10 canciones. 
SELECT compositor, COUNT(*)
FROM canciones
WHERE compositor != ""
GROUP BY compositor
HAVING COUNT(*) >10
ORDER BY COUNT(*) DESC;

-- 5) Facturas
-- 		a) Listar el total facturado agrupado por ciudad.
SELECT ciudad_de_facturacion, SUM(total)
FROM facturas
GROUP BY ciudad_de_facturacion
ORDER BY ciudad_de_facturacion ASC;

-- 		b) Modificar el listado del punto (a) mostrando únicamente las ciudades de Canadá.
SELECT ciudad_de_facturacion, pais_de_facturacion,  SUM(total)
FROM facturas
WHERE pais_de_facturacion LIKE "Canada"
GROUP BY ciudad_de_facturacion, pais_de_facturacion
ORDER BY ciudad_de_facturacion ASC;

-- 		c) Modificar el listado del punto (a) mostrando únicamente las ciudades con una facturación mayor a 38.
SELECT ciudad_de_facturacion, pais_de_facturacion, SUM(total) AS "Factura+38"
FROM facturas
GROUP BY ciudad_de_facturacion, pais_de_facturacion
HAVING SUM(total) >38
ORDER BY pais_de_facturacion, ciudad_de_facturacion ASC;

-- 		d) Modificar el listado del punto (a) agrupando la facturación por país, y luego por ciudad.
SELECT pais_de_facturacion, ciudad_de_facturacion, SUM(total)
FROM facturas
GROUP BY pais_de_facturacion, ciudad_de_facturacion
ORDER BY pais_de_facturacion, ciudad_de_facturacion ASC;

-- 6) Canciones / Géneros
-- 		a) Listar la duración mínima, máxima y promedio de las canciones.
SELECT MIN(c.milisegundos) AS "Mínima", MAX(c.milisegundos) AS "Máxima", AVG(c.milisegundos) AS "Promedio"
FROM canciones AS c;
 
-- 		b) Modificar el punto (a) mostrando la información agrupada por género.
SELECT c.id_genero, g.nombre, MIN(c.milisegundos) AS "Mínima", MAX(c.milisegundos) AS "Máxima", AVG(c.milisegundos) AS "Promedio"
FROM canciones AS c
INNER JOIN generos AS g
ON c.id_genero = g.id
GROUP BY c.id_genero;