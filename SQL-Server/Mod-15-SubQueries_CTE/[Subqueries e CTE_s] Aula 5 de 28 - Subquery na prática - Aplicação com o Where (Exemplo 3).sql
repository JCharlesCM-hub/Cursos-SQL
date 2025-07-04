-- [SQL Server] [Subqueries e CTE's] Aula 5 de 28: Subquery na pr�tica - Aplica��o com o Where (Exemplo 3)

-- Para entender a ideia por tr�s das subqueries, vamos come�ar fazendo 3 exemplos com a aplica��o WHERE.

-- Exemplo 3: Filtre a tabela FactSales e mostre apenas as vendas referentes �s lojas com 100 ou mais funcion�rios

SELECT * FROM FactSales
WHERE StoreKey IN (
	SELECT	StoreKey
	FROM DimStore
	WHERE EmployeeCount >= 100
)
