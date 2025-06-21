-- [SQL Server] CRUD
-- Aula 14 de 21 - ALTER TABLE

-- ALTER TABLE: Adicionando, deletar ou modificar tipo de dados de uma coluna

-- Adicionar coluna:

ALTER TABLE Funcionarios
ADD cargo varchar(100), bonus decimal(10,2)

UPDATE Funcionarios
SET cargo = 'Analista'
WHERE id_funcionario = 1
SELECT * FROM Funcionarios


-- Alterar tipo de dados de uma coluna:

ALTER TABLE Funcionarios
ALTER COLUMN salario int

-- Deletar coluna:

ALTER TABLE Funcionarios
DROP COLUMN cargo, bônus
