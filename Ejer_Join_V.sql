-- Reportes parte I - Repasamos INNER JOIN
-- Realizar una consulta de la facturación de e-market. Incluir la siguiente información:
-- Id de la factura
-- fecha de la factura
-- nombre de la empresa de correo
-- nombre del cliente
-- categoría del producto vendido
-- nombre del producto
-- precio unitario
-- cantidad

SELECT fa.FacturaID, fa.FechaFactura, fa.EnvioVia, co.Compania, fa.ClienteID, cl.Compania,
fd.ProductoID, pr.ProductoNombre, fd.PrecioUnitario, fd.Cantidad
FROM Facturas AS fa
INNER JOIN correos AS co
ON fa.EnvioVia = co.CorreoID
INNER JOIN Clientes AS cl
ON fa.ClienteID = cl.ClienteID
INNER JOIN FacturaDetalle AS fd
ON fd.ProductoID = fd.ProductoID
INNER JOIN Productos AS pr
ON pr.CategoriaID = fd.ProductoID;






Reportes parte II - INNER, LEFT Y RIGHT JOIN

Listar todas las categorías junto con información de sus productos. Incluir todas las categorías aunque no tengan productos.
Listar la información de contacto de los clientes que no hayan comprado nunca en emarket.
Realizar un listado de productos. Para cada uno indicar su nombre, categoría, y la información de contacto de su proveedor. Tener en cuenta que puede haber productos para los cuales no se indicó quién es el proveedor.
Para cada categoría listar el promedio del precio unitario de sus productos.
Para cada cliente, indicar la última factura de compra. Incluir a los clientes que nunca hayan comprado en e-market.
Todas las facturas tienen una empresa de correo asociada (enviovia). Generar un listado con todas las empresas de correo, y la cantidad de facturas correspondientes. Realizar la consulta utilizando RIGHT JOIN.
