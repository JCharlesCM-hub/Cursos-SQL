/*
MÓDULO 8: EXERCÍCIOS
Os exercícios abaixo estão divididos de acordo com uma determinada tabela do Banco de Dados. Você pode utilizar o INNER JOIN para resolver todas as questões.
FACT SALES
1.a) Faça um resumo da quantidade vendida (Sales Quantity) de acordo com o nome do canal de vendas (ChannelName). Você deve ordenar a tabela final de acordo com SalesQuantity, em ordem decrescente.
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

1.b) Faça um agrupamento mostrando a quantidade total vendida (Sales Quantity) e quantidade total devolvida (Return Quantity) de acordo com o nome das lojas (StoreName).
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

1.c) Faça um resumo do valor total vendido (Sales Amount) para cada mês (CalendarMonthLabel) e ano (CalendarYear).
*/
SELECT TOP(10) * FROM FactSales
SELECT TOP(10) * FROM DimDate

SELECT 
	CalendarYear AS 'Ano', 
	CalendarMonthLabel AS 'Mês', 
	SUM(SalesAmount) AS 'Faturamento Total'
FROM 
	FactSales 
INNER JOIN DimDate 
	ON FactSales.DateKey = DimDate.Datekey
GROUP BY CalendarYear, CalendarMonthLabel, CalendarMonth
ORDER BY CalendarMonth ASC
/*

2. Você precisa fazer uma análise de vendas por produtos. O objetivo final é descobrir o valor total vendido (SalesQuantity) por produto.
2.a) Descubra qual é a cor de produto que mais é vendida (de acordo com SalesQuantity).
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

3. Crie um agrupamento de quantidade vendida (SalesQuantity) por categoria do produto (ProductCategoryName). Obs: Você precisará fazer mais de 1 INNER JOIN, dado que a relação entre FactSales e DimProductCategory não é direta.
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

4.a) Você deve fazer uma consulta à tabela FactOnlineSales e descobrir qual é o nome completo do cliente que mais realizou compras online (de acordo com a coluna SalesQuantity).
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

4.b) Feito isso, faça um agrupamento de produtos e descubra quais foram os top 10 produtos mais comprados pelo cliente da letra a, considerando o nome do produto.
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

5. Faça um resumo mostrando o total de produtos comprados (Sales Quantity) de acordo com o sexo dos clientes.
FACTEXCHANGERATE
*/
SELECT 
	Gender AS 'Sexo',
	SUM(SalesQuantity) AS 'Qtd. Vendida'  
FROM 
	FactOnlineSales 
INNER JOIN DimCustomer 
	ON FactOnlineSales.CustomerKey = DimCustomer.CustomerKey
WHERE Gender IS NOT NULL  -- Sem essa condição vem as empresas 
GROUP BY Gender 
/*

6. Faça uma tabela resumo mostrando a taxa de câmbio média de acordo com cada CurrencyDescription. A tabela final deve conter apenas taxas entre 10 e 100.
FACTSTRATEGYPLAN
*/
SELECT TOP(10) * FROM FactExchangeRate
SELECT TOP(10) * FROM DimCurrency

SELECT 
	CurrencyDescription,
	AVG(AverageRate) AS 'Taxa Média'   
FROM 
	FactExchangeRate 
INNER JOIN DimCurrency 
	ON FactExchangeRate.CurrencyKey = DimCurrency.CurrencyKey
GROUP BY CurrencyDescription
HAVING AVG(AverageRate) BETWEEN 10 AND 100
/*

7. Calcule a SOMA TOTAL de AMOUNT referente à tabela FactStrategyPlan destinado aos cenários: Actual e Budget.
Dica: A tabela DimScenario será importante para esse exercício.
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

8. Faça uma tabela resumo mostrando o resultado do planejamento estratégico por ano.
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

9. Faça um agrupamento de quantidade de produtos por ProductSubcategoryName. Leve em consideração em sua análise apenas a marca Contoso e a cor Silver.
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

10. Faça um agrupamento duplo de quantidade de produtos por BrandName e ProductSubcategoryName. A tabela final deverá ser ordenada de acordo com a coluna BrandName.
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

