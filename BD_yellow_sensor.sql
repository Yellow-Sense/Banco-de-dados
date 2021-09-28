Create Database Yellow_Sensor; 

use Yellow_Sensor;
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------

create table cliente (
idCliente int primary key auto_increment,
nome_usuario varchar (50), 
email_usuario varchar (70) not null,
telefone varchar (20), 
senha char (8) not null
);

insert into cliente values
	(null,'Cleber Rosario','cleberson.granja@gmail.com','12345678912','12345678','Galinhas do Cleber','SP');

select * from cliente;


-- -------------------------------------------------------------------------------------------------------------------------------------------------------------
create table login (
idLogin int primary key auto_increment,
usuario varchar(45),
email varchar (45),
senha char (8)
) ;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------

create table granja (
idGranja int primary key auto_increment,
nome_granja varchar (50),
estado char (2),
cnpj char (14),
cep char (8),
numero_propiedade  varchar (4),
fkCliente int,
foreign key (fkCliente) references cliente(idCliente)
);


-- -------------------------------------------------------------------------------------------------------------------------------------------------------------
create table sensor(
	idArea int primary key auto_increment,
    area_granja char(1),
    temperatura float,
    alerta varchar(20), 
    constraint alerta_check check (alerta = 'resfriar' or alerta = 'esquentar' or alerta ='ok' or alerta = 'erro')
)auto_increment = 100000;

insert into sensor(area_granja,temperatura,alerta) values
('A','24.5','ok'),
('B','26.5','resfriar'),
('B','18.5','esquentar');


select * from sensor;

-- -------------------------------------------------------------------------------------------------------------------------------------------------------------
create table relatorio_mensal(
idMensal int primary key auto_increment,
ovos_mensal int,
temp_mensal float,
fkGranja int,
foreign key (fkGranja) references granja(idGranja)
)auto_increment = 10000;


insert into relatorio_mensal(ovos_mensal,temp_mensal) values 
(2500,'23.5');

select * from relatorio_mensal;
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------

create table relatorio_anual(
idAnual int primary key auto_increment,
ovos_anual int,
temp_anual float,
fkGranja int,
foreign key (fkGranja) references granja(idGranja)
)auto_increment = 1000;

insert into relatorio_anual(ovos_anual,temp_anual) values 
(250000,'25');

select * from relatorio_mensal;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------
create table registro (
idRegistro int primary key auto_increment,
dia datetime default current_timestamp,
temperaturas float,
fkGranja int,
foreign key (fkGranja) references granja(idGranja)
);

desc registro;
-- ----------------------------------------------------------------------------------------------------------------------------------------------------

