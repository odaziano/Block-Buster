SELECT @miregion:='Southern';
SELECT @miregion;
-- La variable de memoria, de usuario, funciona en el SELECT. NO en la Vista.

-- Vista para saber que empleados están en la region 'Southern'
DROP VIEW IF EXISTS Emp_Regiones;
CREATE VIEW Emp_Regiones AS
SELECT e.EmpleadoID, e.Apellido, e.Nombre, eu.UbicacionID, u.UbicacionDescripcion, r.regionesdescripcion
FROM empleados AS e
LEFT JOIN empleadoubicaciones AS eu
ON e.EmpleadoID = eu.EmpleadoID
INNER JOIN ubicaciones AS u
ON eu.UbicacionID = u.UbicacionID
INNER JOIN regiones AS r
ON u.RegionesID = r.RegionesID
WHERE r.regionesdescripcion=@miregion
ORDER BY e.EmpleadoID ;
SELECT * FROM emp_regiones;

-- Vista para saber cuantos empleados hay por Region
DROP VIEW IF EXISTS Ca_Emp_x_Regiones;
CREATE VIEW Ca_Emp_x_Regiones AS
SELECT COUNT(e.EmpleadoID), r.RegionesDescripcion
FROM empleados AS e
LEFT JOIN empleadoubicaciones AS eu
ON e.EmpleadoID = eu.EmpleadoID
LEFT JOIN ubicaciones AS u
ON eu.UbicacionID = u.UbicacionID
LEFT JOIN regiones AS r
ON u.RegionesID = r.RegionesID
GROUP BY r.RegionesID;
SELECT * FROM Ca_Emp_x_Regiones;