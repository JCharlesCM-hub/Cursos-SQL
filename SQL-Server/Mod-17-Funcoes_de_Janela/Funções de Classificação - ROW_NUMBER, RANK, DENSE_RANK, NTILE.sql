-- Fun��es de Janela
-- Fun��es de Classifica��o: ROW_NUMBER, RANK, DENSE_RANK, NTILE
SELECT
	*,
	ROW_NUMBER() OVER(ORDER BY Qtd_Vendida DESC) AS 'rownumber',
	RANK() OVER(ORDER BY Qtd_Vendida DESC) AS 'rank',
	DENSE_RANK() OVER(ORDER BY Qtd_Vendida DESC) AS 'dense',
	NTILE(3) OVER(ORDER BY Qtd_Vendida DESC) AS 'ntile'
FROM
	Lojas
WHERE Regiao = 'Sudeste'
--ORDER BY Qtd_Vendida DESC
