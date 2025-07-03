/* 
MOD - 25 - Triggers DDL

-- Um Trigger é um gatilho que será disparado automaticamente quando acontecer um evento.
-- Triggers podem ser disparadas por eventos DDL (CREATE, ALTER, DROP) e DML (INSERT, UPDATE, DELETE).

-- Triggers DDL
-- Uma Trigger DML é disparada quando um comando CREATE, ALTER ou DROP é executado.
*/

-- 2. Criando uma Trigger DDL simples
USE Exercicios

CREATE OR ALTER TRIGGER tgRecusarTabelas
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
	PRINT 'Não é permitido criação, alteração ou exclusão de tabelas'
	ROLLBACK  -- Para não concretizar
END

-- Executa 
CREATE TABLE teste(ID INT)

-- *************************************
-- Habilitando ou Desabilitando uma Trigger DDL
-- Disabilitando
DISABLE TRIGGER tgRecusarTabelas ON DATABASE

CREATE TABLE teste1(ID INT)

-- Habilitando
ENABLE TRIGGER tgRecusarTabelas ON DATABASE

CREATE TABLE teste2(ID INT)
DROP TABLE teste2

-- Habilitando ou Desabilitando TODAS as Triggers DDL de uma database
DISABLE TRIGGER ALL ON DATABASE

-- Excluindo uma Trigger DDL
DROP TRIGGER tgRecusarTabelas ON DATABASE

