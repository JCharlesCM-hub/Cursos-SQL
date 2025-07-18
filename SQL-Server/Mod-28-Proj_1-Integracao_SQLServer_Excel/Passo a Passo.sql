/*
MOD - 28 - Projeto 01 - Integra��o SQL SERVER e EXCEL
1� - Baixar o Banco de Dados de Teste 
	- Pesquisar: Bancos de dados de exemplo do AdventureWorks
	- Baixar a Vers�o: AdventureWorksDW2014.bak

2� - Gravar/Salvar o BD no Local
	F:\MeusArq\Cursos\SQL-Impressionador\BD\SQL-MS-AdentureWorks2014

3� - No SSMS 
	- Clicar em Bancos de Dados(bot�o direito)
		- Restaurar Bancos de Dados...
			F:\MeusArq\Cursos\SQL-Impressionador\BD\SQL-MS-AdentureWorks2014
			- ok... ok... ok...

*/
-- ##################################################
--     PROJETO DE INTEGRA��O SQL SERVER e EXCEL
-- ##################################################

-- 1. Apresenta��o
-- 2. Download Banco de Dados AdventureWorks 2014

/*
https://docs.microsoft.com/pt-br/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms
*/

-- 3. Definindo os indicadores do projeto
-- i) Total de Vendas Internet por Categoria do Produto
-- ii) Receita Total Internet por M�s do Pedido
-- iii) Receita e Custo Total Internet por Pa�s
-- iv) Total de Vendas Internet por Sexo do Cliente

-- OBS: O ANO DE AN�LISE SER� APENAS 2013 (ANO DO PEDIDO)
USE AdventureWorksDW2014

SELECT * FROM FactInternetSales
SELECT * FROM DimProductSubCategory
SELECT * FROM DimSalesTerritory
SELECT * FROM DimProduct

-- 4. Definindo as tabelas a serem analisadas
-- TABELA 1: FactInternetSales
-- TABELA 2: DimCustomer
-- TABELA 3: DimSalesTerritory
-- TABELA 4: DimProductCategory ***

-- *** Aqui precisaremos fazer um relacionamento em cadeia

-- 5. Definindo as colunas da view VENDAS_INTERNET

-- VIEW FINAL VENDAS_INTERNET

-- Colunas:

-- SalesOrderNumber                (TABELA 1: FactInternetSales)
-- OrderDate                       (TABELA 1: FactInternetSales)
-- EnglishProductCategoryName      (TABELA 4: DimProductCategory)
-- FirstName + LastName            (TABELA 2: DimCustomer)
-- Gender                          (TABELA 2: DimCustomer)
-- SalesTerritoryCountry           (TABELA 3: DimSalesTerritory)
-- OrderQuantity                   (TABELA 1: FactInternetSales)
-- TotalProductCost                (TABELA 1: FactInternetSales)
-- SalesAmount                     (TABELA 1: FactInternetSales)

-- 6. Criando o c�digo da view VENDAS_INTERNET
-- i) Total de Vendas Internet por Categoria do Produto
-- ii) Receita Total Internet por M�s do Pedido
-- iii) Receita e Custo Total Internet por Pa�s
-- iv) Total de Vendas Internet por Sexo do Cliente

-- OBS: O ANO DE AN�LISE SER� APENAS 2013 (ANO DO PEDIDO)
USE AdventureWorksDW2014

CREATE OR ALTER VIEW VENDAS_INTERNET AS   -- Cria View
SELECT
	fis.SalesOrderNumber AS 'N� PEDIDO',
	fis.OrderDate AS 'DATA PEDIDO',
	dpc.EnglishProductCategoryName AS 'CATEGORIA PRODUTO',
	dc.FirstName + ' ' + dc.LastName AS 'NOME CLIENTE', 
	Gender as 'SEXO', 
	SalesTerritoryCountry AS 'PA�S',
	fis.OrderQuantity AS 'QTD. VENDIDA',
	fis.TotalProductCost AS 'CUSTO VENDA',
	fis.SalesAmount AS 'RECEITA VENDA'
FROM FactInternetSales fis
INNER JOIN DimProduct dp ON fis.ProductKey = dp.ProductKey
	INNER JOIN DimProductSubcategory dps ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
		INNER JOIN DimProductCategory dpc ON dps.ProductCategoryKey = dpc.ProductCategoryKey
INNER JOIN DimCustomer dc ON fis.CustomerKey = dc.CustomerKey
INNER JOIN DimSalesTerritory dst ON fis.SalesTerritoryKey = dst.SalesTerritoryKey
WHERE YEAR(OrderDate) = 2013

-- Atualize o BD e v� em Tabelas/Exibi��es e estar� a View VENDAS_INTERNET
SELECT * FROM VENDAS_INTERNET

-- ****************************************
-- ABRA O EXCELL
-- FAZER A CONEX�O ENTRE EXCEL E SQL SERVER SER� UTILIZADO O POWER QUERIE
	-- Na Aba Dados/Obter Dados/Do banco de Dados/Do Banco de Dados SQL Server
		-- Copie o nome do BD: J2CM\SQLEXPRESS 
		-- Copie o nome do BD: AdventureWorksDW2014
		-- Clicar em OK
	-- Apos Carregar a tabela no Excel qualquer altera��o na VIEW deve se feita no Excel e Design de Tabelas/Atualizar

-- Alterando o banco de dados e atualizando no Excel

-- **********************************************************
-- Trabalhando a instru��o SQL direto do EXCEL
-- Copie a instru��o SQL somente
	-- Na Aba Dados/Obter Dados/Do banco de Dados/Do Banco de Dados SQL Server
		-- Copie o nome do BD: J2CM\SQLEXPRESS 
		-- Copie o nome do BD: AdventureWorksDW2014
		-- Clique em Op��es Avan�adas
			-- Instru��o SQL, cola a instru��o SQL
SELECT
	fis.SalesOrderNumber AS 'N� PEDIDO',
	fis.OrderDate AS 'DATA PEDIDO',
	dpc.EnglishProductCategoryName AS 'CATEGORIA PRODUTO',
	dc.FirstName + ' ' + dc.LastName AS 'NOME CLIENTE', 
	Gender as 'SEXO', 
	SalesTerritoryCountry AS 'PA�S',
	fis.OrderQuantity AS 'QTD. VENDIDA',
	fis.TotalProductCost AS 'CUSTO VENDA',
	fis.SalesAmount AS 'RECEITA VENDA'
FROM FactInternetSales fis
INNER JOIN DimProduct dp ON fis.ProductKey = dp.ProductKey
	INNER JOIN DimProductSubcategory dps ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
		INNER JOIN DimProductCategory dpc ON dps.ProductCategoryKey = dpc.ProductCategoryKey
INNER JOIN DimCustomer dc ON fis.CustomerKey = dc.CustomerKey
INNER JOIN DimSalesTerritory dst ON fis.SalesTerritoryKey = dst.SalesTerritoryKey
WHERE YEAR(OrderDate) = 2013
		-- Clicar em OK
		-- Aparecera os dados da consulta via instru��o, clique em Carregar.
	-- Apos Carregar a tabela no Excel qualquer altera��o na VIEW deve se feita no Excel clicando na tabela e Consulta/Editar

	-- Para Alterar a consulta clique na Consulta01/, abre janela, Consulta01/EDITAR, 
		-- ETAPAS APLICADAS   /   Fontes   /  Figura da engenagem
		-- Clique na figura da Engrenagem
		-- Aparecer� a Instru��o SQL para ser Alterada.
		-- Clicar em OK
		-- Para atualizar a Tabela � s� clicar em Fechar e Carregar e ser� atuliada.

-- *************************************
BEGIN TRANSACTION T1
	
	UPDATE FactInternetSales
	SET OrderQuantity = 20
	WHERE ProductKey = 361       -- Categoria Bike

COMMIT TRANSACTION T1

SELECT * FROM FactInternetSales

-- 12 - Tratamentos Basicos no Power Query
--		No Excel arquivo Pasta02.xls na aba consulta/editar, abrirar o Power Query, 
--		clique com o bot�o direito sobre a coluna sexo op��o Substituir Valores - F por Feminino - em op��es avan�adas Coincidir Conteudo da Celular inteira = OK.
/*
28. [SQL Server] Projeto 1 - Integra��o SQL Server e Excel
Obs.: Os itens de 11 a 23 s�o sobre EXCEL e POWER QUERY
11. Alterando o banco e atualizando a Visualiza��o da Tabela
12. Tratamentos B�sicos no Power Query
13. Criando a Tabela Din�mica VENDAS POR CATEGORIA
14. Criando a Tabela Din�mica VENDAS POR M�S
15. Criando a Tabela Din�mica VENDAS POR G�NERO
16. Criando a Tabela Din�mica RECEITA e CUSTO POR PA�S
17. Criando o Gr�fico VENDAS POR CATEGORIA
18. Criando o Gr�fico VENDAS POR G�NERO
19. Criando o Gr�fico VENDAS POR M�S
20. Criando o Gr�fico RECEITA e CUSTO POR PA�S
21. Finalizando o Relat�rio no Excel
22. Alterando o Banco de Dados e Atualizando no Excel
23. Salvando o Arquivo e Finalizando o Projeto
*/