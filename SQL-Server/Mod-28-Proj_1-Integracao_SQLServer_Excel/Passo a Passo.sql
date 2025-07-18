/*
MOD - 28 - Projeto 01 - Integração SQL SERVER e EXCEL
1º - Baixar o Banco de Dados de Teste 
	- Pesquisar: Bancos de dados de exemplo do AdventureWorks
	- Baixar a Versão: AdventureWorksDW2014.bak

2º - Gravar/Salvar o BD no Local
	F:\MeusArq\Cursos\SQL-Impressionador\BD\SQL-MS-AdentureWorks2014

3º - No SSMS 
	- Clicar em Bancos de Dados(botão direito)
		- Restaurar Bancos de Dados...
			F:\MeusArq\Cursos\SQL-Impressionador\BD\SQL-MS-AdentureWorks2014
			- ok... ok... ok...

*/
-- ##################################################
--     PROJETO DE INTEGRAÇÃO SQL SERVER e EXCEL
-- ##################################################

-- 1. Apresentação
-- 2. Download Banco de Dados AdventureWorks 2014

/*
https://docs.microsoft.com/pt-br/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms
*/

-- 3. Definindo os indicadores do projeto
-- i) Total de Vendas Internet por Categoria do Produto
-- ii) Receita Total Internet por Mês do Pedido
-- iii) Receita e Custo Total Internet por País
-- iv) Total de Vendas Internet por Sexo do Cliente

-- OBS: O ANO DE ANÁLISE SERÁ APENAS 2013 (ANO DO PEDIDO)
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

-- 6. Criando o código da view VENDAS_INTERNET
-- i) Total de Vendas Internet por Categoria do Produto
-- ii) Receita Total Internet por Mês do Pedido
-- iii) Receita e Custo Total Internet por País
-- iv) Total de Vendas Internet por Sexo do Cliente

-- OBS: O ANO DE ANÁLISE SERÁ APENAS 2013 (ANO DO PEDIDO)
USE AdventureWorksDW2014

CREATE OR ALTER VIEW VENDAS_INTERNET AS   -- Cria View
SELECT
	fis.SalesOrderNumber AS 'Nº PEDIDO',
	fis.OrderDate AS 'DATA PEDIDO',
	dpc.EnglishProductCategoryName AS 'CATEGORIA PRODUTO',
	dc.FirstName + ' ' + dc.LastName AS 'NOME CLIENTE', 
	Gender as 'SEXO', 
	SalesTerritoryCountry AS 'PAÍS',
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

-- Atualize o BD e vá em Tabelas/Exibições e estará a View VENDAS_INTERNET
SELECT * FROM VENDAS_INTERNET

-- ****************************************
-- ABRA O EXCELL
-- FAZER A CONEXÃO ENTRE EXCEL E SQL SERVER SERÁ UTILIZADO O POWER QUERIE
	-- Na Aba Dados/Obter Dados/Do banco de Dados/Do Banco de Dados SQL Server
		-- Copie o nome do BD: J2CM\SQLEXPRESS 
		-- Copie o nome do BD: AdventureWorksDW2014
		-- Clicar em OK
	-- Apos Carregar a tabela no Excel qualquer alteração na VIEW deve se feita no Excel e Design de Tabelas/Atualizar

-- Alterando o banco de dados e atualizando no Excel

-- **********************************************************
-- Trabalhando a instrução SQL direto do EXCEL
-- Copie a instrução SQL somente
	-- Na Aba Dados/Obter Dados/Do banco de Dados/Do Banco de Dados SQL Server
		-- Copie o nome do BD: J2CM\SQLEXPRESS 
		-- Copie o nome do BD: AdventureWorksDW2014
		-- Clique em Opções Avançadas
			-- Instrução SQL, cola a instrução SQL
SELECT
	fis.SalesOrderNumber AS 'Nº PEDIDO',
	fis.OrderDate AS 'DATA PEDIDO',
	dpc.EnglishProductCategoryName AS 'CATEGORIA PRODUTO',
	dc.FirstName + ' ' + dc.LastName AS 'NOME CLIENTE', 
	Gender as 'SEXO', 
	SalesTerritoryCountry AS 'PAÍS',
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
		-- Aparecera os dados da consulta via instrução, clique em Carregar.
	-- Apos Carregar a tabela no Excel qualquer alteração na VIEW deve se feita no Excel clicando na tabela e Consulta/Editar

	-- Para Alterar a consulta clique na Consulta01/, abre janela, Consulta01/EDITAR, 
		-- ETAPAS APLICADAS   /   Fontes   /  Figura da engenagem
		-- Clique na figura da Engrenagem
		-- Aparecerá a Instrução SQL para ser Alterada.
		-- Clicar em OK
		-- Para atualizar a Tabela é só clicar em Fechar e Carregar e será atuliada.

-- *************************************
BEGIN TRANSACTION T1
	
	UPDATE FactInternetSales
	SET OrderQuantity = 20
	WHERE ProductKey = 361       -- Categoria Bike

COMMIT TRANSACTION T1

SELECT * FROM FactInternetSales

-- 12 - Tratamentos Basicos no Power Query
--		No Excel arquivo Pasta02.xls na aba consulta/editar, abrirar o Power Query, 
--		clique com o botão direito sobre a coluna sexo opção Substituir Valores - F por Feminino - em opções avançadas Coincidir Conteudo da Celular inteira = OK.
/*
28. [SQL Server] Projeto 1 - Integração SQL Server e Excel
Obs.: Os itens de 11 a 23 são sobre EXCEL e POWER QUERY
11. Alterando o banco e atualizando a Visualização da Tabela
12. Tratamentos Básicos no Power Query
13. Criando a Tabela Dinâmica VENDAS POR CATEGORIA
14. Criando a Tabela Dinâmica VENDAS POR MÊS
15. Criando a Tabela Dinâmica VENDAS POR GÊNERO
16. Criando a Tabela Dinâmica RECEITA e CUSTO POR PAÍS
17. Criando o Gráfico VENDAS POR CATEGORIA
18. Criando o Gráfico VENDAS POR GÊNERO
19. Criando o Gráfico VENDAS POR MÊS
20. Criando o Gráfico RECEITA e CUSTO POR PAÍS
21. Finalizando o Relatório no Excel
22. Alterando o Banco de Dados e Atualizando no Excel
23. Salvando o Arquivo e Finalizando o Projeto
*/