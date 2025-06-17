-- [SQL Server] Funções de Agregação
-- Aula 3 de 12: Função COUNT

-- 1. Faça uma consulta que retorna a contagem total de produtos. Considere a coluna ProductName para este cálculo

SELECT
	COUNT(ProductName) AS 'Qtd. Produtos'
FROM
	DimProduct

-- 2. Faça uma consulta que retorna a contagem total de produtos. Considere a coluna Size para este cálculo

SELECT
	COUNT(Size) AS 'Qtd. Produtos'
FROM
	DimProduct


-- Obs: A função COUNT não conta valores nulos da coluna, então tome cuidado com o resultado que você espera.