-- [SQL Server] Funções de Agregação
-- Aula 5 de 12: Funções MIN e MAX

-- 1. Faça uma consulta que retorna os valores máximo e mínimo de UnitCost.

SELECT
	MAX(UnitCost) AS 'Custo Máximo',
	MIN(UnitCost) AS 'Custo Mínimo'
FROM
	DimProduct

