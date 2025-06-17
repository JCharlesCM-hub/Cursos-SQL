-- [SQL Server] Criando agrupamentos no SQL
-- Aula 5 de 18: Group By + Where


SELECT * FROM DimProduct

SELECT
	ColorName AS 'Cor do Produto',
	COUNT(ColorName) AS 'Qtd. Total'
FROM
	DimProduct
WHERE BrandName = 'Contoso'
GROUP BY ColorName
