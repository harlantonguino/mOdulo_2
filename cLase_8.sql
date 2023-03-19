create database clase_8;

use clase_8;

create table gastronomica (
	IDgastronomica int not null auto_increment,
    nombre varchar(64) not null,
    categoria varchar(64) not null,
    direccion varchar(64) not null,
    barrio varchar(64) not null,
    comuna varchar(64) not null,
    primary key (IDgastronomica)
);