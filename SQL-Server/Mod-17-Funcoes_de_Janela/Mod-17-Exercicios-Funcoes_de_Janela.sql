/*
MOD-17-Exercicios-Funcoes_de_Janela

EXERC�CIOS WINDOW FUNCTIONS
Para resolver os exerc�cios 1 a 4, crie uma View chamada vwProdutos, que contenha o agrupamento das colunas BrandName, ColorName e os totais de quantidade vendida por marca/cor e tamb�m o total de receita por marca/cor.

*/
DROP VIEW vwProdutos

CREATE VIEW vwProdutos AS
SELECT
	BrandName AS 'Marca',
	ColorName AS 'Cor',
	COUNT(*) AS 'Quantidade_Vendida',
	ROUND(SUM(SalesAmount), 2) AS 'Receita_Total'
FROM DimProduct
	INNER JOIN FactSales
		ON DimProduct.ProductKey = FactSales.ProductKey
GROUP BY BrandName, ColorName

SELECT * FROM vwProdutos
ORDER BY Marca

/*
1. Utilize a View vwProdutos para criar uma coluna extra calculando a quantidade total vendida dos produtos.
*/
SELECT 
	*, 
	SUM(Quantidade_Vendida) OVER() AS 'Qtd. Total Vendida' 
FROM vwProdutos
ORDER BY Marca
/*
2. Crie mais uma coluna na consulta anterior, incluindo o total de produtos vendidos para cada marca.
*/
SELECT 
	*, 
	SUM(Quantidade_Vendida) OVER() AS 'Qtd. Total Vendida', 
	SUM(Quantidade_Vendida) OVER(PARTITION BY Marca) AS 'Qtd. Total Vendida(Por Marca)' 
FROM vwProdutos
ORDER BY Marca
/*
3. Calcule o % de participa��o do total de vendas de produtos por marca.
Ex: A marca A. Datum teve uma quantidade total de vendas de 199.041 de um total de 3.406.089 de vendas. Isso significa que a da marca A. Datum � 199.041/3.406.089 = 5,84%.
*/
SELECT 
	*, 
	SUM(Quantidade_Vendida) OVER() AS 'Qtd. Total Vendida', 
	SUM(Quantidade_Vendida) OVER(PARTITION BY Marca) AS 'Qtd. Total Vendida(Por Marca)', 
	SUM(Quantidade_Vendida) OVER(PARTITION BY Marca)/SUM(Quantidade_Vendida) OVER() AS '% Participa��o' 
FROM vwProdutos
ORDER BY Marca
-- Preencher a participa��o
SELECT 
	*, 
	SUM(Quantidade_Vendida) OVER() AS 'Qtd. Total Vendida', 
	SUM(Quantidade_Vendida) OVER(PARTITION BY Marca) AS 'Qtd. Total Vendida(Por Marca)', 
	FORMAT(1.0*SUM(Quantidade_Vendida) OVER(PARTITION BY Marca)/SUM(Quantidade_Vendida) OVER(), '0.00%') AS '% Participa��o' 
FROM vwProdutos
ORDER BY Marca

/*
4. Crie uma consulta � View vwProdutos, selecionando as colunas Marca, Cor, Quantidade_Vendida e tamb�m criando uma coluna extra de Rank para descobrir a posi��o de cada Marca/Cor. Voc� deve obter o resultado abaixo. Obs: Sua consulta deve ser filtrada para que seja mostrada apenas a marca Contoso.
*/
SELECT 
	Marca, 
	Cor, 
	Quantidade_Vendida, 
	RANK() OVER(ORDER BY Quantidade_Vendida DESC) AS 'Rank' 
FROM vwProdutos
WHERE Marca = 'Contoso'

/*
5. A partir da view criada no exerc�cio anterior, voc� dever� fazer uma soma m�vel considerando sempre o m�s atual + 2 meses para tr�s.
*/
SELECT 
	*, 
	SUM(Qtd_Lojas) OVER(ORDER BY ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) 
FROM vwHistoricoLojas
/*
6. Utilize a vwHistoricoLojas para calcular o acumulado de lojas abertas a cada ano/m�s.
*/
SELECT 
	*, 
	SUM(Qtd_Lojas) OVER(ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Acumulado'  
FROM vwHistoricoLojas

/*
7.
a) Fa�a um c�lculo de soma m�vel de novos clientes nos �ltimos 2 meses.
b) Fa�a um c�lculo de m�dia m�vel de novos clientes nos �ltimos 2 meses.
c) Fa�a um c�lculo de acumulado dos novos clientes ao longo do tempo.
d) Fa�a um c�lculo de acumulado intra-ano, ou seja, um acumulado que vai de janeiro a dezembro de cada ano, e volta a fazer o c�lculo de acumulado no ano seguinte.
*/

/*
8. Fa�a os c�lculos de MoM e YoY para avaliar o percentual de crescimento de novos clientes, entre o m�s atual e o m�s anterior, e entre um m�s atual e o mesmo m�s do ano anterior.
Solu��o
*/
-- 1.
SELECT
*,
SUM(Quantidade_Por_Produto) OVER() AS 'Qtd Total Produtos'
FROM vwProdutos
ORDER BY Marca

-- 2.
SELECT
*,
SUM(Quantidade_Por_Produto) OVER() AS 'Qtd Total Produtos',
SUM(Quantidade_Por_Produto) OVER(PARTITION BY Marca) AS 'Qtd Total Por Marca'
FROM vwProdutos
ORDER BY Marca

-- 3.
SELECT
*,
SUM(Quantidade_Por_Produto) OVER() AS 'Qtd1',
SUM(Quantidade_Por_Produto) OVER(PARTITION BY Marca) AS 'Qtd2',
FORMAT(1.0*(SUM(Quantidade_Por_Produto) OVER(PARTITION BY Marca))/SUM(Quantidade_Por_Produto) OVER(), '0.00%')
FROM vwProdutos
ORDER BY Marca

-- 4.
SELECT
*,
RANK() OVER(ORDER BY Quantidade_Por_Produto DESC) AS 'Rank'
FROM vwProdutos
WHERE Marca = 'Contoso'

-- Exerc�cio Desafio 1
CREATE VIEW vwHistoricoLojas AS
SELECT
ROW_NUMBER() OVER(ORDER BY CalendarMonth) AS 'ID',
CalendarYear AS 'Ano',
CalendarMonthLabel AS 'M�s',
COUNT(DimStore.OpenDate) AS 'Qtd_Lojas'
FROM DimDate
LEFT JOIN DimStore
ON DimDate.Datekey = DimStore.OpenDate
GROUP BY CalendarYear, CalendarMonthLabel, CalendarMonth

-- 5.
SELECT
*,
SUM(Qtd_Lojas) OVER(ORDER BY ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
FROM vwHistoricoLojas

-- 6.
SELECT
*,
SUM(Qtd_Lojas) OVER(ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM vwHistoricoLojas

-- Exerc�cio Desafio 2
--1) Passo 1: Criar o Banco de Dados Desafio
CREATE DATABASE Desafio
USE Desafio

--2) Passo 2: Criar uma tabela de datas entre o dia 1 de janeiro do ano com a primeira compra de cliente mais antiga at� o dia 31 de dezembro do ano com a �ltima compra
CREATE TABLE Calendario (
data DATE
)
DECLARE @varAnoInicial INT = YEAR((SELECT MIN(DateFirstPurchase) FROM ContosoRetailDW.dbo.DimCustomer))
DECLARE @varAnoFinal INT = YEAR((SELECT MAX(DateFirstPurchase) FROM ContosoRetailDW.dbo.DimCustomer))
DECLARE @varDataInicial DATE = DATEFROMPARTS(@varAnoInicial, 1, 1)
DECLARE @varDataFinal DATE = DATEFROMPARTS(@varAnoFinal, 12, 31)
WHILE @varDataInicial <= @varDataFinal
BEGIN
INSERT INTO Calendario(data) VALUES(@varDataInicial)
SET @varDataInicial = DATEADD(DAY, 1, @varDataInicial)
END
SELECT * FROM Calendario

--3) Passo 3: Criar colunas auxiliares na tabela Calendario
ALTER TABLE Calendario
ADD Ano INT,
Mes INT,
Dia INT,
AnoMes INT,
NomeMes VARCHAR(50)

--4) Passo 4: Adicionar os valores �s colunas
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

--5) Passo 5: Crie uma View
CREATE VIEW vwNovosClientes AS
SELECT
ROW_NUMBER() OVER(ORDER BY AnoMes) AS 'ID',
Ano,
NomeMes,
COUNT(DimCustomer.DateFirstPurchase) AS 'Novos_Clientes'
FROM Calendario
LEFT JOIN ContosoRetailDW.dbo.DimCustomer
ON Calendario.data = DimCustomer.DateFirstPurchase
GROUP BY Ano, NomeMes, AnoMes
SELECT * FROM vwNovosClientes

-- 7.
SELECT
*,
SUM(Novos_Clientes) OVER(ORDER BY ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'Soma M�vel (2 meses)',
AVG(Novos_Clientes) OVER(ORDER BY ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'M�dia M�vel (2 meses)',
SUM(Novos_Clientes) OVER(ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Acumulado Total',
SUM(Novos_Clientes) OVER(PARTITION BY Ano ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Acumulado (YTD)'
FROM vwNovosClientes

-- 8. Vai ter que dividir em duas partes para corrigir o problema do CONVERT
SELECT
*,
FORMAT(CONVERT(FLOAT, Novos_Clientes)/NULLIF(LAG(Novos_Clientes, 1) OVER(ORDER BY ID), 0) - 1, '0.00%') AS '% MoM',
FORMAT(CONVERT(FLOAT, Novos_Clientes)/NULLIF(LAG(Novos_Clientes, 12) OVER(ORDER BY ID), 0) - 1, '0.00%') AS '% YoY'
FROM vwNovosClientes

