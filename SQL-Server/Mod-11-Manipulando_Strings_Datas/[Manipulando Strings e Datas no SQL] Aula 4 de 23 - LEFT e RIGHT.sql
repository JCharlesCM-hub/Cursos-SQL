-- [SQL Server] Manipulando Strings e Datas no SQL
-- Aula 4 de 23: LEFT e RIGHT

-- LEFT ---> Extrai uma determinada quantidade de caracteres de um texto, da esquerda para a direita
-- RIGHT ---> Extrai uma determinada quantidade de caracteres de um texto, da direita para a esquerda
-- Exemplo: Faça uma consulta à tabela DimProduct e divida a coluna de StyleName em 2 partes

SELECT * FROM DimProduct
SELECT
	ProductName AS 'Produto',
	UnitPrice AS 'Preço',
	LEFT(StyleName, 7) AS 'Cod 1',
	RIGHT(StyleName, 7) AS 'Cod 2'
FROM
	DimProduct
