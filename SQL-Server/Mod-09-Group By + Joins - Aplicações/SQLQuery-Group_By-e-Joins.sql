/*
M�DULO 8: EXERC�CIOS
Os exerc�cios abaixo est�o divididos de acordo com uma determinada tabela do Banco de Dados. Voc� pode utilizar o INNER JOIN para resolver todas as quest�es.
FACT SALES
1.a) Fa�a um resumo da quantidade vendida (Sales Quantity) de acordo com o nome do canal de vendas (ChannelName). Voc� deve ordenar a tabela final de acordo com SalesQuantity, em ordem decrescente.
*/
SELECT TOP(10) * FROM FactSales
SELECT TOP(10) * FROM DimChannel

SELECT 
	channelName AS 'Canal de Venda', 
	SUM(SalesQuantity) AS 'Total Vendido'
FROM 
	FactSales 
INNER JOIN DimChannel 
	ON FactSales.channelKey = DimChannel.ChannelKey
GROUP BY ChannelName 
ORDER BY SUM(SalesQuantity) DESC

/*

1.b) Fa�a um agrupamento mostrando a quantidade total vendida (Sales Quantity) e quantidade total devolvida (Return Quantity) de acordo com o nome das lojas (StoreName).
*/
SELECT TOP(10) * FROM FactSales
SELECT TOP(10) * FROM DimStore

SELECT 
	StoreName AS 'Loja', 
	SUM(SalesQuantity) AS 'Total Vendido', 
	SUM(ReturnQuantity) AS 'Total Devolvido'
FROM 
	FactSales 
INNER JOIN DimStore 
	ON FactSales.StoreKey = DimStore.StoreKey
GROUP BY storeName 
ORDER BY storeName 
/*

1.c) Fa�a um resumo do valor total vendido (Sales Amount) para cada m�s (CalendarMonthLabel) e ano (CalendarYear).
*/
SELECT TOP(10) * FROM FactSales
SELECT TOP(10) * FROM DimDate

SELECT 
	CalendarYear AS 'Ano', 
	CalendarMonthLabel AS 'M�s', 
	SUM(SalesAmount) AS 'Faturamento Total'
FROM 
	FactSales 
INNER JOIN DimDate 
	ON FactSales.DateKey = DimDate.Datekey
GROUP BY CalendarYear, CalendarMonthLabel, CalendarMonth
ORDER BY CalendarMonth ASC
/*

2. Voc� precisa fazer uma an�lise de vendas por produtos. O objetivo final � descobrir o valor total vendido (SalesQuantity) por produto.
2.a) Descubra qual � a cor de produto que mais � vendida (de acordo com SalesQuantity).
*/
SELECT TOP(10) * FROM FactSales
SELECT TOP(10) * FROM DimProduct

SELECT 
	ColorName AS 'Cor', 
	SUM(SalesQuantity) AS 'Qt. Vendida' 
FROM 
	FactSales 
INNER JOIN DimProduct 
	ON FactSales.ProductKey = DimProduct.ProductKey
GROUP BY ColorName
ORDER BY SUM(SalesQuantity) DESC
/*

2.b) Quantas cores tiveram uma quantidade vendida acima de 3.000.000.
*/
SELECT 
	ColorName AS 'Cor', 
	SUM(SalesQuantity) AS 'Qt. Vendida' 
FROM 
	FactSales 
INNER JOIN DimProduct 
	ON FactSales.ProductKey = DimProduct.ProductKey
GROUP BY ColorName
HAVING SUM(SalesQuantity) >= 3000000 
ORDER BY SUM(SalesQuantity) DESC
/*

3. Crie um agrupamento de quantidade vendida (SalesQuantity) por categoria do produto (ProductCategoryName). Obs: Voc� precisar� fazer mais de 1 INNER JOIN, dado que a rela��o entre FactSales e DimProductCategory n�o � direta.
FACTONLINESALES
*/
SELECT TOP(10) * FROM FactSales
SELECT TOP(10) * FROM DimProduct
SELECT TOP(10) * FROM DimProductSubcategory
SELECT TOP(10) * FROM DimProductCategory

SELECT 
	ProductCategoryName AS 'Categoria', 
	SUM(SalesQuantity) AS 'Qt. Vendida' 
FROM 
	FactSales 
INNER JOIN DimProduct 
	ON FactSales.ProductKey = DimProduct.ProductKey 
		INNER JOIN DimProductSubcategory 
			ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey 
				INNER JOIN DimProductCategory
					ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey 
GROUP BY ProductCategoryName
/*

4.a) Voc� deve fazer uma consulta � tabela FactOnlineSales e descobrir qual � o nome completo do cliente que mais realizou compras online (de acordo com a coluna SalesQuantity).
*/
SELECT TOP(10) * FROM FactOnlineSales
SELECT TOP(10) * FROM DimCustomer

SELECT 
	DimCustomer.CustomerKey, 
	FirstName AS 'Nome' , 
	LastName AS 'Sobrenome', 
	SUM(SalesQuantity) AS 'Qtd. Vendida'  
FROM 
	FactOnlineSales 
INNER JOIN DimCustomer 
	ON FactOnlineSales.CustomerKey = DimCustomer.CustomerKey
WHERE CustomerType = 'Person' 
GROUP BY DimCustomer.CustomerKey, FirstName, LastName 
ORDER BY SUM(SalesQuantity) DESC
/*

4.b) Feito isso, fa�a um agrupamento de produtos e descubra quais foram os top 10 produtos mais comprados pelo cliente da letra a, considerando o nome do produto.
*/
SELECT TOP(10)
	ProductName AS 'Sobrenome', 
	SUM(SalesQuantity) AS 'Qtd. Vendida'  
FROM 
	FactOnlineSales 
INNER JOIN DimProduct 
	ON FactOnlineSales.ProductKey = DimProduct.ProductKey
WHERE CustomerKey = 7665  
GROUP BY ProductName 
ORDER BY SUM(SalesQuantity) DESC

/*

5. Fa�a um resumo mostrando o total de produtos comprados (Sales Quantity) de acordo com o sexo dos clientes.
FACTEXCHANGERATE
*/
SELECT 
	Gender AS 'Sexo',
	SUM(SalesQuantity) AS 'Qtd. Vendida'  
FROM 
	FactOnlineSales 
INNER JOIN DimCustomer 
	ON FactOnlineSales.CustomerKey = DimCustomer.CustomerKey
WHERE Gender IS NOT NULL  -- Sem essa condi��o vem as empresas 
GROUP BY Gender 
/*

6. Fa�a uma tabela resumo mostrando a taxa de c�mbio m�dia de acordo com cada CurrencyDescription. A tabela final deve conter apenas taxas entre 10 e 100.
FACTSTRATEGYPLAN
*/
SELECT TOP(10) * FROM FactExchangeRate
SELECT TOP(10) * FROM DimCurrency

SELECT 
	CurrencyDescription,
	AVG(AverageRate) AS 'Taxa M�dia'   
FROM 
	FactExchangeRate 
INNER JOIN DimCurrency 
	ON FactExchangeRate.CurrencyKey = DimCurrency.CurrencyKey
GROUP BY CurrencyDescription
HAVING AVG(AverageRate) BETWEEN 10 AND 100
/*

7. Calcule a SOMA TOTAL de AMOUNT referente � tabela FactStrategyPlan destinado aos cen�rios: Actual e Budget.
Dica: A tabela DimScenario ser� importante para esse exerc�cio.
*/
SELECT TOP(10) * FROM FactStrategyPlan
SELECT TOP(10) * FROM DimScenario
-- Usando <>
SELECT 
	ScenarioName AS 'Cenario',
	SUM(Amount) AS 'Total' 
FROM 
	FactStrategyPlan 
INNER JOIN DimScenario 
	ON FactStrategyPlan.ScenarioKey = DimScenario.ScenarioKey
GROUP BY ScenarioName
HAVING ScenarioName <> 'Forecast'

-- Usando IN
SELECT 
	ScenarioName AS 'Cenario',
	SUM(Amount) AS 'Total' 
FROM 
	FactStrategyPlan 
INNER JOIN DimScenario 
	ON FactStrategyPlan.ScenarioKey = DimScenario.ScenarioKey
GROUP BY ScenarioName
HAVING ScenarioName IN ('Actual', 'Budget')
/*

8. Fa�a uma tabela resumo mostrando o resultado do planejamento estrat�gico por ano.
DIMPRODUCT/DIMPRODUCTSUBCATEGORY
*/
SELECT TOP(10) * FROM FactStrategyPlan
SELECT TOP(10) * FROM DimDate

SELECT 
	CalendarYear AS 'Ano',
	SUM(Amount) AS 'Total' 
FROM 
	FactStrategyPlan 
INNER JOIN DimDate 
	ON FactStrategyPlan.Datekey = DimDate.Datekey
GROUP BY CalendarYear
/*

9. Fa�a um agrupamento de quantidade de produtos por ProductSubcategoryName. Leve em considera��o em sua an�lise apenas a marca Contoso e a cor Silver.
*/
SELECT 
	ProductSubcategoryName AS 'SubCategoria',
	COUNT(*) AS 'Qtd. Produtos'  
FROM 
	DimProduct 
INNER JOIN DimProductSubcategory  
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey 
GROUP BY ProductSubcategoryName 
-- Com filtro WHERE
SELECT 
	ProductSubcategoryName AS 'SubCategoria',
	COUNT(*) AS 'Qtd. Produtos'  
FROM 
	DimProduct 
INNER JOIN DimProductSubcategory  
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey 
WHERE BrandName = 'Contoso' AND ColorName = 'Silver' 
GROUP BY ProductSubcategoryName 

/*

10. Fa�a um agrupamento duplo de quantidade de produtos por BrandName e ProductSubcategoryName. A tabela final dever� ser ordenada de acordo com a coluna BrandName.
*/
SELECT 
	BrandName AS 'Marca',
	ProductSubcategoryName AS 'SubCategoria', 
	COUNT(*) AS 'Qtd. Produtos'  
FROM 
	DimProduct 
INNER JOIN DimProductSubcategory  
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey 
GROUP BY BrandName, ProductSubcategoryName 
ORDER BY BrandName ASC

