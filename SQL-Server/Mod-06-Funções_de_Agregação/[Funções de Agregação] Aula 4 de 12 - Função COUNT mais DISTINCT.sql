-- [SQL Server] Funções de Agregação
-- Aula 4 de 12: Função COUNT mais DISTINCT

-- 1. Faça uma consulta que retorna a contagem distinta das marcas dos produtos

SELECT
	COUNT(DISTINCT BrandName)
FROM
	DimProduct

