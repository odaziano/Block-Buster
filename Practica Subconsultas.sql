-- Subconsulta como Expresión
-- Máximo precio unitario
SELECT MAX(PrecioUnitario)
FROM emarket.facturadetalle;
-- Obtenemos de la Factura 10249 la diferencia que hay entre el PU de c/ prod. con el PU MAX de la tabla
SELECT FacturaID, ProductoID, PrecioUnitario, Cantidad, 
PrecioUnitario-(SELECT MAX(PrecioUnitario) FROM emarket.facturadetalle) AS diferencia
FROM emarket.facturadetalle
WHERE FacturaID = 10249;

-- Subconsulta con IN
-- Todas las Facturas que tengan el productoID = 11 (Queso Cabrales)

SELECT productos.ProductoID, productos.ProductoNombre
FROM productos
WHERE productos.ProductoID = 11;

SELECT fd.FacturaID, fd.ProductoID
FROM facturadetalle AS fd
WHERE fd.ProductoID IN
(SELECT p.ProductoID
FROM productos AS p
WHERE p.ProductoID = 11);

-- Consultas con ANY, SOME y ALL
-- Falta hacer


-- Consultas correlacionales
-- Cantidad de productos x factura e Importe total de cada factura
SELECT f.FacturaID, f.ClienteID, f.EmpleadoID, f.FechaFactura,
(SELECT COUNT(fd.ProductoID)
	FROM facturadetalle AS fd
	WHERE f.FacturaID=fd.FacturaID) AS Cantidad,
(SELECT SUM((fd.PrecioUnitario*fd.Cantidad)-fd.Descuento)
	FROM facturadetalle AS fd
	WHERE f.FacturaID=fd.FacturaID) AS Total
FROM facturas AS f;
