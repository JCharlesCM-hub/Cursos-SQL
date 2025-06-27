-- Fun��es de Janela
-- Fun��es de Classifica��o: Ranking com GROUP BY
-- Crie uma tabela com o total de vendas por regi�o e adicione uma coluna de ranking nessa tabela
USE WF

SELECT
	Regiao AS 'Regi�o',
	SUM(Qtd_Vendida) AS 'Total Vendido',
	RANK() OVER(ORDER BY SUM(Qtd_Vendida) DESC) AS 'Rank'
FROM
	Lojas
GROUP BY Regiao
ORDER BY Rank
