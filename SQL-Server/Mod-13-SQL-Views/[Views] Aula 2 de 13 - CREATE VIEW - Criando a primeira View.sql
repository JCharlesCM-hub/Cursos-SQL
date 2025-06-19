-- [SQL Server] Views
-- Aula 2 de 13: CREATE VIEW - Criando a primeira View

-- 1. Exemplos
-- a) Crie uma view contendo as seguintes informações da tabela DimCustomer: FirstName, EmailAddress e BirthDate. Chame essa view de vwClientes

CREATE VIEW vwClientes AS
SELECT
	FirstName AS 'Nome',
	EmailAddress AS 'E-mail',
	BirthDate AS 'Data Nascimento'
FROM 
	DimCustomer

-- b) Crie uma View contendo as seguintes informações da tabela DimProduct: ProductKey, ProductName, BrandName e UnitPrice. Chame essa view de vwProdutos

CREATE VIEW vwProdutos AS
SELECT
	ProductKey AS 'ID Produto',
	ProductName AS 'Nome do Produto',
	ProductSubcategoryKey AS 'ID Subcategoria',
	BrandName AS 'Marca',
	UnitPrice AS 'Preço Unitário'
FROM DimProduct