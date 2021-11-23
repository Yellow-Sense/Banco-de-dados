CREATE DATABASE Yellow_Sensor ;
USE Yellow_Sensor ;
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
-- Table `cliente`
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE usuario (
  idUsuario INT AUTO_INCREMENT PRIMARY KEY,
  nome_usuario VARCHAR(50) ,
  email_usuario VARCHAR(70) ,
  senha CHAR(8),
  tipo VARCHAR(15) DEFAULT 'usuario'
);

insert into usuario(nome_usuario,email_usuario,senha,tipo) values
('Leandro Cotrim', 'L.Cotrim@gmail.com',40028921,'admin'),
('Matheus Araujo', 'M.Araujo@gmail.com',40028922,'admin'),
('João Pedro', 'J.Pedro@gmail.com',40028923,'admin'),
('Felipe Brito', 'F.Brito@gmail.com',40028924,'admin'),
('Lucas Soares', 'L.Soares@gmail.com',40028925,'admin');

INSERT INTO usuario(nome_usuario,email_usuario,senha) VALUES
('Cleber Rosario','cleberRos@gmail.com',12345678),
('Kauã de Aliveira ','K.oliveira@gmail.com',87654321),
('Matheus Antonio','M.antonio@gmail.com',88888888),
('Leonardo da Silva','Leonardo.S@gmail.com',98989898);

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
  telefone VARCHAR(20),
  numero_propiedade VARCHAR(4),
  fkCliente INT,
    FOREIGN KEY (fkCliente)
    REFERENCES usuario (idUsuario)
    );
    
insert into granja(nome_granja,estado,cnpj,cep,rua,telefone,numero_propiedade,fkCliente) values
('Galinha Feliz','SP',12345678912345,12345678,'Rua das laranjeiras','11940028922',0345,6),
('Branco e Amarelo','MG',12345678942345,12345671,'Rua General Ozorio','11940239593',0234,7),
('Chiken egg','SP',1234567893456,12345672,'Rua Marcos Claricio','11991827312',0532,8),
('Chocadeira','RS',1234567894567,12345673,'Rua Santa Luzia','11909874202',0242,9);

-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
-- Table `Yellow_Sensor`.`sensor`
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE sensor (
  idSensor INT AUTO_INCREMENT PRIMARY KEY ,
  area_granja CHAR(1),
  status_sensor VARCHAR(20),
  CONSTRAINT check_status CHECK(status_sensor='funcionando' or status_sensor='manuntenção'),
  fkGranja int,
  foreign key (fkGranja) references granja(idGranja) 
)AUTO_INCREMENT = 100000;

insert into sensor(area_granja,status_sensor,fkGranja) values
('A','funcionando',1),
('B','funcionando',1),
('C','funcionando',1),
('D','funcionando',1),
('A','funcionando',2),
('B','funcionando',2),
('C','funcionando',2),
('D','funcionando',2),
('C','funcionando',3),
('C','funcionando',3),
('D','funcionando',3),
('A','funcionando',3),
('B','funcionando',3),
('A','funcionando',4),
('B','funcionando',4),
('C','funcionando',4),
('D','funcionando',4),
('A','funcionando',4);

-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- Table `registro`
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE registro (
  idRegistro INT PRIMARY KEY  AUTO_INCREMENT,
  temperaturas FLOAT ,
  fkAreaSensor2 INT ,
  FOREIGN KEY (fkAreaSensor2)
  REFERENCES sensor (idSensor),
  alerta VARCHAR(45),
  constraint check_alerta check(alerta='ativado' or alerta='desativado')
    );
    

insert into registro (temperaturas,fkAreaSensor2,alerta) values
(25.5,100000,'desativado'),
(25.5,100001,'desativado'),
(25.9,100002,'desativado'),
(28.5,100003,'ativado'),
(22.5,100004,'desativado'),
(22.4,100005,'desativado'),
(23.5,100006,'desativado'),
(17.5,100007,'ativado'),
(25.5,100008,'desativado'),
(25.5,100009,'desativado'),
(25.9,100010,'desativado'),
(28.5,100011,'ativado'),
(18.5,100012,'desativado'),
(18.3,100013,'desativado'),
(17.5,100014,'ativado'),
(16.0,100015,'ativado'),
(22.0,100016,'desativado'),
(15.6,100017,'ativado');

	
select * from  usuario;
select * from  sensor;
select * from  granja;
select * from  registro;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- Dados granja 1
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM usuario WHERE ADM = 1;

select * from registro join sensor 
	on fkAreaSensor2 = idSensor 
		where fkGranja = 1;

-- 								Mostrando o nome da granja 1 e seus registros 
 select s.area_granja, r.*, g.nome_granja as 'Nome da granja do cliente'
		from sensor as s
			join registro as r on fkAreaSensor2 = idSensor  
				join granja as g on fkGranja = idGranja where fkGranja = 1 group by s.area_granja;
                
                
             --                				Nome e media das temperaturas granja 1
select s.area_granja, round(avg(r.temperaturas)), g.nome_granja
	as 'Média Temperatura Mensal' from sensor as s
		join registro as r on fkAreaSensor2 = idSensor  
		join granja as g on fkGranja = idGranja where fkGranja = 1 group by s.area_granja;
            
            
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- Dados granja 2
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------

-- 									MOSTRANDO TODOS OS DADOS DA GRANJA 2
select * from registro join sensor 	
	on fkAreaSensor2 = idSensor join granja on idGranja = fkGranja
		where fkGranja = 2;

-- 								Mostrando o nome e  registros  da granja 2
    
    select s.area_granja, r.*, g.nome_granja as 'Nome da granja do cliente'
		from sensor as s
			join registro as r on fkAreaSensor2 = idSensor  
				join granja as g on fkGranja = idGranja where fkGranja = 2 group by s.area_granja;

--                			    				Nome e media das temperaturas e area do sensor   - granja 2
select s.area_granja, round(avg(r.temperaturas)), g.nome_granja
	as 'Média Temperatura Mensal' from sensor as s
		join registro as r on fkAreaSensor2 = idSensor  
		join granja as g on fkGranja = idGranja where fkGranja = 2 group by s.area_granja;
        
            
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- Dados granja 3
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------

-- 									MOSTRANDO TODOS OS DADOS DA GRANJA 3
select * from registro join sensor 
	on fkAreaSensor2 = idSensor
		where fkGranja = 3;
        
-- 								Mostrando o nome e  registros  da granja 3
    
    select s.area_granja, r.*, g.nome_granja as 'Nome da granja do cliente'
		from sensor as s
			join registro as r on fkAreaSensor2 = idSensor  
				join granja as g on fkGranja = idGranja where fkGranja = 3 group by s.area_granja;
                
                
--                				Nome e media das temperaturas granja 3
select s.area_granja, round(avg(r.temperaturas)), g.nome_granja
	as 'Média Temperatura Mensal' from sensor as s
		join registro as r on fkAreaSensor2 = idSensor  
		join granja as g on fkGranja = idGranja where fkGranja = 3 group by s.area_granja;
        
            
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- Dados granja 4
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------

-- 									MOSTRANDO TODOS OS DADOS DA GRANJA 4
select * from registro join sensor
	on fkAreaSensor2 = idSensor join granja
		on idGranja = fkgranja 
			where fkGranja = 4;



-- 								Mostrando o nome e  registros  da granja 4
    
    select s.area_granja, r.*, g.nome_granja as 'Nome da granja do cliente'
		from sensor as s
			join registro as r on fkAreaSensor2 = idSensor  
				join granja as g on fkGranja = idGranja where fkGranja = 4 group by s.area_granja;
        
        
        
--                				Nome e media das temperaturas granja 4
select s.area_granja, round(avg(r.temperaturas)), g.nome_granja 
	as 'Média Temperatura Mensal' from sensor as s
		join registro as r on fkAreaSensor2 = idSensor  
		join granja as g on fkGranja = idGranja where fkGranja = 4 group by s.area_granja;