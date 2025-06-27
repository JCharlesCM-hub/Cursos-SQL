-- Funções de Janela
-- Funções de Classificação: ROW_NUMBER, RANK, DENSE_RANK, NTILE
SELECT
	*,
	ROW_NUMBER() OVER(PARTITION BY Regiao ORDER BY Qtd_Vendida DESC) AS 'rownumber',
	RANK() OVER(PARTITION BY Regiao ORDER BY Qtd_Vendida DESC) AS 'rank',
	DENSE_RANK() OVER(PARTITION BY Regiao ORDER BY Qtd_Vendida DESC) AS 'dense',
	NTILE(3) OVER(PARTITION BY Regiao ORDER BY Qtd_Vendida DESC) AS 'ntile'
FROM
	Lojas
--ORDER BY Qtd_Vendida DESC
