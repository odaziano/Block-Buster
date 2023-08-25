SELECT @miregion:='Southern';

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
WHERE r.regionesdescripcion = 'Southern'
ORDER BY e.EmpleadoID ;
SELECT * FROM emp_regiones;

SELECT e.apellido, e.nombre, COUNT(eu.UbicacionID)
FROM empleados AS e
INNER JOIN empleadoubicaciones as eu
ON e.EmpleadoID = eu.EmpleadoID;
GROUP BY eu.UbicacionID;