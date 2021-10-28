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
    REFERENCES cliente (idCliente)
    );


insert into granja(nome_granja,estado,cnpj,cep,rua,bairro,numero_propiedade,fkCliente) values
('Galinha Feliz','SP',12345678912345,12345678,'Rua das laranjeiras','Rosas Claras',0345,1),
('Branco e Amarelo','MG',12345678942345,12345671,'Rua General Ozorio','Rio das Ostras',0234,2),
('Chiken egg','SP',1234567893456,12345672,'Rua Marcos Claricio','Rio Claro',0532,3),
('Chocadeira','RS',1234567894567,12345673,'Rua Santa Luzia','Folha Seca',0242,4);

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
)
AUTO_INCREMENT = 100000;

insert into sensor(area_granja,status_sensor,fkGranja) values
('A','funcionando',1),
('B','funcionando',1),
('C','funcionando',1),
('D','funcionando',1),
('A','funcionando',2),
('B','funcionando',2),
('C','funcionando',2),
('D','funcionando',2),
('C','funcionando',2),
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
  dia DATETIME  DEFAULT CURRENT_TIMESTAMP,
  temperaturas FLOAT ,
  fkAreaSensor2 INT ,
   FOREIGN KEY (fkAreaSensor2)
    REFERENCES sensor (idSensor),
  alerta VARCHAR(45) constraint check_alerta check(alerta='ativado' or alerta='desativado')
    );


insert into registro (temperaturas,fkAreaSensor2,alerta) values
(25.5,100000,'desativado'),
(25.5,100001,'desativado'),
(25.9,100003,'desativado'),
(28.5,100004,'ativado'),
(22.5,100005,'desativado'),
(22.4,100006,'desativado'),
(23.5,100007,'desativado'),
(17.5,100008,'ativado'),
(25.5,100009,'desativado'),
(25.5,100010,'desativado'),
(25.9,100011,'desativado'),
(28.5,100012,'ativado'),
(18.5,100013,'desativado'),
(18.3,100014,'desativado'),
(17.5,100015,'ativado'),
(16.0,100016,'ativado');
	
select * from  cliente;
select * from  sensor;
select * from  granja;
select * from  registro;

-- --------------------------------------------------------------------------------------------------------------------------------------------------------
-- Dados granja 1
-- ---------------------------------------------------------------------------------------------------------------------------------------------------------

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
                                   

            


