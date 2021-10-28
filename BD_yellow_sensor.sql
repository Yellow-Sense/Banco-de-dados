CREATE DATABASE Yellow_Sensor ;
USE Yellow_Sensor ;

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
-- Table `cliente`
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE cliente (
  idCliente INT AUTO_INCREMENT PRIMARY KEY,
  nome_usuario VARCHAR(50) ,
  email_usuario VARCHAR(70) ,
  telefone VARCHAR(20),
  senha CHAR(8)
);

insert into cliente(nome_usuario,email_usuario,telefone,senha) values
('Cleber Rosario','cleberRos@gmail.com','1196732-2100',12345678),
('Kauã de Aliveira ','K.oliveira@gmail.com','1195673-2340',87654321),
('Matheus Antonio','M.antonio@gmail.com','1196432-9123',88888888),
('Leonardo da Silva','Leonardo.S@gmail.com','1196521-9321',98989898);

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
-- Tabela administrador`
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE administrador (
  idLogin INT AUTO_INCREMENT PRIMARY KEY ,
  usuario VARCHAR(45) ,
  email VARCHAR(45) ,
  senha CHAR(8) 
  );

insert into administrador (usuario,email,senha) values
('João Noleto','j.noleto@gmail.com',12345678),
('Lucas Soares','l.soares@gmail.com',12345679),
('Leandro Cotrim','l.cotrim@gmail.com',12345671),
('Matheus Carvalho','m.carvalho@gmail.com',12345672),
('Felipe Andrade','f.andrade@gmail.com',12345673);
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
-- Table `Yellow_Sensor`.`sensor`
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE sensor (
  idSensor INT AUTO_INCREMENT PRIMARY KEY ,
  area_granja CHAR(1),
  status_sensor VARCHAR(20),
  CONSTRAINT check_status CHECK(status_sensor='funcionando' or status_sensor='manuntenção')
)
AUTO_INCREMENT = 100000;

insert into sensor(area_granja,status_sensor) values
('A','funcionando'),
('B','funcionando'),
('C','funcionando'),
('D','funcionando'),
('A','funcionando'),
('B','funcionando'),
('A','funcionando'),
('B','funcionando'),
('C','funcionando'),
('D','funcionando'),
('A','funcionando'),
('B','funcionando'),
('A','funcionando'),
('B','funcionando'),
('C','funcionando'),
('D','funcionando'),
('A','funcionando');

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
-- Table `granja`
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE granja (
  idGranja INT AUTO_INCREMENT PRIMARY KEY,
  nome_granja VARCHAR(50),
  estado CHAR(2),
  cnpj CHAR(14),
  cep CHAR(8),
  rua VARCHAR (45),
  bairro VARCHAR (45),
  numero_propiedade VARCHAR(4),
  fkAreaSensor INT,
   FOREIGN KEY (fkAreaSensor)
    REFERENCES sensor (idSensor),
  fkCliente INT,
    FOREIGN KEY (fkCliente)
    REFERENCES cliente (idCliente)
    );


insert into granja(nome_granja,estado,cnpj,cep,rua,bairro,numero_propiedade,fkAreaSensor,fkCliente) values
('Galinha Feliz','SP',12345678912345,12345678,'Rua das laranjeiras','Rosas Claras',0345,100000,1),
('Branco e Amarelo','MG',12345678942345,12345671,'Rua General Ozorio','Rio das Ostras',0234,100001,2),
('Chiken egg','SP',1234567893456,12345672,'Rua Marcos Claricio','Rio Claro',0532,100002,3),
('Chocadeira','RS',1234567894567,12345673,'Rua Santa Luzia','Folha Seca',0242,100003,4);

-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- Table `registro`
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE registro (
  idRegistro INT PRIMARY KEY  AUTO_INCREMENT,
  dia DATETIME  DEFAULT CURRENT_TIMESTAMP,
  temperaturas FLOAT ,
  fkAreaSensor2 INT ,
   FOREIGN KEY (fkAreaSensor2)
    REFERENCES sensor (idSensor),
  alerta VARCHAR(45) constraint check_alerta check(alerta='ativado' or alerta='desativado'),
  fkGranja INT ,
    FOREIGN KEY (fkGranja)
    REFERENCES granja (idGranja)
    );


insert into registro (temperaturas,fkAreaSensor2,alerta,fkgranja) values
(25.5,100000,'desativado',1),
(25.5,100001,'desativado',1),
(25.9,100003,'desativado',1),
(28.5,100004,'ativado',1),
(22.5,100005,'desativado',2),
(22.4,100006,'desativado',2),
(23.5,100007,'desativado',2),
(17.5,100008,'ativado',2),
(25.5,100009,'desativado',3),
(25.5,100010,'desativado',3),
(25.9,100011,'desativado',3),
(28.5,100012,'ativado',3),
(18.5,100013,'desativado',4),
(18.3,100014,'desativado',4),
(17.5,100015,'ativado',4),
(16.0,100016,'ativado',4);
	
select * from  cliente;
select * from  sensor;
select * from  granja;
select * from  registro;

-- 									MOSTRANDO TODOS OS DADOS DA GRANJA 1
select * from registro join sensor 
	on fkAreaSensor2 = idSensor 
		where fkGranja = 1;

-- 								Mostrando o nome da granja 1 e seus registros 
select  nome_granja, r.*
	from granja join registro as r 
		on idGranja = fkGranja where fkgranja = 1;
							
--                				Nome e media das temperaturas granja 1
select nome_granja, avg(round(t.temperaturas)) 
	as 'Média Temperatura Mensal' from granja  
		join registro as t 
			on idGranja = fkGranja where fkgranja = 1;
            
            
-- ---------------------------------------------------- 2   ---------------------------------------------------------------

-- 									MOSTRANDO TODOS OS DADOS DA GRANJA 2
select * from registro join sensor 	
	on fkAreaSensor2 = idSensor 
		where fkGranja = 2;

-- 								Mostrando o nome da granja 2 e seus registros 
select  nome_granja, r.*
	from granja  join registro as r 
		on idGranja = fkGranja where fkgranja = 2;
        
--                				Nome e media das temperaturas granja 2
select nome_granja, avg(round(t.temperaturas)) 
	as 'Média Temperatura Mensal' from granja  
		join registro as t 
			on idGranja = fkGranja where fkgranja = 2;
            
            
-- --------------------------------------------------     3       -----------------------------------------------------------------

-- 									MOSTRANDO TODOS OS DADOS DA GRANJA 3
select * from registro join sensor 
	on fkAreaSensor2 = idSensor
		where fkGranja = 3;
-- 								Mostrando o nome da granja 3 e seus registros 
select  nome_granja, r.*
	from granja  join registro as r 
		on idGranja = fkGranja where fkgranja = 3;
        
        --                				Nome e media das temperaturas granja 3
select nome_granja, avg(round(t.temperaturas)) 
	as 'Média Temperatura Mensal' from granja  
		join registro as t 
			on idGranja = fkGranja where fkgranja = 3;
            
            
-- ----------------------------------------------------   4   ---------------------------------------------------------------

-- 									MOSTRANDO TODOS OS DADOS DA GRANJA 4
select * from registro join sensor
	on fkAreaSensor2 = idSensor join granja
		on idGranja = fkgranja 
			where fkGranja = 4;
-- 								Mostrando o nome da granja 4 e seus registros 
select  nome_granja, r.*
	from granja  join registro as r 
		on idGranja = fkGranja where fkgranja = 4;
        
        --                				Nome e media das temperaturas granja 4
select nome_granja, avg(round(t.temperaturas)) 
	as 'Média Temperatura Mensal' from granja  
		join registro as t 
			on idGranja = fkGranja where fkgranja = 4;

