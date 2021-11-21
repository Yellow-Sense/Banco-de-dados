CREATE DATABASE Yellow_Sensor ;
USE Yellow_Sensor ;
DROP DATABASE Yellow_Sensor;
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
-- Table `cliente`
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE usuario (
  idUsuario INT AUTO_INCREMENT PRIMARY KEY,
  nome_usuario VARCHAR(50) ,
  email_usuario VARCHAR(70) ,
  telefone VARCHAR(20),
  senha CHAR(8),
  tipo VARCHAR(15) DEFAULT 'usuario'
);

insert into usuario(nome_usuario,email_usuario,telefone,senha) values
('Leandro Cotrim', 'L.Cotrim@gmail.com','11940028921',40028921),
('Matheus Araujo', 'M.Araujo@gmail.com','11940028922',40028922),
('João Pedro', 'J.Pedro@gmail.com','11940028923',40028923),
('Felipe Brito', 'F.Brito@gmail.com','11940028924',40028924),
('Lucas Soares', 'L.Soares@gmail.com','11940028925',40028925),
('Cleber Rosario','cleberRos@gmail.com','1196732-2100',12345678),
('Kauã de Aliveira ','K.oliveira@gmail.com','1195673-2340',87654321),
('Matheus Antonio','M.antonio@gmail.com','1196432-9123',88888888),
('Leonardo da Silva','Leonardo.S@gmail.com','1196521-9321',98989898);

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
  fkCliente INT,
    FOREIGN KEY (fkCliente)
    REFERENCES usuario (idUsuario)
    );


insert into granja(nome_granja,estado,cnpj,cep,rua,bairro,numero_propiedade,fkCliente) values
('Galinha Feliz','SP',12345678912345,12345678,'Rua das laranjeiras','Rosas Claras',0345,6),
('Branco e Amarelo','MG',12345678942345,12345671,'Rua General Ozorio','Rio das Ostras',0234,7),
('Chiken egg','SP',1234567893456,12345672,'Rua Marcos Claricio','Rio Claro',0532,8),
('Chocadeira','RS',1234567894567,12345673,'Rua Santa Luzia','Folha Seca',0242,9);
SELECT * FROM granja;
SELECT * FROM usuario;
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
('A','funcionando',9),
('B','funcionando',9),
('C','funcionando',9),
('D','funcionando',9),
('A','funcionando',10),
('B','funcionando',10),
('C','funcionando',10),
('D','funcionando',10),
('C','funcionando',10),
('C','funcionando',11),
('D','funcionando',11),
('A','funcionando',11),
('B','funcionando',11),
('A','funcionando',12),
('B','funcionando',12),
('C','funcionando',12),
('D','funcionando',12),
('A','funcionando',12);

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
(25.5,100036,'desativado'),
(25.5,100037,'desativado'),
(25.9,100038,'desativado'),
(28.5,100039,'ativado'),
(22.5,100040,'desativado'),
(22.4,100041,'desativado'),
(23.5,100042,'desativado'),
(17.5,100043,'ativado'),
(25.5,100044,'desativado'),
(25.5,100045,'desativado'),
(25.9,100046,'desativado'),
(28.5,100047,'ativado'),
(18.5,100048,'desativado'),
(18.3,100049,'desativado'),
(17.5,100050,'ativado'),
(16.0,100051,'ativado');
	
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
		where fkGranja = 5;

-- 								Mostrando o nome da granja 1 e seus registros 
 select s.area_granja, r.*, g.nome_granja as 'Nome da granja do cliente'
		from sensor as s
			join registro as r on fkAreaSensor2 = idSensor  
				join granja as g on fkGranja = idGranja where fkGranja = 6 group by s.area_granja;
                
                
             --                				Nome e media das temperaturas granja 1
select s.area_granja, round(avg(r.temperaturas)), g.nome_granja
	as 'Média Temperatura Mensal' from sensor as s
		join registro as r on fkAreaSensor2 = idSensor  
		join granja as g on fkGranja = idGranja where fkGranja = 7 group by s.area_granja;
            
            
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- Dados granja 2
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------

-- 									MOSTRANDO TODOS OS DADOS DA GRANJA 2
select * from registro join sensor 	
	on fkAreaSensor2 = idSensor join granja on idGranja = fkGranja
		where fkGranja = 8;

-- 								Mostrando o nome e  registros  da granja 2
    
    select s.area_granja, r.*, g.nome_granja as 'Nome da granja do cliente'
		from sensor as s
			join registro as r on fkAreaSensor2 = idSensor  
				join granja as g on fkGranja = idGranja where fkGranja = 5 group by s.area_granja;

--                			    				Nome e media das temperaturas e area do sensor   - granja 2
select s.area_granja, round(avg(r.temperaturas)), g.nome_granja
	as 'Média Temperatura Mensal' from sensor as s
		join registro as r on fkAreaSensor2 = idSensor  
		join granja as g on fkGranja = idGranja where fkGranja = 6 group by s.area_granja;
        
            
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- Dados granja 3
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------

-- 									MOSTRANDO TODOS OS DADOS DA GRANJA 3
select * from registro join sensor 
	on fkAreaSensor2 = idSensor
		where fkGranja = 7;
        
-- 								Mostrando o nome e  registros  da granja 3
    
    select s.area_granja, r.*, g.nome_granja as 'Nome da granja do cliente'
		from sensor as s
			join registro as r on fkAreaSensor2 = idSensor  
				join granja as g on fkGranja = idGranja where fkGranja = 8 group by s.area_granja;
                
                
--                				Nome e media das temperaturas granja 3
select s.area_granja, round(avg(r.temperaturas)), g.nome_granja
	as 'Média Temperatura Mensal' from sensor as s
		join registro as r on fkAreaSensor2 = idSensor  
		join granja as g on fkGranja = idGranja where fkGranja = 5 group by s.area_granja;
        
            
-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- Dados granja 4
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------

-- 									MOSTRANDO TODOS OS DADOS DA GRANJA 4
select * from registro join sensor
	on fkAreaSensor2 = idSensor join granja
		on idGranja = fkgranja 
			where fkGranja = 6;



-- 								Mostrando o nome e  registros  da granja 4
    
    select s.area_granja, r.*, g.nome_granja as 'Nome da granja do cliente'
		from sensor as s
			join registro as r on fkAreaSensor2 = idSensor  
				join granja as g on fkGranja = idGranja where fkGranja = 7 group by s.area_granja;
        
        
        
--                				Nome e media das temperaturas granja 4
select s.area_granja, round(avg(r.temperaturas)), g.nome_granja 
	as 'Média Temperatura Mensal' from sensor as s
		join registro as r on fkAreaSensor2 = idSensor  
		join granja as g on fkGranja = idGranja where fkGranja = 8 group by s.area_granja;
                                   

            


