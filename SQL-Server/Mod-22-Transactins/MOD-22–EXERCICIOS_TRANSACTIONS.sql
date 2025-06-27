/*
MÓDULO 22 – EXERCÍCIOS TRANSACTIONS

1. Crie uma tabela chamada Carro com os dados abaixo.
Obs: não se preocupe com constraints, pode criar uma tabela simples.
*/
DROP DATABASE AlugaFacil
CREATE DATABASE AlugaFacil
USE AlugaFacil

SELECT * FROM Carro

CREATE TABLE Carro(
	id_carro INT IDENTITY(1, 1), 
	placa VARCHAR(100) NOT NULL, 
	modelo VARCHAR(100) NOT NULL, 
	tipo VARCHAR(100) NOT NULL, 
	CONSTRAINT carro_id_carro_pk PRIMARY KEY(id_carro),
	CONSTRAINT carro_placa_un UNIQUE(placa), 
	CONSTRAINT carro_tipo_ck CHECK(tipo IN('Hatch', 'SUV', 'Sedan'))
)

INSERT INTO Carro(placa, modelo, tipo) VALUES
	('ABC-123', 'Hyundai HB20', 'Sedan'), 
	('DAS-1412', 'Fiat Cronos', 'Sedan'), 
	('JHG-3902', 'Hyundai HB20', 'Hatch'), 
	('IPW-9018', 'Citroen C4', 'SUV'), 
	('JKR-8891', 'Nissa Kicks', 'SUV'), 
	('TRF-5934', 'Chevrolet Onix Joy', 'Sedan')

SELECT * FROM Carro

/*
2. Execute as seguintes transações no banco de dados, sempre na tabela Carro. Lembre-se de dar um COMMIT para efetivar cada uma das transações.
a) Inserir uma nova linha com os seguintes valores:
id_carro = 6
placa = CDR-0090
modelo = Fiat Argo
tipo = Hatch
*/ 
BEGIN TRANSACTION 
INSERT INTO Carro(placa, modelo, tipo) 
	VALUES ('DFG-124', 'Hyundai HB30', 'Hatch')  
COMMIT 

SELECT * FROM Carro
/*
b) Atualizar o tipo do carro de id = 1 de Hatch para Sedan.
*/  
BEGIN TRANSACTION 
UPDATE Carro 
	SET tipo = 'Hatch' 
	WHERE id_carro = 1
COMMIT 

SELECT * FROM Carro

/*
c) Deletar a linha referente ao carro de id = 6.
*/
BEGIN TRANSACTION 
DELETE FROM Carro 
	WHERE id_carro = 6
COMMIT 

SELECT * FROM Carro