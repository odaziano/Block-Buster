-- Consultas
-- SELECT, GROUP BY y JOIN

-- 1) Listar las canciones cuya duración sea mayor a 2 minutos.
SELECT *
FROM canciones
WHERE milisegundos > 120000;

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
ORDER BY compositor DESC, nombre;

-- 4) Canciones
-- 		a) Listar la cantidad de canciones de cada compositor. 
SELECT compositor, COUNT(*)
FROM canciones
GROUP BY compositor;

-- 		b) Modificar la consulta para incluir únicamente los compositores que tengan más de 10 canciones. 
SELECT compositor, COUNT(*)
FROM canciones
GROUP BY compositor
HAVING COUNT(*) >10;

-- 5) Facturas
-- 		a) Listar el total facturado agrupado por ciudad.
SELECT ciudad_de_facturacion, SUM(total)
FROM facturas
GROUP BY ciudad_de_facturacion
ORDER BY ciudad_de_facturacion ASC;

-- 		b) Modificar el listado del punto (a) mostrando únicamente las ciudades de Canadá.
SELECT ciudad_de_facturacion, SUM(total)
FROM facturas
WHERE pais_de_facturacion LIKE "Canada"
GROUP BY ciudad_de_facturacion;

-- 		c) Modificar el listado del punto (a) mostrando únicamente las ciudades con una facturación mayor a 38.
SELECT ciudad_de_facturacion, SUM(total)
FROM facturas
GROUP BY ciudad_de_facturacion
HAVING SUM(total) >38
ORDER BY ciudad_de_facturacion ASC;

-- 		d) Modificar el listado del punto (a) agrupando la facturación por país, y luego por ciudad.
SELECT pais_de_facturacion,ciudad_de_facturacion
FROM facturas
GROUP BY pais_de_facturacion,ciudad_de_facturacion
ORDER BY pais_de_facturacion;

-- 6) Canciones / Géneros
-- 		a) Listar la duración mínima, máxima y promedio de las canciones.
SELECT MIN(c.milisegundos)
FROM canciones;

SELECT nombre, MAX(c.milisegundos)
FROM canciones AS c
INNER JOIN generos AS g
ON c.id_genero = g.id;

 
-- 		b) Modificar el punto (a) mostrando la información agrupada por género.
