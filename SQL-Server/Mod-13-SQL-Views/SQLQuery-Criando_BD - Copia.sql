/*
-- Criando nosso Banco de Dados, atualizar para vê a alteração
$ CREATE DATABASE TESTE


-- Deletando nosso Banco de Dados, atualizar para vê a alteração
$ DROP DATABASE TESTE
*/

-- ++++++++++++++++++++++++++
-- CRIAR NOSSO BANCO DE DADOS PARA ESSE MÓDULO
-- $ CREATE DATABASE BDImpressionador

-- ++++++++++++++++++++++++++
USE BDImpressionador

-- CREATE TABLE nome_tabela(
--		coluna1 tipo1,
--		coluna1 tipo1,
--		coluna1 tipo1 
-- )

CREATE TABLE Produtos(
	id_produto int,
	nome_produto VARCHAR(200), 
	data_validade DATETIME, 
	preco_produto FLOAT 
)

SELECT * FROM Produtos

-- +++++++++++++++++++++++
-- Adicionar Dados na Tabela Produtos

INSERT INTO Produtos(
	id_produto, 
	nome_produto, 
	data_validade, 
	preco_produto 
)
SELECT
	ProductKey, 
	ProductName, 
	AvailableForSaleDate, 
	UnitPrice 
FROM 
	ContosoRetailDW.dbo.DimProduct

-- Seleciona os primeros linha da tabela Produtos
SELECT TOP(50) * FROM Produtos where id_produto = 1
	
-- Insere linhas na tabela Produtos
INSERT INTO Produtos(id_produto, nome_produto, data_validade, preco_produto)
VALUES
	(1, 'Arroz', '31/12/2021', 22.50), 
	(2, 'Feijão', '20/11/2022', 8.99)

-- Seleciona os Produtos com indice 1(duplicados)
SELECT TOP(50) * FROM Produtos where id_produto = 1

-- Inserindo fora da ordem e sem informar campos
INSERT INTO Produtos(data_validade, id_produto,  preco_produto)
VALUES
	('31/12/2021', 3, 11.45) 

-- Seleciona os Produtos com indice 1(duplicados)
SELECT TOP(50) * FROM Produtos where id_produto IN(1, 2, 3) 

-- Alterando campo de uma tabela
UPDATE Produtos 
	SET nome_produto = 'Macarrão' 
WHERE	
	id_produto = 3

-- Deletar registro
DELETE
FROM Produtos 
WHERE id_produto = 3