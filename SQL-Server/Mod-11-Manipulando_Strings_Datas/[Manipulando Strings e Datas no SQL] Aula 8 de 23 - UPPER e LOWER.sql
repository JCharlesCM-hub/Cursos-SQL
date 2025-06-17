-- [SQL Server] Manipulando Strings e Datas no SQL
-- Aula 8 de 23: UPPER e LOWER

-- UPPER ---> Transforma um texto em maiúscula
-- LOWER ---> Transforma um texto em minúscula
-- Exemplo: Faça uma consulta à tabela DimCustomer e utilize as funções UPPER e LOWER na coluna de FirstName para observar o resultado

SELECT * FROM DimCustomer
SELECT
	UPPER(FirstName) AS 'NOME',
	LOWER(FirstName) AS 'nome',
	EmailAddress AS 'E-mail'
FROM
	DimCustomer
