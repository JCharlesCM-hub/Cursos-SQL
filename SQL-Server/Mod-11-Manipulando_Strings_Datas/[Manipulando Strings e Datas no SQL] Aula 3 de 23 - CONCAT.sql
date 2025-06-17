-- [SQL Server] Manipulando Strings e Datas no SQL
-- Aula 3 de 23: CONCAT

-- CONCAT ---> Permite juntar mais de um texto em uma única palavra
-- Exemplo: Faça uma consulta à tabela DimCustomer onde seja possível visualizar o nome completo de cada cliente.

SELECT
	FirstName AS 'Nome',
	LastName AS 'Sobrenome',
	EmailAddress AS 'E-mail',
	CONCAT(FirstName, ' ', LastName) AS 'Nome Completo'
FROM
	DimCustomer
