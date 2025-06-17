-- [SQL Server] Ordenando e filtrando dados
-- Aula 4 de 27: Where (Pt. 1) - Filtrando colunas de números

-- Podemos filtrar os dados nas nossas tabelas utilizando o comando WHERE

-- Quantos produtos têm um preço unitário maior que $1000?

SELECT 
	ProductName AS Produto,
	UnitPrice AS Preco
FROM
	DimProduct
WHERE UnitPrice >= 1000