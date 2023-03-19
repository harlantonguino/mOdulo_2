/*
Instalación MySQL y Wokrbench<br>
MySQL Installer: [Download](https://dev.mysql.com/downloads/installer/)<br>
MySQL: [Documentation](https://dev.mysql.com/doc/)

Crear un modelo relacional basado en el modelo de negocios de Henry:

1. Identificar las relaciones.
2. Identifcar primery key´s y foreing key´s.
3. Definir los tipos de datos.

La entidades a modelar junto sus atributos son: <br>
* Carrea: ID, Nombre.<br>
* Cohorte: ID, Código, Carrera, Fecha de Inicio, Fecha de Finalización, Instructor.<br>
* Instructores: ID, Cédula de identidad, Nombre, Apellido, Fecha de Nacimiento, Fecha de Incorporación.<br>
* Alumnos: ID, Cédula de identidad, Nombre, Apellido, Fecha de Nacimiento, Fecha de Ingreso, Cohorte.<br>

Crear en MySQL las tablas y relaciones del modelo definido.<br>
*/

create database henry;

use henry;

create table carrera(
	IDcarrera int not null auto_increment,
    nombre varchar(35),
    primary key (IDcarrera)
    );
    
create table instructor(
	IDinstructor int not null auto_increment,
    cedulaIdentidad varchar(35) not null,
    nombre varchar(35) not null,
    apellido varchar(35) not null,
    fechaNacimiento date,
    fechaIncorporacion date,
    primary key (IDinstructor)
);

create table cohorte(
	IDcohorte int not null auto_increment,
    codigo varchar(35) not null,
    fechaInicio date,
    fechaFinalizacion date,
    IDcarrera int not null,
    IDinstructor int not null,
    primary key (IDcohorte),
    foreign key (IDcarrera) references carrera(IDcarrera),
    foreign key (IDinstructor) references instructor(IDinstructor)
);

create table alumno(
	IDalumno int not null auto_increment,
    cedulaIdentidad varchar(35) not null,
    nombre varchar(35) not null,
    apellido varchar(35) not null,
    fechaNacimiento date,
    fechaIngreso date,
    IDcohorte int not null,
    primary key (IDalumno),
    foreign key (IDcohorte) references cohorte(IDcohorte)
);