-- [SQL Server] Funções Condicionais
-- Aula 10 de 18: ISNULL - Tratando valores nulos

-- Exemplo: Existem 3 tipos de estoque: High, Mid e Low. Faça um SELECT contendo as colunas de ProductKey, ProductName, StockTypeName e Nome do responsável pelo produto, de acordo com o tipo de estoque. A regra deverá ser a seguinte:
-- João é responsável pelos produtos High
-- Maria é responsável pelos produtos Mid
-- Luis é responsável pelos produtos Low

SELECT
	ProductKey,
	ProductName,
	iif(
		StockTypeName = 'High',
		'João',
		IIF(
			StockTypeName = 'Mid',
			'Maria',
			'Luis')
			) AS 'Responsável'

FROM
	DimProduct