-- [SQL Server] [Subqueries e CTE's] Aula 9 de 28: Subquery na prática - Aplicação com o SELECT

-- Exemplo: Retornar uma tabela com todos os produtos (ID Produto e Nome Produto) e também o total de vendas para cada produto

SELECT
	ProductKey,
	ProductName,
	(SELECT COUNT(ProductKey) FROM FactSales WHERE FactSales.ProductKey = DimProduct.ProductKey) AS 'Qtd. Vendas'
FROM
	DimProduct
