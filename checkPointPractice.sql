use checkpointpractice;

select *
from canal_venta;

select *
from producto
limit 5;

select *
from venta
limit 5; 

-- 6) ¿Cuál es el canal id del Producto cuyo nombre es EPSON COPYFAX 2000 ?

select distinct venta.IdCanal, producto.Concepto
from venta
inner join producto
on venta.IdProducto = producto.IDProducto
where producto.Concepto = 'EPSON COPYFAX 2000';

select distinct IdCanal, IdProducto
from venta
where IdProducto = (select IDProducto from producto where Concepto = 'EPSON COPYFAX 2000');

/*7) ¿Cuál es el canal de ventas con menor cantidad de ventas registradas?<br>
    Pista: acordate de las funciones de agregacion AVG/SUM/MIN/MAX/COUNT<br>
    1- OnLine<br>
    2- Telefónica<br>
    3- Presencial<br>*/

select canal_venta.Canal as canal_ventas, count(venta.Cantidad) as cantidad_ventas
from venta
inner join canal_venta
on venta.IdCanal = canal_venta.IdCanal
group by canal_ventas
order by cantidad_ventas
limit 1;

/*8) Cual fue el mes con mayor venta de la sucursal 13 para el año 2015 ?<br>
    Pista para agrupar por mes podes usar el   DATE_FORMAT( date,'%Y%m') --> YYYYMM o  DATE_FORMAT( date,'%m') --> MM<br>

    1- 9
    2- 3
    3- 12
    4- 2
    5- 8*/

select date_format(Fecha, '%M') as mes, sum(Precio * Cantidad) as total_ingresos_ventas
from venta
where IdSucursal = 13 and date_format(Fecha, '%Y') = 2015 
group by mes
order by total_ingresos_ventas desc
limit 1;

select date_format(Fecha, '%M') as mes, count(Cantidad) as cantidad_ventas
from venta
where IdSucursal = 13 and date_format(Fecha, '%Y') = 2015 
group by mes
order by cantidad_ventas desc
limit 1;

select date_format(Fecha, '%M') as mes, sum(Cantidad) as cantidad_productos_vendidos
from venta
where IdSucursal = 13 and date_format(Fecha, '%Y') = 2015
group by mes
order by cantidad_productos_vendidos desc
limit 1;

/*9) Se define el tiempo de entrega como el tiempo en días transcurrido entre que se realiza la compra y se efectua la entrega. Par analizar mejoras en el servicio, la dirección desea saber: cuál es el año con el promedio más alto de este tiempo de entrega. (Fecha = Fecha de venta; Fecha_Entrega = Fecha de entrega)<br>

    Pista: acordate de las funciones de agregacion AVG/SUM/MIN/MAX*/
    
select date_format(Fecha, '%Y') as año, avg(timestampdiff(day, Fecha, Fecha_Entrega)) as promedio_tiempo_entrega
from venta
group by año
order by promedio_tiempo_entrega desc
limit 1;

/*10) La dirección desea saber que tipo de producto tiene la mayor venta en 2020 (Tabla 'producto', campo Tipo = Tipo de producto)<br>
    Pista: acordate de las funciones de agregacion AVG/SUM/MIN/MAX<br>
    1- INFORMATICA<br>
    2- ESTUCHERIA<br>
    3- AUDIO<br>
    4- IMPRESIÓN<br>
    5- GABINETES<br>
    6- GRABACION<br>
    7- BASES<br>
    8- GAMING<br>*/

select date_format(venta.Fecha, '%Y') as año, producto.Tipo as tipo_producto, sum(venta.Precio * venta.Cantidad) as total_ingresos_ventas
from venta
inner join producto
on venta.IdProducto = producto.IDProducto
where date_format(venta.Fecha, '%Y') = 2020
group by año, tipo_producto
order by total_ingresos_ventas desc
limit 1;

select date_format(venta.Fecha, '%Y') as año, producto.Tipo as tipo_producto, sum(venta.Cantidad) as cantidad_productos_vendidos
from venta
inner join producto
on venta.IdProducto = producto.IDProducto
where date_format(venta.Fecha, '%Y') = 2020
group by año, tipo_producto
order by cantidad_productos_vendidos desc
limit 1;

select date_format(venta.Fecha, '%Y') as año, producto.Tipo as tipo_producto, count(venta.Cantidad) as cantidad_ventas
from venta
inner join producto
on venta.IdProducto = producto.IDProducto
where date_format(venta.Fecha, '%Y') = 2020
group by año, tipo_producto
order by cantidad_ventas desc
limit 1;

/*11) ¿Cuál es el año y mes con la mayor cantidad de productos vendidos?<br>
    Informar la respuesta con 4 digitos para el año y 2 para el mes
    Por ejemplo 201506 seria Junio 2015
    Pista para agrupar por mes podes usar el   DATE_FORMAT( date,'%Y%m') --> YYYYMM o  DATE_FORMAT( date,'%m') --> MM*/
    
select date_format(Fecha, '%Y%m') as año_mes, sum(Cantidad) as cantidad_productos
from venta
group by año_mes
order by cantidad_productos desc
limit 1;

-- 12) ¿Cuantos productos tienen la palabra DVD en alguna parte de su nombre/concepto?

select count(IDProducto) as numero_productos
from producto
where Concepto like '%DVD%';

/*13) ¿Cual de estos tipos de producto, tiene la menor diferencia de precio entre sus minimos y maximos?<br>
    1- GABINETES  
    2- GAMING  
    3- IMPRESIÓN*/

select Tipo, max(Precio) - min(Precio) as diferencia_precios
from producto
group by Tipo
order by diferencia_precios asc
limit 1;

/*14) Teniendo en cuenta que Fecha es la fecha real de compra, y Fecha_Entrega es la fecha real que se entrego el producto. ¿Cuantas ventas NO se entregaron el mismo mes en que fueron compradas?<br>
    Ejemplo
    Venta |Fecha      | Fecha_Entrega
    1    |2018-03-09 | 2018-03-25 --> Se entrego el mismo mes que fue hecha la venta
    2    |2020-06-29 | 2020-07-01 --> No se entrego el mismo mes que la venta*/

select count(IdVenta) cantidad_ventas
from venta
where date_format(Fecha, '%m') != date_format(Fecha_Entrega, '%m');



/*15) Cual es el Id del empleado que mayor cantidad de productos vendio en toda la historia de las ventas?<br>
    1- 3603<br>
    2- 3504<br>
    3- 1675<br>
    4- 3186<br>*/

select IdEmpleado, sum(Cantidad) as cantidad_productos
from venta
group by IdEmpleado
order by cantidad_productos desc
limit 1;