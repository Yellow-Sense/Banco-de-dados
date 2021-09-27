Create Database Yellow_Sensor; 

use Yellow_Sensor;

create table  cadastro_cliente (
id_usuario int primary key auto_increment,
nome_usuario varchar (50), 
email_usuario varchar (70) not null,
telefone varchar (20), 
senha char (8) not null, 
nome_granja varchar (50),
estado char (2)
);

insert into cadastro_cliente values
(null,'Cleber Rosario','cleberson.granja@gmail.com','12345678912','12345678','Galinhas do Cleber','SP');

select * from cadastro_cliente;
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------
create table sensor(
	idArea int primary key auto_increment,
    area_granja char(1),
    dia_hora datetime default current_timestamp,
    temperatura float,
    alerta varchar(20), 
    constraint alerta_check check (alerta = 'resfriar' or alerta = 'esquentar' or alerta ='ok')
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
temp_mensal float
)auto_increment = 10000;

insert into relatorio_mensal(ovos_mensal,temp_mensal) values 
(2500,'23.5');

select * from relatorio_mensal;
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------

create table relatorio_anual(
idAnual int primary key auto_increment,
ovos_anual int,
temp_anual float
)auto_increment = 1000;

insert into relatorio_anual(ovos_anual,temp_anual) values 
(250000,'25');

select * from relatorio_mensal;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------

create table login (
idLogin int primary key auto_increment,
usuario varchar(45),
email varchar (45),
senha char (8)
) ;


-- ----------------------------------------------------------------------------------------------------------------------------------------------------
create table registro (
idRegistro int primary key auto_increment,
dia datetime default current_timestamp,
temperaturas float
);