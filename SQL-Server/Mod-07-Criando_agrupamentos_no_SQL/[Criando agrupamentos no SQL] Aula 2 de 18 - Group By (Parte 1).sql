-- [SQL Server] Criando agrupamentos no SQL
-- Aula 2 de 18: Group By (Parte 1)

SELECT * FROM DimProduct

SELECT
	BrandName AS 'Nome da Marca',
	COUNT(*) AS 'Qtd Total'
FROM
	DimProduct
GROUP BY BrandName