# Subqueries

-- 1. Introdução 
-- Podemos resumir uma subquery como sendo um SELECT dentro de outro SELECT. Ou seja, uma query dentro de outra query. 


-- As subqueries podem ser utilizadas em 3 situações: 

-- 1. Subquery como filtro de uma nova consulta
	-- Uma subquery pode ser usada para filtrar outras consultas. Para este caso, podemos utilizar as cláusulas WHERE, com os operadores de comparação (como =, >=, <=), IN e EXISTS. 
    
-- Exemplo: 
-- SELECT colunas FROM tabela WHERE coluna = (SELECT colunas FROM tabela...);

-- 2. Subquery  como uma nova coluna da consulta
	-- Outra utilização de uma subquery é fazer com que o resultado de outra consulta seja uma coluna dentro de sua consulta principal. 
    
-- Exemplo:
-- SELECT colunas, (SELECT colunas FROM tabela...) FROM tabela;

-- 3. Subquery como fonte de dados de uma consulta principal
	-- Este outro formato faz com que o resultado de uma subquery possa ser utilizado como tabela fonte de dados de uma consulta principal. 
    
-- Exemplo:
-- SELECT colunas FROM (SELECT colunas FROM tabela...) AS t;

-- Obs.: Necessariamente a tabela resultado da subquery deve ter um apelido (AS).



-- 1. Subquery como filtro de uma nova consulta

-- Exercício 1. Quais foram os pedidos realizados na loja onde o gerente é o Marcelo Castro?

SELECT * FROM pedidos;
SELECT ID_Loja FROM lojas;

SET @varNomeGerente = 'Marcelo Castro';

SELECT
	*
FROM pedidos
WHERE ID_Loja = (
				SELECT ID_Loja 
                FROM lojas
				WHERE Gerente = @varNomeGerente
                );


-- Exercício 2. Quais produtos têm o Preco_Unit acima da média?

SELECT AVG(Preco_Unit) FROM produtos; -- Média = 1788.125

SELECT
	*
FROM produtos
WHERE Preco_Unit > (
					SELECT 
						AVG(Preco_Unit)
					FROM produtos);


-- Exercício 3. Quais produtos são da categoria 'Notebook'?

SELECT * FROM categorias;

SELECT * FROM produtos
WHERE ID_Categoria = (
				SELECT 
					ID_Categoria
				FROM categorias
				WHERE Categoria = 'Notebook'
				);


-- Exercício Desafio. Descubra todas as informações sobre o cliente que gerou mais receita para a empresa.

SELECT * FROM clientes
WHERE ID_Cliente = 
			(SELECT
				ID_Cliente
			FROM pedidos
			GROUP BY ID_Cliente
			ORDER BY SUM(Receita_Venda) DESC
			LIMIT 1
            );
            
            
-- Filtrando por meio de uma lista

-- Exercício 1. Descubra quais foi a receita total associada aos produtos da marca DELL. 

SELECT 
	SUM(Receita_Venda) AS 'Receita Marca DELL'
FROM pedidos
WHERE ID_Produto IN (
				SELECT
					ID_Produto
				FROM produtos
				WHERE Marca_Produto = 'DELL'
				);
                

-- Exercício 2. Quais pedidos foram feitos na região 'Sudeste'?
SELECT * FROM pedidos;
SELECT * FROM lojas;
SELECT * FROM locais;

SELECT * FROM locais
WHERE Região = 'Sudeste';

SELECT
	ID_Loja
FROM lojas
WHERE Loja IN (
			SELECT Cidade
            FROM locais
            WHERE Região = 'Sudeste'
            );
            
SELECT
	*
FROM pedidos
WHERE ID_Loja IN (
				SELECT
					ID_Loja
				FROM lojas
				WHERE Loja IN (
							SELECT 
								Cidade
							FROM locais
							WHERE Região = 'Sudeste'
							)
				);
                


-- Subqueries: Utilizando uma subquery como uma coluna

-- Exercício 1. Faça uma consulta que retorne todas as colunas da tabela de produtos + uma coluna com a média de Preco_Unit. 

SELECT AVG(Preco_Unit) FROM produtos;
    
SELECT
	*,
    (SELECT
		AVG(Preco_Unit)
	FROM produtos) AS 'Média Geral de Preço'
FROM produtos;



-- Subqueries: Utilizando uma subquery como uma tabela

-- Exercício 1. Do total de vendas por produto, qual foi a quantidade máxima vendida? E a quantidade mínima? E a média?

SELECT
	MAX(Vendas) AS 'Máximo Vendas',
	MIN(Vendas) AS 'Mínimo Vendas',
    AVG(Vendas) AS 'Média Vendas'
FROM (
		SELECT
			ID_Produto,
			COUNT(*) AS 'Vendas'
		FROM pedidos
		GROUP BY ID_Produto
        ) AS t;
        


-- EXISTS e NOT EXISTS

-- O operador EXISTS é usado para testar a existência de qualquer registro em uma subconsulta.

-- O operador EXISTS retorna TRUE se a subconsulta retornar um ou mais registros. 

/*
Sintaxe:

SELECT coluna(s)
FROM tabela
WHERE EXISTS
(SELECT coluna(s) FROM tabela WHERE condição);
*/


-- Exercício. Você deverá verificar se todas as categorias possuem pelo menos 1 exemplar de produtos (na tabela de produtos); caso alguma categoria não possua nenhum exemplar, você deverá descobrir qual é/quais são. 

SELECT * FROM categorias;
SELECT * FROM produtos;

SELECT 
	* 
FROM categorias
WHERE NOT EXISTS (
			SELECT
				*
			FROM produtos
            WHERE categorias.ID_Categoria = produtos.ID_Categoria
			);
            


