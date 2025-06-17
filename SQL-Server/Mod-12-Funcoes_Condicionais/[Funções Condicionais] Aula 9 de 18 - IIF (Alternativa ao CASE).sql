-- [SQL Server] Funções Condicionais
-- Aula 9 de 18: IIF (Alternativa ao CASE)

-- Exemplo 1: Qual é a categoria de risco do projeto abaixo, de acordo com a sua nota:
-- Risco Alto: Classicacao >= 5
-- Risco Baixo: Classificacao < 5

DECLARE @varClassificacao int
set @varClassificacao = 9

SELECT
	IIF(
		@varClassificacao >= 5,
		'Risco Alto',
		'Risco Baixo'
		)


-- Exemplo 2: Crie uma coluna única de 'Cliente', contendo o nome do cliente, seja ele uma pessoa ou uma empresa. Traga também a coluna de CustomerKey e CustomerType.

SELECT * FROM DimCustomer

SELECT
	CustomerKey,
	CustomerType,
	IIF(
		CustomerType = 'Person',
		FirstName,
		CompanyName) AS 'Cliente'
FROM
	DimCustomer
