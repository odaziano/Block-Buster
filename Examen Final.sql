-- Examen Final - Bases de datos
-- Consultas a la Base de datos Pokemon

-- Introducción 
-- ¡Bienvenido al examen final del curso de Bases de Datos! 
-- En esta ocasión, pondrás a prueba tus habilidades en el uso de MySQL Workbench y tu capacidad para realizar consultas a una base de datos
-- en equipo. Estamos emocionados de que hayas llegado hasta aquí y estés listo para enfrentar este desafío. 

-- En esta ocasión, nos sumergimos en el emocionante mundo de Pokémon a través de una base de datos que contiene información
-- relevante sobre estas criaturas. Utilizaremos MySQL Workbench, una herramienta poderosa que te permitirá gestionar y consultar la base de datos de manera eficiente.

-- ¿Empezamos?
-- Para iniciar, necesitamos que descargues la base de datos Pokémon click aquí. Esta base se encuentra en un archivo .sql
-- que se debe importar desde MySQL Workbench. Luego, desde la pestaña “File -> Open SQL Script”, buscá y abrí el pokemon.sql que descargaste. Por último, ejecuta el script desde el ícono del rayo.

-- Cumplidos todos estos pasos, vamos a ver qué reportes nos solicitan.
-- ¡Buena suerte! 😎✨✨

-- Consignas
-- A continuación encontrarás una serie de ejercicios a resolver:

-- Where
-- 1) Mostrar el nombre, altura y peso de los Pokémon cuya altura sea menor a 0.5.
-- 		Tablas: pokemon
-- 		Campos: nombre, peso, altura


-- 2) Mostrar los nombres, descripciones, potencia y precisión de los movimientos cuya potencia esté entre 70 y 100, la precisión sea mayor a 80.
-- 		Tablas: movimiento
-- 		Campos: nombre, descripcion, potencia, precision_mov

-- Operadores & joins
-- 1) Mostrar los nombres y potencia de los movimientos que tienen una potencia entre 50 y 80, junto con el nombre del tipo al que pertenecen.
-- 		Tablas: movimiento, tipo
-- 		Campos: m.nombre, t.nombre, potencia
SELECT m.nombre, m.potencia, t.nombre
FROM movimiento AS m
INNER JOIN tipo As t
ON m.id_tipo = t.id_tipo
WHERE m.potencia BETWEEN 50 AND 80;

-- 2) Mostrar los nombre, potencia y tipo de los movimientos que tienen un tipo de ataque "Físico" y una precisión mayor a 85.
-- 		Tablas: tipo, tipo_ataque, movimiento
-- 		Campos: m.nombre, m.potencia, m.precision_mov, ta.tipo

SELECT m.nombre, m.potencia, m.precision_mov, ta.tipo
FROM movimiento AS m
INNER JOIN tipo AS t
ON m.id_tipo = t.id_tipo
INNER JOIN tipo_ataque AS ta
ON t.id_tipo_ataque = ta.id_tipo_ataque
WHERE ta.tipo = 'Físico' AND m.precision_mov > 85;

-- Order by
-- 1) Mostrar los nombres y números de Pokédex de los Pokémon en orden descendente según su número de Pokédex.
-- 		Tablas: pokemon
-- 		Campos: numero_pokedex, nombre
SELECT p.numero_pokedex, p.nombre
FROM pokemon AS p
ORDER BY p.numero_pokedex DESC;

-- 2) Mostrar numero de pokedex, nombre y altura de los Pokémon de tipo "Roca", ordenados por altura de forma ascendente.
-- 		Tablas: pokemon
-- 		Campos: numero_pokedex, nombre, altura
SELECT p.numero_pokedex, p.nombre, p.altura, t.nombre
FROM pokemon AS p
INNER JOIN pokemon_tipo AS pt
ON p.numero_pokedex = pt.numero_pokedex
INNER JOIN tipo AS t
ON t.id_tipo = pt.numero_pokedex
WHERE t.nombre = 'Roca'
ORDER BY p.altura ASC;

-- Funciones de agregación
-- 1) ¿Cuántos Pokémon tienen un promedio de defensa superior a 100?
-- 		Tablas: estadisticas_base
-- 		Campos: defensa
-- 2) ¿Cuál es la potencia promedio de todos los movimientos en la base de datos? ¿Cuáles son los valores máximos y mínimos de la potencia?
-- 		Tablas: estadisticas_base
-- 		Campos: potencia

-- Group by
-- 1) Muestra los nombres de los tipos de Pokémon junto con la velocidad promedio de los Pokémon de cada tipo.
-- 		Tablas: estadisticas_base, pokemon_tipo, tipo
-- 		Campos: t.nombre, eb.velocidad
-- 2) Muestra los nombres de los tipos de Pokémon junto con la cantidad máxima de movimientos de cualquier tipo que tienen una potencia superior a 80.
-- 		Tablas: movimiento, tipo
-- 		Campos: t.nombre, m.potencia
-- Having
-- 1) Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon de cada tipo que tienen una precisión promedio mayor a 80 en sus movimientos.
-- 		Tablas: tipo, pokemon_tipo, movimiento
-- 		Campos: t.nombre, m.precision_mov
-- 2) Muestra los nombres de los Pokémon que tienen un promedio de ataque superior a 70 y más de un tipo.
-- 		Tablas: pokemon, pokemon_tipo, estadisticas_base
-- 		Campos: p.nombre, eb.ataque, pt.id_tipo

-- Registros
-- 1) Muestra el nombre de cada Pokémon junto con su tipo y velocidad base.
-- Ordena los resultados por el nombre del Pokémon en orden descendente.
-- 		Tablas: pokemon, estadisticas_base, pokemon_tipo, tipo
-- 		Campos: p.nombre, t.nombre, eb.velocidad
SELECT p.nombre AS Nombre_Pokemon, t.nombre AS Nombre_Tipo, eb.velocidad AS Velocidad_Base
FROM pokemon AS p
INNER JOIN estadisticas_base AS eb
ON p.numero_pokedex = eb.numero_pokedex
INNER JOIN pokemon_tipo AS pt
ON p.numero_pokedex = pt.numero_pokedex
INNER JOIN tipo AS t
ON t.id_tipo = pt.numero_pokedex
ORDER BY p.nombre DESC;

-- 2) Muestra los nombres de los tipos de Pokémon junto con la cantidad de Pokémon de cada tipo
-- que tienen una velocidad promedio superior a 60 y una precisión promedio mayor a 85 en sus movimientos.
-- 		Tablas: movimiento, tipo_ataque, pokemon_tipo, tipo, pokemon, estadisticas_base
-- 		Campos: p.nombre
SELECT p.nombre AS Nombre_Pokemon, AVG(eb.velocidad) AS Prom_Velocidad, AVG(m.precision_mov) AS Prom_Pres_Mov, COUNT(*) Ca_x_Poq_x_Tipo
FROM pokemon AS p
INNER JOIN pokemon_tipo AS pt
ON p.numero_pokedex = pt.numero_pokedex
INNER JOIN tipo AS t
ON t.id_tipo = pt.numero_pokedex
INNER JOIN movimiento AS m
ON m.id_tipo = t.id_tipo
INNER JOIN tipo_ataque AS ta
ON t.id_tipo_ataque = ta.id_tipo_ataque
INNER JOIN estadisticas_base AS eb
ON p.numero_pokedex = eb.numero_pokedex
GROUP BY p.nombre
HAVING AVG(eb.velocidad) > 60 AND AVG(m.precision_mov) >85;

-- 3) Muestra los nombres de los movimientos de tipo "Fuego" junto con los nombres de los Pokémon que pueden aprenderlos y el promedio de su altura. Solo incluye los movimientos con una potencia promedio mayor a 50.
-- 		Tablas: movimiento, tipo_ataque, pokemon_tipo, tipo, pokemon
-- 		Campos: m.nombre, p.nombre, p.altura
