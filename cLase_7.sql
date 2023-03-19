use henry;

-- 1. ¿Cuantas carreas tiene Henry?

select count(IDcarrera)
from carrera;

-- 2. ¿Cuantos alumnos hay en total?

select count(IDalumno)
from alumno;

-- 3. ¿Cuantos alumnos tiene cada cohorte?

select cohorte.IDcohorte as cohorte, count(alumno.IDalumno) as cantidad_alumnos
from alumno
inner join cohorte
on alumno.IDcohorte = cohorte.IDcohorte
group by cohorte;

-- 4. Confecciona un listado de los alumnos ordenado por los últimos alumnos que ingresaron, con nombre y apellido en un solo campo.

select concat(nombre,' ',apellido) as 'nombre y apellido', fechaIngreso
from alumno
order by fechaIngreso desc;

-- 5. ¿Cual es el nombre del primer alumno que ingreso a Henry?

select concat(nombre,' ',apellido) as 'nombre y apellido'
from alumno
order by fechaIngreso asc
limit 1;

-- 6. ¿En que fecha ingreso?

select fechaIngreso
from alumno
order by fechaIngreso asc
limit 1;

-- 7. ¿Cual es el nombre del ultimo alumno que ingreso a Henry?

select concat(nombre,' ',apellido) as 'nombre y apellido', fechaIngreso
from alumno
order by fechaIngreso desc
limit 1;

-- 8. La función YEAR le permite extraer el año de un campo date, utilice esta función y especifique cuantos alumnos ingresarona a Henry por año.

select year(fechaIngreso) as fecha_ingreso, count(IDalumno) as cantidad_alumnos
from alumno
group by fecha_ingreso;

-- 9. ¿Cuantos alumnos ingresaron por semana a henry?, indique también el año. WEEKOFYEAR()

select year(fechaIngreso) as año, weekofyear(fechaIngreso) as semana, count(IDalumno) as cantidad_alumnos
from alumno
group by año, semana
order by año, semana;

-- 10. ¿En que años ingresaron más de 20 alumnos?

select year(fechaIngreso) as fecha_ingreso, count(IDalumno) as cantidad_alumnos 
from alumno
group by fecha_ingreso
having cantidad_alumnos > 20;

-- 11. Investigue las funciones TIMESTAMPDIFF() y CURDATE(). ¿Podría utilizarlas para saber cual es la edad de los instructores?.

select concat(nombre,' ',apellido) as 'nombre_apellido / instructor', timestampdiff(year, fechaNacimiento, curdate()) as edad
from instructor;

-- ¿Como podrías verificar si la función cálcula años completos? Utiliza DATE_ADD().


-- *12. Cálcula:<br>
-- - La edad de cada alumno.<br>

select concat(nombre,' ',apellido) as 'nombre_apellido / alumno', timestampdiff(year, fechaNacimiento, curdate()) as edad
from alumno
limit 10;

-- - La edad promedio de los alumnos de henry.<br>

/* se corrige fecha de nacimiento alumno id 127 de la base de datos suministrada
update alumno
set fechaNacimiento = '2002-01-02'
where IDalumno = 127;
*/

select avg(timestampdiff(year, fechaNacimiento, curdate())) as promedio_edad
from alumno;

-- - La edad promedio de los alumnos de cada cohorte.<br>

select cohorte.codigo as codigo_cohorte, avg(timestampdiff(year, alumno.fechaNacimiento, curdate())) as promedio_edad 
from alumno
inner join cohorte 
on alumno.IDcohorte = cohorte.IDcohorte
group by codigo_cohorte;

-- Elabora un listado de los alumnos que superan la edad promedio de Henry.

select concat(nombre,' ',apellido) as 'nombre_apellido / alumno', timestampdiff(year, fechaNacimiento, curdate()) as edad
from alumno
where timestampdiff(year, fechaNacimiento, curdate()) > 
	(select avg(timestampdiff(year, fechaNacimiento, curdate())) as promedio_edad
	from alumno);