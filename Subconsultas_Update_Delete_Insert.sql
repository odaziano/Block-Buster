Problema:
Un comercio que vende artículos de librería y papelería almacena la información de sus ventas en una 
tabla llamada "facturas" y otra "clientes".

1-Cree las tablas (las borramos primero si ya existen):
 drop table if exists clientes;
 drop table if exists facturas;

 create table clientes(
  codigo int auto_increment,
  nombre varchar(30),
  domicilio varchar(30),
  primary key(codigo)
 );

 create table facturas(
  numero int not null,
  fecha date,
  codigocliente int not null,
  total decimal(6,2),
  primary key(numero)
 );

2-Ingrese algunos registros:
 insert into clientes(nombre,domicilio) values('Juan Lopez','Colon 123');
 insert into clientes(nombre,domicilio) values('Luis Torres','Sucre 987');
 insert into clientes(nombre,domicilio) values('Ana Garcia','Sarmiento 576');
 insert into clientes(nombre,domicilio) values('Susana Molina','San Martin 555');

 insert into facturas values(1200,'2018-01-15',1,300);
 insert into facturas values(1201,'2018-01-15',2,550);
 insert into facturas values(1202,'2018-01-15',3,150);
 insert into facturas values(1300,'2018-01-20',1,350);
 insert into facturas values(1310,'2018-01-22',3,100);

3- El comercio necesita una tabla llamada "clientespref" en la cual quiere almacenar el nombre y 
domicilio de aquellos clientes que han comprado hasta el momento más de 500 pesos en mercaderías. 
Créela la tabla:
 drop table if exists clientespref;
 create table clientespref(
  nombre varchar(30),
  domicilio varchar(30)
 );

4- Ingrese los registros en la tabla "clientespref" seleccionando registros de la tabla "clientes" y 
"facturas".
 insert into clientespref (nombre,domicilio) 
  select nombre,domicilio
   from clientes as c
   inner join facturas as f on f.codigocliente=c.codigo
   group by codigocliente
   having sum(total)>=500;


5- Vea los registros de "clientespref":
 select * from clientespref;