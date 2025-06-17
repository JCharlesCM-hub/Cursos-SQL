-- [SQL Server] Funções Condicionais
-- Aula 3 de 18: CASE WHEN... ELSE (Exemplo)

-- Exemplo: Faça um SELECT das colunas CustomerKey, FirstName e Gender na tabela DimCustomer e utilize o CASE para criar uma 4ª coluna com a informação de 'Masculino' ou 'Feminino'.

SELECT * FROM DimCustomer

SELECT
	CustomerKey AS 'ID Cliente',
	FirstName AS 'Nome',
	Gender AS 'Sexo',
	CASE
		WHEN Gender = 'M' THEN 'Masculino'
		ELSE 'Feminino'
	END AS 'Sexo (CASE)'
FROM
	DimCustomer
