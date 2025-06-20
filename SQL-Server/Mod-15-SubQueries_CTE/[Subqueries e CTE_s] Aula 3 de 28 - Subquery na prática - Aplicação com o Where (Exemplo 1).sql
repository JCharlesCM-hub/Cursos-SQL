-- [SQL Server] [Subqueries e CTE's] Aula 3 de 28: Subquery na prática - Aplicação com o Where (Exemplo 1)

-- Para entender a ideia por trás das subqueries, vamos começar fazendo 3 exemplos com a aplicação WHERE.

-- Exemplo 1: Quais produtos da tabela DimProduct possuem custos acima da média?

SELECT AVG(UnitCost) FROM DimProduct     -- 147.6555

SELECT
	*
FROM
	DimProduct
WHERE UnitCost >= (SELECT AVG(UnitCost) FROM DimProduct)