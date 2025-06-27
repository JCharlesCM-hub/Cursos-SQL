-- Funções de Janela
-- FUNÇÕES DE OFFSET (Deslocamento): FIRST_VALUE e LAST_VALUE
SELECT
	Data_Fechamento AS 'Data do Fechamento',
	Faturamento_MM AS 'Faturamento Total (em milhões)',
	FIRST_VALUE(Faturamento_MM) OVER(ORDER BY Data_Fechamento) AS 'Primeiro valor',
	LAST_VALUE(Faturamento_MM) OVER(ORDER BY Data_Fechamento ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS 'Último valor'
FROM Resultado
ORDER BY [Data do Fechamento]
