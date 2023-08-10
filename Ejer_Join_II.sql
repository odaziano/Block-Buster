-- Consignas (continuación) Consultas sobre la base de datos EMarket

-- CLIENTES
-- ¿Cuántos clientes existen?
SELECT COUNT(*)
FROM clientes
WHERE ClienteID IS NOT NULL;
-- ¿Cuántos clientes hay por ciudad?
SELECT c.ciudad, COUNT(c.ciudad)
FROM clientes AS c
GROUP BY c.ciudad;
-- Comprueba
SELECT *
FROM clientes
WHERE ciudad LIKE "Buenos%";

-- FACTURAS
-- ¿Cuál es el total de transporte?
SELECT SUM(transporte) AS "Total"
FROM facturas;
-- ¿Cuál es el total de transporte por EnvioVia (empresa de envío)?
SELECT c.correoID, c.compania, SUM(transporte) AS "Total"
FROM facturas AS f
INNER JOIN correos AS c
ON f.enviovia = c.correoID
GROUP BY EnvioVia;
-- Calcular la cantidad de facturas por cliente.
-- Ordenar descendentemente por cantidad de facturas.
SELECT c.clienteID, c.compania, COUNT(facturaID)
FROM facturas AS f
INNER JOIN clientes AS c
ON f.clienteID = c.clienteID
GROUP BY f.clienteID;
-- ComPrueba
SELECT *
FROM facturas
WHERE clienteID = "ANATR";
-- Obtener el Top 5 de clientes de acuerdo a su cantidad de facturas.
SELECT c.clienteID, c.compania, COUNT(f.facturaID)
FROM facturas AS f
INNER JOIN clientes AS c
ON c.clienteID = f.clienteID
GROUP BY c.clienteID
ORDER BY COUNT(f.facturaID) DESC
LIMIT 5;
-- Comprueba
SELECT c.clienteID, c.compania, f.facturaID
FROM facturas AS f
INNER JOIN clientes AS c
ON c.clienteID = f.clienteID
WHERE f.clienteID = "QUICK";
-- ¿Cuál es el país de envío menos frecuente de acuerdo a la cantidad de facturas?
SELECT f.PaisEnvio, COUNT(f.FacturaID) AS "Total Facturas"
FROM facturas AS f
GROUP BY f.PaisEnvio
ORDER BY COUNT(f.FacturaID) ASC;
-- ComPrueba
SELECT f.paisenvio, COUNT(f.facturaID)
FROM facturas AS f
WHERE f.paisenvio = "Argentina";
-- Se quiere otorgar un bono al empleado con más ventas.
-- ¿Qué ID de empleado realizó más operaciones de ventas?
SELECT f.empleadoID, e.Apellido, e.Nombre, COUNT(f.facturaID)
FROM facturas AS f
INNER JOIN empleados AS e
ON f.EmpleadoID = e.EmpleadoID
GROUP BY f.EmpleadoID
ORDER BY COUNT(f.FacturaID) DESC;
-- ComPrueba
SELECT f.EmpleadoID, COUNT(f.facturaID)
FROM facturas AS f
WHERE f.EmpleadoID = 4;

-- FACTURA DETALLE
-- ¿Cuál es el producto que aparece en más líneas de la tabla Factura Detalle?
-- Más Líneas
SELECT fd.productoID, p.ProductoNombre, COUNT(fd.cantidad) AS 
"Cantidad de Productos con más Facturas (Líneas)"
FROM facturadetalle AS fd
INNER JOIN productos AS p
ON p.ProductoID = fd.ProductoID
GROUP BY fd.ProductoID
ORDER BY COUNT(fd.ProductoID) DESC;
-- Más Cantidad
SELECT fd.productoID, p.ProductoNombre, SUM(fd.cantidad) AS 
"Cantidad de Productos más vendidos"
FROM facturadetalle AS fd
INNER JOIN productos AS p
ON p.ProductoID = fd.ProductoID
GROUP BY fd.ProductoID
ORDER BY SUM(fd.ProductoID) DESC;
-- ¿Cuál es el total facturado?
-- Considerar que el total facturado es la suma de cantidad por precio unitario.
-- Total Facturado
SELECT SUM((PrecioUnitario*Cantidad)-Descuento) AS "Total General Facturado"
FROM facturadetalle AS fd;
-- Total x Factura
SELECT fd.FacturaID, SUM((PrecioUnitario*Cantidad)-Descuento) AS "Total x Factura"
FROM facturadetalle AS fd
GROUP BY fd.FacturaID;
-- ¿Cuál es el total facturado para los productos ID entre 30 y 50?
-- Total general productos ID entre 30 y 50
SELECT SUM((fd.PrecioUnitario*fd.Cantidad)-fd.Descuento) AS "Total ID 30 Y 50"
FROM facturadetalle AS fd
WHERE fd.ProductoID BETWEEN 30 AND 50;
-- Total x producto ID entre 30 y 50
SELECT fd.ProductoID, p.ProductoNombre, SUM((fd.PrecioUnitario*fd.Cantidad)-fd.Descuento) AS "Total x Producto"
FROM facturadetalle AS fd
INNER JOIN productos AS p
ON fd.productoID = p.productoID
WHERE fd.ProductoID BETWEEN 30 AND 50
GROUP BY fd.ProductoID
ORDER BY fd.ProductoID;
-- ¿Cuál es el precio unitario promedio de cada producto?
SELECT ProductoID, ProductoNombre, AVG(preciounitario) AS "Precio promedio x Producto"
FROM productos
GROUP BY ProductoID;
-- ¿Cuál es el precio unitario máximo?
SELECT ProductoID, ProductoNombre, MAX(preciounitario) AS "Precio Máximo"
FROM productos
GROUP BY ProductoID
ORDER BY "Precio Máximo" DESC;

-- Generar un listado de todas las facturas del empleado 'Buchanan'. 
SELECT f.facturaid, f.empleadoid, e.apellido, e.nombre
FROM facturas AS f
INNER JOIN empleados AS e
ON f.EmpleadoID = e.EmpleadoID
WHERE e.Apellido LIKE "Buchanan";

-- Generar un listado con todos los campos de las facturas del correo 'Speedy Express'.
SELECT *
FROM facturas AS f
INNER JOIN correos AS c
ON f.EnvioVia = c.CorreoID
WHERE c.compania LIKE "Speedy Express";

-- Generar un listado de todas las facturas con el nombre y apellido de los empleados.
SELECT f.facturaID, f.empleadoID, e.Apellido, e.Nombre
FROM facturas AS f
INNER JOIN Empleados AS e
ON f.EmpleadoID = e.EmpleadoID
ORDER BY e.Apellido, e.Nombre;

-- Mostrar un listado de las facturas de todos los clientes “Owner” y país de envío “USA”.
SELECT f.FacturaID, f.ClienteID, c.compania, f.PaisEnvio
FROM facturas AS f
INNER JOIN clientes AS c
ON f.ClienteID = c.ClienteID
WHERE f.PaisEnvio LIKE "%USA%";

-- Mostrar todos los campos de las facturas del empleado cuyo apellido sea “Leverling” o que incluyan el producto id = “42”.
SELECT f.FacturaID, f.EmpleadoID, e.Apellido, e.Nombre, fd.ProductoID, p.ProductoNombre
FROM facturas AS f
INNER JOIN empleados AS e
ON f.EmpleadoID = e.EmpleadoID
INNER JOIN facturadetalle AS fd
ON f.facturaID = fd.FacturaID
INNER JOIN productos AS p
ON fd.ProductoID = p.ProductoID
WHERE e.Apellido LIKE "Leverling" OR p.ProductoID = 42;

-- Mostrar todos los campos de las facturas del empleado cuyo apellido sea “Leverling” y que incluya los producto id = “80” o ”42”.
SELECT f.*, e.Apellido, e.Nombre, fd.ProductoID, p.ProductoNombre
FROM facturas AS f
INNER JOIN empleados AS e
ON f.EmpleadoID = e.EmpleadoID
INNER JOIN facturadetalle AS fd
ON f.facturaID = fd.FacturaID
INNER JOIN productos AS p
ON fd.ProductoID = p.ProductoID
WHERE e.Apellido LIKE "Leverling"  AND (p.ProductoID = 80 OR p.ProductoID = 42);
-- Comprueba (No Hay productoID 80 del vendedor Leverling

-- Generar un listado con los cinco mejores clientes, según sus importes de compras total (PrecioUnitario * Cantidad).
SELECT f.FacturaID, f.ClienteID, c.Compania, fd.PrecioUnitario, fd.Cantidad, fd.Descuento, (fd.PrecioUnitario*fd.Cantidad)-fd.Descuento AS Total
FROM facturas AS f
INNER JOIN clientes AS c
ON f.ClienteID = c.ClienteID
INNER JOIN facturadetalle AS fd
ON f.FacturaID = fd.FacturaID
ORDER BY Total DESC
LIMIT 5;

-- Generar un listado de facturas, con los campos id, nombre y apellido del cliente, fecha de factura, país de envío,
-- Total, ordenado de manera descendente por fecha de factura y limitado a 10 filas.
SELECT f.FacturaID, f.ClienteID, c.Compania, f.FechaFactura, f.PaisEnvio, SUM((fd.PrecioUnitario*fd.Cantidad)-fd.Descuento) AS Total
FROM facturas AS f
INNER JOIN clientes AS c
ON f.ClienteID = c.ClienteID
INNER JOIN facturadetalle AS fd
ON f.FacturaID = fd.FacturaID
GROUP BY f.FacturaID
ORDER BY FechaFactura DESC
LIMIT 10;