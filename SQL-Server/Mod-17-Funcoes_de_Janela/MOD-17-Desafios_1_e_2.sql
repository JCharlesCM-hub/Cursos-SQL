/*
MOD-17-Desafios_1_e_2-Funcoes_de_Janela

Exerc�cio Desafio 1.
Para responder os pr�ximos 2 exerc�cios, voc� precisar� criar uma View auxiliar. Diferente do que foi feito anteriormente, voc� n�o ter� acesso ao c�digo dessa view antes do gabarito.
A sua view deve se chamar vwHistoricoLojas e deve conter um hist�rico com a quantidade de lojas abertas a cada Ano/M�s. Os desafios s�o:
(1) Criar uma coluna de ID para essa View
(2) Relacionar as tabelas DimDate e DimStore
Dicas:
1- A coluna de ID ser� criada a partir de uma fun��o de janela. Voc� dever� se atentar a forma como essa coluna dever� ser ordenada, pensando que queremos visualizar uma ordem de Ano/M�s que seja: 2005/january, 2005/February... e n�o 2005/April, 2005/August...
2- As colunas Ano, M�s e Qtd_Lojas correspondem, respectivamente, �s seguintes colunas: CalendarYear e CalendarMonthLabel da tabela DimDate e uma contagem da coluna OpenDate da tabela DimStore.
*/
SELECT * FROM DimDate 
SELECT * FROM DimStore ORDER BY OpenDate

CREATE VIEW vwHistoricoLojas AS 
SELECT 
	ROW_NUMBER() OVER(ORDER BY CalendarMonth) AS 'ID', 
	CalendarYear AS 'Ano', 
	CalendarMonthLabel AS 'M�s', 
	COUNT(OpenDate) AS 'Qtd_Lojas' 
FROM DimDate 
LEFT JOIN DimStore  -- Poderia ser usado INNER mas estaria errado
	ON DimDate.DateKey = DimStore.OpenDate 
GROUP BY CalendarYear, CalendarMonthLabel, CalendarMonth 

SELECT * FROM vwHistoricoLojas 

/*
Exerc�cio Desafio 2
Neste desafio, voc� ter� que criar suas pr�prias tabelas e views para conseguir resolver os exerc�cios 7 e 8. Os pr�ximos exerc�cios envolver�o an�lises de novos clientes. Para isso, ser� necess�rio criar uma nova tabela e uma nova view.
Abaixo, temos um passo a passo para resolver o problema por partes.
PASSO 1: Crie um novo banco de dados chamado Desafio e selecione esse banco de dados criado.
*/
-- Criar o Banco de Dados(Desafio)
CREATE DATABASE Desafio
USE Desafio

/*
PASSO 2: Crie uma tabela de datas entre o dia 1 de janeiro do ano com a compra (DateFirstPurchase) mais antiga e o dia 31 de dezembro do ano com a compra mais recente.
Obs1: Chame essa tabela de Calendario.
Obs2: A princ�pio, essa tabela deve conter apenas 1 coluna, chamada data e do tipo DATE.
*/ 
SELECT * FROM ContosoRetailDW.dbo.DimCustomer
ORDER BY DateFirstPurchase
-- Criar a Tabela Calendario
CREATE TABLE Calendario (
	data DATE
)
-- Criar datas na tabela Calendario(Executar da linha 51 a 63)
DECLARE @varAnoInicial INT = YEAR((SELECT MIN(DateFirstPurchase) 
	FROM ContosoRetailDw.dbo.DimCustomer))
DECLARE @varAnoFinal INT = YEAR((SELECT MAX(DateFirstPurchase) 
	FROM ContosoRetailDw.dbo.DimCustomer))

DECLARE @varDataInicial DATE = DATEFROMPARTS(@varAnoInicial, 1, 1)
DECLARE @varDataFinal DATE = DATEFROMPARTS(@varAnoFinal, 12, 31)

WHILE @varDataFinal <= @varDataFinal
BEGIN
	INSERT INTO Calendario(Data) VALUES(@varDataInicial) 
	SET @varDataInicial = DATEADD(DAY, 1, @varDataInicial)
END
-- Verificar se foi criado
SELECT * FROM Calendario

/*
PASSO 3: Crie colunas auxiliares na tabela Calendario chamadas: Ano, Mes, Dia, AnoMes e NomeMes. Todas do tipo INT.
*/
ALTER TABLE Calendario 
ADD Ano INT,
	Mes INT, 
	Dia INT, 
	AnoMes INT, 
	NomeMes VARCHAR(50) 
-- Verificar se foi criado
SELECT * FROM Calendario

/*
PASSO 4: Adicione na tabela os valores de Ano, M�s, Dia, AnoMes e NomeMes (nome do m�s em portugu�s). Dica: utilize a instru��o CASE para verificar o m�s e retornar o nome certo.
*/  
UPDATE Calendario SET Ano = YEAR(data) 
UPDATE Calendario SET Mes = MONTH(data) 
UPDATE Calendario SET Dia = DAY(data) 
UPDATE Calendario SET AnoMes = CONCAT(YEAR(data), FORMAT(MONTH(data), '00')) 
UPDATE Calendario SET NomeMes = 
	CASE
		WHEN MONTH(data) = 1 THEN 'Janeiro' 
		WHEN MONTH(data) = 2 THEN 'Fevereiro'
		WHEN MONTH(data) = 3 THEN 'Mar�o'
		WHEN MONTH(data) = 4 THEN 'Abril'
		WHEN MONTH(data) = 5 THEN 'Maio'
		WHEN MONTH(data) = 6 THEN 'Junho'
		WHEN MONTH(data) = 7 THEN 'Julho'
		WHEN MONTH(data) = 8 THEN 'Agosto'
		WHEN MONTH(data) = 9 THEN 'Setembro'
		WHEN MONTH(data) = 10 THEN 'Outubro'
		WHEN MONTH(data) = 11 THEN 'Novembro'
		WHEN MONTH(data) = 12 THEN 'Dezembro'
	END
-- Verificar se foi criado
SELECT * FROM Calendario

/*
PASSO 5: Crie a View vwNovosClientes, que deve ter as colunas mostradas abaixo.
*/
CREATE VIEW vwNovosClientes AS 
SELECT 
	ROW_NUMBER() OVER(ORDER BY AnoMes) As 'ID', 
	Ano, 
	NomeMes, 
	COUNT(DimCustomer.DateFirstPurchase) AS 'Novos_Clientes'  
FROM Calendario 
LEFT JOIN ContosoRetailDW.dbo.DimCustomer 
	ON Calendario.data = DimCustomer.DateFirstPurchase 
Group By Ano, NomeMes, AnoMes 
-- Verificar se foi criado
SELECT * FROM vwNovosClientes





