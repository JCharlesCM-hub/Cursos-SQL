-- [SQL Server] Funções de Agregação
-- Aula 2 de 12: Função SUM

-- 1. Faça uma consulta que retorna a soma total de SalesQuantity e a soma total de ReturnQuantity.

SELECT
	SUM(SalesQuantity) AS 'Total Vendido',
	SUM(ReturnQuantity) AS 'Total Devolvido'
FROM
	FactSales