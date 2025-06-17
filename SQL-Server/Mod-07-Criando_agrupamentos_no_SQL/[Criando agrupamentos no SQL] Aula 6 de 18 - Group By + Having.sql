-- [SQL Server] Criando agrupamentos no SQL
-- Aula 6 de 18: Group By + Having

--SELECT * FROM DimProduct

SELECT
	BrandName AS 'Marca',
	COUNT(BrandName) AS 'Total Marca'
FROM
	DimProduct
GROUP BY BrandName

HAVING COUNT(BrandName) >= 200

