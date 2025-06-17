-- [SQL Server] Criando agrupamentos no SQL
-- Aula 4 de 18: Group By + Order By


--SELECT * FROM DimStore

SELECT
	StoreType,
	SUM(EmployeeCount) AS 'Qtd. Total Funcionários'
FROM
	DimStore
GROUP BY StoreType
ORDER BY SUM(EmployeeCount) DESC
