-- JOINs

-- JOINs - Aula 2:
-- Por que precisamos do JOIN?
SELECT TOP(1000) * FROM FactSales
SELECT * FROM DimChannel

SELECT
	channelKey,
	SUM(SalesQuantity) AS 'Qtd. Vendida'
FROM
	FactSales
GROUP BY channelKey



SELECT TOP(1000) * FROM FactSales
SELECT * FROM DimProduct


SELECT TOP(1000) * FROM FactOnlineSales
SELECT * FROM DimCustomer


SELECT * FROM FactStrategyPlan
SELECT * FROM DimScenario

-- JOINs - Aula 3:
-- Por que não criamos logo uma tabela com todas as informações pra facilitar?
SELECT TOP(1000) * FROM FactSales
SELECT * FROM DimProduct

-- JOINs - Aula 6:
-- CÓDIGO PARA CRIAR AS TABELAS AUXILIARES PARA AS EXPLICAÇÕES:
-- PRIMEIRO, GARANTA QUE NÃO EXISTE NENHUMA TABELA CHAMADA PRODUTOS OU SUBCATEGORIA NO BANCO DE DADOS, EXECUTANDO OS COMANDOS DROP TABLE ABAIXO:
DROP TABLE IF EXISTS produtos
DROP TABLE IF EXISTS subcategoria

-- Consulta 1:
-- AGORA, CRIE A TABELA PRODUTOS:
CREATE TABLE produtos(
id_produto int,
nome_produto varchar(30),
id_subcategoria int)

-- INSIRA AS LINHAS DA TABELA PRODUTOS:
INSERT INTO produtos(id_produto, nome_produto, id_subcategoria)
VALUES
	(1, 'Fone Bluetooth JBL', 5),
	(2, 'PS4', 6),
	(3, 'Notebook Samsung i3', 2),
	(4, 'iPhone 11', 1),
	(5, 'Moto G9', 1)

-- Consulta 2:
-- CRIE A TABELA SUBCATEGORIA:
CREATE TABLE subcategoria(
id_subcategoria int,
nome_subcategoria varchar(30))

-- INSIRA AS LINHAS DA TABELA SUBCATEGORIA:
INSERT INTO subcategoria(id_subcategoria, nome_subcategoria)
VALUES
	(1, 'Celular'),
	(2, 'Notebook'),
	(3, 'Câmera Digital'),
	(4, 'Televisão'),
	(5, 'Fone de Ouvido')

-- JOINs - Aula 7:
-- LEFT (OUTER) JOIN

SELECT * FROM produtos
SELECT * FROM subcategoria

SELECT
	produtos.id_produto,
	produtos.nome_produto,
	produtos.id_subcategoria,
	subcategoria.nome_subcategoria
FROM produtos
LEFT JOIN subcategoria
	ON produtos.id_subcategoria = subcategoria.id_subcategoria

-- JOINs - Aula 8:
-- RIGHT (OUTER) JOIN
SELECT * FROM produtos
SELECT * FROM subcategoria

SELECT
	produtos.id_produto,
	produtos.nome_produto,
	produtos.id_subcategoria,
	subcategoria.nome_subcategoria
FROM produtos
RIGHT JOIN subcategoria
	ON produtos.id_subcategoria = subcategoria.id_subcategoria

-- JOINs - Aula 9:
-- INNER JOIN
SELECT * FROM produtos
SELECT * FROM subcategoria

SELECT
	produtos.id_produto,
	produtos.nome_produto,
	produtos.id_subcategoria,
	subcategoria.nome_subcategoria
FROM produtos
INNER JOIN subcategoria
	ON produtos.id_subcategoria = subcategoria.id_subcategoria

-- JOINs - Aula 10:
-- FULL (OUTER) JOIN
SELECT * FROM produtos
SELECT * FROM subcategoria

-- Considerando a coluna id_subcategoria da tabela produtos
SELECT
	produtos.id_produto,
	produtos.nome_produto,
	produtos.id_subcategoria,
	subcategoria.nome_subcategoria
FROM produtos
FULL JOIN subcategoria
	ON produtos.id_subcategoria = subcategoria.id_subcategoria

-- Considerando a coluna id_subcategoria da tabela subcategoria
SELECT
	produtos.id_produto,
	produtos.nome_produto,
	subcategoria.id_subcategoria,
	subcategoria.nome_subcategoria
FROM produtos
FULL JOIN subcategoria
	ON produtos.id_subcategoria = subcategoria.id_subcategoria

-- JOINs - Aula 11:
SELECT * FROM produtos
SELECT * FROM subcategoria

-- LEFT (ANTI) JOIN
SELECT
	produtos.id_produto,
	produtos.nome_produto,
	produtos.id_subcategoria,
	subcategoria.nome_subcategoria
FROM produtos
LEFT JOIN subcategoria
	ON produtos.id_subcategoria = subcategoria.id_subcategoria
WHERE nome_subcategoria IS NULL

-- RIGHT (ANTI) JOIN
SELECT
	produtos.id_produto,
	produtos.nome_produto,
	produtos.id_subcategoria,
	subcategoria.nome_subcategoria
FROM produtos
RIGHT JOIN subcategoria
	ON produtos.id_subcategoria = subcategoria.id_subcategoria
WHERE id_produto IS NULL

-- FULL (ANTI) JOIN
SELECT
	produtos.id_produto,
	produtos.nome_produto,
	produtos.id_subcategoria,
	subcategoria.nome_subcategoria
FROM produtos
FULL JOIN subcategoria
	ON produtos.id_subcategoria = subcategoria.id_subcategoria
WHERE id_produto IS NULL OR nome_subcategoria IS NULL

-- JOINs Aula 12:
-- Exemplo INNER JOIN, LEFT JOIN e RIGHT JOIN
SELECT ProductKey, ProductName, ProductSubcategoryKey FROM DimProduct
SELECT ProductSubcategoryKey, ProductSubcategoryName FROM DimProductSubcategory

SELECT
	ProductKey,
	ProductName,
	DimProduct.ProductSubcategoryKey,
	ProductSubcategoryName
FROM DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey

SELECT
	ProductKey,
	ProductName,
	DimProduct.ProductSubcategoryKey,
	ProductSubcategoryName
FROM DimProduct
LEFT JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey

SELECT
	ProductKey,
	ProductName,
	DimProduct.ProductSubcategoryKey,
	ProductSubcategoryName
FROM DimProduct
RIGHT JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey

-- JOINs - Aula 13:
-- COMO ESCOLHER QUEM É A TABELA DA ESQUERDA E A TABELA DA DIREITA?
-- 1. LEFT Join para complementar informações da tabela produtos (LEFT) de acordo com a tabela de categoria (RIGHT)
SELECT
	id_produto,
	nome_produto,
	produtos.id_subcategoria,
	nome_subcategoria
FROM produtos
LEFT JOIN subcategoria
	ON produtos.id_subcategoria = subcategoria.id_subcategoria

-- 2. Obtendo o LEFT Join do caso 1 usando um RIGHT Join e invertendo as tabelas de lado
SELECT
	id_produto,
	nome_produto,
	produtos.id_subcategoria,
	nome_subcategoria
FROM subcategoria
RIGHT JOIN produtos
	ON subcategoria.id_subcategoria = produtos.id_subcategoria

-- JOINs - Aula 15:
-- CROSS JOIN
-- PARA ACOMPANHAR ESTA AULA, PRECISAREMOS CRIAR A TABELA MARCAS
-- PRIMEIRO, GARANTA QUE NÃO EXISTE NENHUMA TABELA CHAMADA MARCAS NO BANCO DE DADOS, EXECUTANDO O COMANDO DROP TABLE ABAIXO:
DROP TABLE IF EXISTS marcas

-- AGORA CRIE A TABELA MARCAS:
CREATE TABLE marcas(
id_marca int,
marca varchar(30))

-- INSIRA AS LINHAS DA TABELA MARCAS:
INSERT INTO marcas(id_marca, marca)
VALUES
	(1, 'Apple'),
	(2, 'Samsung'),
	(3, 'Motorola')

SELECT * FROM marcas
SELECT * FROM subcategoria

SELECT
	marca,
	nome_subcategoria
FROM marcas CROSS JOIN subcategoria

-- JOINs - Aula 16:
-- Múltiplos Joins
SELECT ProductKey, ProductName, ProductSubcategoryKey FROM DimProduct
SELECT ProductSubcategoryKey, ProductSubcategoryName, ProductCategoryKey FROM DimProductSubcategory
SELECT ProductCategoryKey, ProductCategoryName FROM DimProductCategory

SELECT
	ProductKey,
	ProductName,
	DimProduct.ProductSubcategoryKey,
	ProductCategoryName
FROM DimProduct
INNER JOIN DimProductSubcategory
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
		INNER JOIN DimProductCategory
			ON DimProductSubcategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey

-- JOINs - Aula 17:
-- UNION
SELECT
	*
FROM
	DimCustomer
WHERE Gender = 'F'
UNION
SELECT
	*
FROM
	DimCustomer
WHERE Gender = 'M'

-- UNION ALL
SELECT
	FirstName,
	BirthDate
FROM
	DimCustomer
WHERE Gender = 'F'
UNION ALL
SELECT
	FirstName,
	BirthDate
FROM
	DimCustomer
WHERE Gender = 'M'