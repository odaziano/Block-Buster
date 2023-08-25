-- Reportes parte I - Repasamos INNER JOIN
-- Realizar una consulta de la facturación de e-market. Incluir la siguiente información:
-- Id de la factura, fecha de la factura, nombre de la empresa de correo, nombre del cliente,
-- categoría del producto vendido, nombre del producto, precio unitario, cantidad

SELECT fa.FacturaID, fa.FechaFactura, fa.EnvioVia, co.Compania, fa.ClienteID, cl.Compania,
fd.ProductoID, pr.ProductoNombre, ca.CategoriaNombre, fd.PrecioUnitario, fd.Cantidad
FROM facturas AS fa
INNER JOIN correos AS co
ON EnvioVia = co.CorreoID
INNER JOIN Clientes AS cl
ON fa.ClienteID = cl.ClienteID
INNER JOIN FacturaDetalle AS fd
ON fa.FacturaID = fd.FacturaID
INNER JOIN Productos AS pr
ON fd.ProductoID = pr.ProductoID
INNER JOIN categorias AS ca
ON pr.CategoriaID = ca.CategoriaID;

-- Reportes parte II - INNER, LEFT Y RIGHT JOIN

-- Listar todas las categorías junto con información de sus productos.
-- Incluir todas las categorías aunque no tengan productos.

SELECT ca.CategoriaID, ca.CategoriaNombre, pr.ProductoNombre FROM categorias AS ca
LEFT JOIN productos AS pr
ON ca.CategoriaID = pr.CategoriaID
ORDER BY ca.CategoriaID;

-- Listar la información de contacto de los clientes que no hayan comprado nunca en emarket.
SELECT cl.ClienteID, cl.Compania, cl.Contacto, fa.FacturaID, fa.FechaFactura
FROM Clientes AS cl
LEFT JOIN Facturas AS fa
ON cl.ClienteID = fa.ClienteID
WHERE fa.FacturaID IS NULL;

-- Realizar un listado de productos.
-- Para cada uno indicar su nombre, categoría, y la información de contacto de su proveedor.
-- Tener en cuenta que puede haber productos para los cuales no se indicó quién es el proveedor.

SELECT pr.ProductoID, pr.ProductoNombre, pr.CategoriaID, pr.ProveedorID, pro.Compania AS "Proveedor",
pro.Contacto AS "ContactoProveedor"
FROM productos AS pr
LEFT JOIN proveedores AS pro
ON pr.ProveedorID = pro.ProveedorID;
-- Comprueba
SELECT pr.ProductoID, pr.ProductoNombre, pr.CategoriaID, pr.ProveedorID
FROM productos AS pr
WHERE pr.ProveedorID IS NULL OR pr.ProveedorID = "";

-- Para cada categoría listar el promedio del precio unitario de sus productos.

SELECT ca.CategoriaID, ca.CategoriaNombre, FORMAT(AVG(pr.PrecioUnitario), 2,'es = ES') AS "Precio_Promedio"
FROM Categorias AS ca
LEFT JOIN Productos AS pr
ON ca.CategoriaID = pr.CategoriaID
GROUP BY ca.CategoriaID
ORDER BY ca.CategoriaID;

-- Para cada cliente, indicar la última factura de compra.
-- Incluir a los clientes que nunca hayan comprado en e-market.

SELECT cl.ClienteID, cl.Compania, MAX(fa.FacturaID) AS "Última Factura"
FROM Clientes AS cl
LEFT JOIN facturas AS fa
ON cl.ClienteID = fa.ClienteID
GROUP BY cl.ClienteID;

-- Todas las facturas tienen una empresa de correo asociada (enviovia).
-- Generar un listado con todas las empresas de correo, y la cantidad de facturas correspondientes.
-- Realizar la consulta utilizando RIGHT JOIN.

SELECT co.CorreoID, co.Compania, COUNT(fa.FacturaID)
FROM Correos AS co
RIGHT JOIN Facturas AS fa
ON co.CorreoID = fa.EnvioVia
GROUP BY co.CorreoID;

SELECT co.CorreoID, co.Compania AS Correo, COUNT(fa.FacturaID) AS "Cant_Fact_x_Correo"
FROM Facturas AS fa
INNER JOIN Correos AS co
ON fa.Enviovia = co.CorreoID
GROUP BY fa.EnvioVia
ORDER BY fa.EnvioVia;

