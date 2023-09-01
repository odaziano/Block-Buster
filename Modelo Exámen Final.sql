-- Modelo de Examen Final - Bases de datos
-- Consultas a la Base de datos Pokemon

-- Introducción 
-- ¡Bienvenido al modelo del examen final del curso de Bases de Datos! 
-- En esta ocasión, pondrás a prueba tus habilidades en el uso de MySQL Workbench y tu capacidad para realizar consultas
-- a una base de datos en equipo. Estamos emocionados de que hayas llegado hasta aquí y estés listo para enfrentar este desafío. 

-- En esta ocasión, nos sumergimos en el emocionante mundo de Pokémon a través de una base de datos que contiene información relevante
-- sobre estas criaturas. Utilizaremos MySQL Workbench, una herramienta poderosa que te permitirá gestionar y consultar la base de datos
-- de manera eficiente.

-- ¿Empezamos?
-- Para iniciar, necesitamos que descargues la base de datos Pokémon click aquí. Esta base se encuentra en un archivo .sql que se debe importar desde MySQL Workbench. Luego, desde la pestaña “File -> Open SQL Script”, buscá y abrí el pokemon.sql que descargaste. Por último, ejecuta el script desde el ícono del rayo.

-- Consignas
-- A continuación encontrarás una serie de ejercicios para practicar:

-- Where

-- 1) Mostrar el nombre, peso y altura de los pokémon cuyo peso sea mayor a 150.
-- 		Tablas: pokemon
-- 		Campos: nombre, peso, altura
SELECT nombre, peso, altura
FROM pokemon
WHERE peso > 150;

-- 2) Muestra los nombres y potencias de los movimientos que tienen una precisión mayor o igual a 90.
-- 		Tablas: movimiento, tipo
-- 		Campos: m.nombre, t.nombre, potencia
SELECT m.nombre, t.nombre, m.potencia
FROM movimiento AS m
INNER JOIN tipo AS t
ON m.id_tipo = t.id_tipo
WHERE m.precision_mov >= 90;


-- Operadores & joins

-- 1) Mostrar tipo, nombre y potencia de los movimientos que tienen mayor igual que 120.
-- 		Tablas: movimiento, tipo
-- 		Campos: m.nombre, t.nombre, potencia
SELECT m.nombre, t.nombre, m.potencia
FROM movimiento AS m
INNER JOIN tipo AS t
ON m.id_tipo = t.id_tipo
WHERE m.potencia >= 120;

-- 2) Muestra los nombres de los tipos de Pokémon junto con sus tipos de ataque correspondientes de aquellos cuya potencia sea igual a 0.
-- 		Tablas: tipo, tipo_ataque
-- 		Campos: t.nombre ta.tipo
SELECT t.nombre, ta.tipo, m.potencia
FROM tipo AS t
INNER JOIN tipo_ataque AS ta
ON t.id_tipo_ataque = ta.id_tipo_ataque
INNER JOIN movimiento AS m
ON t.id_tipo = m.id_tipo
WHERE m.potencia = 0;

-- Order by

-- 1) Muestra los nombres y números de Pokédex de los primeros 10 Pokémon en orden alfabético.
-- 		Tablas: pokemon
-- 		Campos: numero_pokedex, nombre
SELECT numero_pokedex, nombre
FROM pokemon
ORDER BY nombre ASC
LIMIT 10;

-- 2) Muestra los nombres y alturas de los Pokémon de tipo "Eléctrico", ordenados por altura de forma descendente.
-- 		Tablas: pokemon, pokemon_tipo, tipo
-- 		Campos: nombre, altura
SELECT p.nombre, p.altura, t.nombre
FROM pokemon AS p
INNER JOIN pokemon_tipo AS pt
ON p.numero_pokedex = pt.numero_pokedex
INNER JOIN tipo AS t
ON t.id_tipo = pt.id_tipo
HAVING t.nombre = "Electrico"
ORDER BY p.altura DESC;

-- Funciones de agregación

-- 1) ¿Cuál es la suma total de los valores de "Defensa" en todas las estadísticas base?
-- 		Tablas: estadisticas_base
-- 		Campos: defensa
SELECT SUM(defensa)
FROM estadisticas_base;

-- 2) ¿Cuántos Pokémon tienen el tipo "Fuego"?
-- 		Tablas: pokemon_tipo, tipo
-- 		Campos: *
SELECT COUNT(*)
FROM pokemon_tipo AS pt
INNER JOIN tipo AS t
ON pt.id_tipo = t.id_tipo
WHERE t.nombre = 'Fuego';

-- Group by

-- 1) Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon de cada tipo.
-- 		Tablas: pokemon_tipo, tipo
-- 		Campos: nombre, numero_pokedex
SELECT t.nombre AS "Nombre Tipo", COUNT(t.id_tipo) AS 'Ca_x_tipo'
FROM tipo AS t
INNER JOIN pokemon_tipo AS pt
ON t.id_tipo = pt.id_tipo
GROUP BY t.id_tipo;

-- 2) Muestra los nombres de los movimientos de tipo "Fuego" junto con la cantidad total de movimientos 
-- de tipo "Fuego".
-- 		Tablas: movimiento, tipo_ataque
-- 		Campos: nombre, *
SELECT m.nombre AS Movimiento_Nombre, COUNT(t.nombre) AS Ca_Tipo_Nombre_Fuego
FROM movimiento AS m
INNER JOIN tipo AS t
ON m.id_tipo = t.id_tipo
WHERE t.nombre = "Fuego"
GROUP BY Movimiento_Nombre;

-- Otra interpretación, ya que campo tipo_ataque pertenece a otra tabla
SELECT m.nombre AS Movimiento_Nombre, t.nombre AS Tipo_Nombre, ta.tipo AS Tipo_Ataque
FROM movimiento AS m
INNER JOIN tipo AS t
ON m.id_tipo = t.id_tipo
INNER JOIN tipo_ataque ta
ON t.id_tipo_ataque = ta.id_tipo_ataque
WHERE t.nombre = "Fuego";

-- Having
-- 1) Muestra los nombres de los Pokémon que tienen más de un tipo.
-- 		Tablas: pokemon, pokemon_tipo
-- 		Campos: nombre
SELECT p.nombre, COUNT(pt.id_tipo) AS Ca_x_tipo
FROM pokemon AS p
INNER JOIN pokemon_tipo AS pt
ON p.numero_pokedex = pt.numero_pokedex
GROUP BY p.nombre
HAVING Ca_x_tipo> 1;

-- 2) Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon de cada tipo que 
-- tienen un peso promedio mayor a 10.
-- 		Tablas: pokemon, pokemon_tipo, tipo
-- 		Campos: nombre, numero_pokedex
SELECT t.nombre, COUNT(p.numero_pokedex) AS Ca_x_ti_pok, 
FORMAT(AVG(p.peso),4,'es = ES') AS Prom_Peso
FROM pokemon AS p
INNER JOIN pokemon_tipo AS pt
ON p.numero_pokedex = pt.numero_pokedex
INNER JOIN tipo AS t
ON pt.id_tipo = t.id_tipo
GROUP BY t.nombre
HAVING Prom_Peso > 10;

-- Funciones de alteración

-- 1) Muestra los nombres de los movimientos de tipo de ataque "Especial" con una potencia superior a 10 
-- y una descripción que contenga al menos 20 palabras.
-- 		Tablas: movimiento, tipo_ataque
-- 		Campos: nombre, potencia, tipo, descripcion
-- 		A* OPCIÓN CAMPO DESCRIPCIÓN CON 20 PALABRAS O MÁS
SELECT m.nombre, m.potencia, ta.tipo, m.descripcion AS Descrip_Igual_o_Mayor_20_Palabras
FROM movimiento AS m
INNER JOIN tipo AS t
ON m.id_tipo = t.id_tipo
INNER JOIN tipo_ataque AS ta
ON t.id_tipo_ataque = ta.id_tipo_ataque
WHERE ta.tipo ='Especial' AND m.potencia > 10 AND 
LENGTH(TRIM(m.descripcion)) - LENGTH(REPLACE(m.descripcion, " ", "")) + 1 >=20;

-- Comprueba
SELECT m.descripcion, length(TRIM(m.descripcion)) - LENGTH(REPLACE(descripcion, " ", "")) + 1 AS Palabras
FROM movimiento AS m;

-- 		B* OPCIÓN CAMPO DESCRIPCIÓN CON 20 CARATERES O MÁS
SELECT m.nombre, m.potencia, ta.tipo, m.descripcion AS Descrip_Igual_o_Mayor_20_Carateres
FROM movimiento AS m
INNER JOIN tipo AS t
ON m.id_tipo = t.id_tipo
INNER JOIN tipo_ataque AS ta
ON t.id_tipo_ataque = ta.id_tipo_ataque
WHERE ta.tipo ='Especial' AND m.potencia > 10 AND
LENGTH(m.descripcion) >=20;

-- 2) Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon de cada tipo
-- que tienen una velocidad promedio superior a 80.
-- Solo incluye tipos que tienen al menos 3 Pokémon con esas características.
-- 		Tablas: tipo, pokemon_tipo, estadisticas_base
-- 		Campos: t.nombre, *
SELECT t.nombre, COUNT(*) AS Ca_x_tipo
FROM tipo AS t
INNER JOIN pokemon_tipo AS pt
ON t.id_tipo = pt.id_tipo
INNER JOIN estadisticas_base AS eb
ON pt.numero_pokedex = eb.numero_pokedex
WHERE eb.velocidad > 80
GROUP BY t.nombre
HAVING Ca_x_tipo >= 3
ORDER BY Ca_x_tipo DESC;

-- Registros

-- 1) Muestra el nombre de cada Pokémon junto con su tipo, velocidad base y puntos de salud (PS) base.
-- Ordena los resultados por la velocidad base de forma descendente.
-- 		Tablas: pokemon, estadisticas_base, pokemon_tipo, tipo
-- 		Campos: p.nombre, t.nombre, eb.velocidad, eb.ps
SELECT p.nombre, t.nombre, eb.velocidad, eb.ps AS Puntos_Salud
FROM pokemon AS p
INNER JOIN estadisticas_base AS eb
ON p.numero_pokedex = eb.numero_pokedex
INNER JOIN pokemon_tipo AS pt
ON eb.numero_pokedex = pt.numero_pokedex
INNER JOIN tipo AS t
ON t.id_tipo = pt.id_tipo
ORDER BY eb.velocidad DESC;

-- 2) Muestra los nombres de los movimientos de tipo "Agua"
-- junto con los nombres de los Pokémon que pueden aprenderlos y el peso promedio de estos Pokémon.
-- 		Tablas: movimiento, tipo_ataque, pokemon_tipo, tipo, pokemon
-- 		Campos: m.nombre, p.nombre, peso
SELECT DISTINCT m.nombre AS Nombre_Movimiento, p.nombre AS Pokemon_Nombre, p.peso, t.nombre AS Nombre_Tipo
FROM movimiento AS m
INNER JOIN tipo AS t
ON m.id_tipo = t.id_tipo
INNER JOIN pokemon_tipo AS pt
ON pt.id_tipo = t.id_tipo
INNER JOIN pokemon AS p
ON p.numero_pokedex = p.numero_pokedex
WHERE t.nombre = 'Agua';