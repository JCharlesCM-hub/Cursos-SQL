-- Funções de Janela
-- FUNÇÕES DE OFFSET (Deslocamento): LAG e LEAD
USE WF

SELECT
	Data_Fechamento AS 'Data do Fechamento',
	Faturamento_MM AS 'Faturamento Total (em milhões)',
	LAG(Faturamento_MM, 1, 0) OVER(ORDER BY Data_Fechamento) AS 'Fat. Mês Anterior',
	LEAD(Faturamento_MM, 1, 0) OVER(ORDER BY Data_Fechamento) AS 'Fat. Mês Seguinte'
FROM Resultado
ORDER BY [Data do Fechamento]
