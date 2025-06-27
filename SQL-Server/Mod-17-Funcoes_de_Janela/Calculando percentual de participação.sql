-- MOD-17 - Funcoes_de_Janela

-- Funções de Janela
-- CÁLCULO DO PERCENTUAL TOTAL
-- a) Calcule o % de participação de cada loja em relação ao total de vendas de todas as lojas.
SELECT 
	ID_Loja,
	Nome_Loja,
	Regiao,
	Qtd_Vendida,
	SUM(Qtd_Vendida) OVER() AS 'Total Vendido',
	FORMAT(Qtd_Vendida/SUM(Qtd_Vendida) OVER(), '0.00%') AS '% Por Região'
FROM Lojas
ORDER BY ID_Loja

-- b) Calcule o % de participacao de cada loja em relação ao total de vendas de cada região.
SELECT 
	ID_Loja,
	Nome_Loja,
	Regiao,
	Qtd_Vendida,
	SUM(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'Total Vendido',
	FORMAT(Qtd_Vendida/SUM(Qtd_Vendida) OVER(PARTITION BY Regiao), '0.00%') AS '% Por Região'
FROM Lojas
ORDER BY ID_Loja
