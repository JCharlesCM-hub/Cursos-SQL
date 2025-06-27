-- Funções de Janela
-- Cálculo de soma móvel e média móvel
USE WF

CREATE TABLE Resultado(
Data_Fechamento DATETIME,
Faturamento_MM FLOAT)


INSERT INTO Resultado(Data_Fechamento, Faturamento_MM)
VALUES
	('01/01/2020', 8),
	('01/02/2020', 10),
	('01/03/2020', 6),
	('01/04/2020', 9),
	('01/05/2020', 5),
	('01/06/2020', 4),
	('01/07/2020', 7),
	('01/08/2020', 11),
	('01/09/2020', 9),
	('01/10/2020', 12),
	('01/11/2020', 11),
	('01/12/2020', 10)

SELECT * FROM Resultado


-- Soma acumulada
SELECT
	Data_Fechamento AS 'Data do Fechamento',
	Faturamento_MM AS 'Faturamento Total (em milhões)',
	SUM(Faturamento_MM) OVER(ORDER BY Data_Fechamento ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Fat. Acumulado (em milhões)'
FROM Resultado
ORDER BY [Data do Fechamento]

-- Média acumulada
SELECT
	Data_Fechamento AS 'Data do Fechamento',
	Faturamento_MM AS 'Faturamento Total (em milhões)',
	AVG(Faturamento_MM) OVER(ORDER BY Data_Fechamento ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Fat. Acumulado (em milhões)'
FROM Resultado
ORDER BY [Data do Fechamento]

-- Acumulado
SELECT
	Data_Fechamento, 
--	Mes_Ano,
	Faturamento_MM, 
	SUM(Faturamento_MM) OVER(ORDER BY Data_Fechamento ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING) AS 'Soma Móvel'
FROM Resultado














