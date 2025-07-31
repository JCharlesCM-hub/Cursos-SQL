# Operações básicas e funções de arredondamento

# 1. Operações básicas
SELECT
	10 + 20			AS 'Soma',
    100 - 40		AS 'Subtração',
    5 * 20			AS 'Multiplicação',
    300 / 12		AS 'Divisão',
    (100 - 10) * 4	AS 'Operação',
    22 % 5			AS 'Resto da divisão';
    
# 2. Funções de arredondamento
SELECT
	ROUND(87.149, 2)		AS 'Arred.',
    FLOOR(87.149)			AS 'Arred. p/ baixo',
    CEILING(87.149)			AS 'Arred. p/ cima',
    TRUNCATE(87.149, 2) 	AS 'Truncar';
    



# COUNT, COUNT(*) e COUNT(DISTINCT)

-- Funções que realizam contagens de valores nas nossas tabelas

-- A estrutura será: 
-- SELECT
-- COUNT(Coluna) AS 'Contagem'
-- FROM Tabela


# 1. COUNT
-- a) Conte a quantidade de clientes a partir da coluna de Nome
SELECT *
FROM clientes;

SELECT
	COUNT(Nome) AS 'Qtd. Clientes'
FROM clientes;


-- b) Conte a quantidade de clientes a partir da coluna de Telefone
SELECT
	COUNT(Telefone)
FROM clientes;


-- c) Houve alguma diferença nos resultados? Por quê?
-- Teve diferença de resultados porque o COUNT ignora (ou seja, não considera) os valores nulos de uma coluna. 


# 2. COUNT(*)
-- Conte a quantidade total de linhas da tabela de CLIENTES
SELECT
	COUNT(*)
FROM clientes;


# 2. COUNT(DISTINCT)
-- Conte a quantidade de marcas distintas na tabela de PRODUTOS
SELECT *
FROM produtos;

SELECT
	COUNT(DISTINCT Marca_Produto)
FROM produtos;

SELECT
	DISTINCT Marca_Produto
FROM produtos;





# SUM, AVG, MIN, MAX

# Utilize a tabela PEDIDOS para realizar os seguintes cálculos:
-- a) Soma de Receita_Total
-- b) Média de Receita_Total
-- c) Mínimo de Receita_Total
-- d) Máximo de Receita_Total

SELECT *
FROM pedidos;

SELECT 
	SUM(Receita_Venda) AS 'Soma de Receita',
    AVG(Receita_Venda) AS 'Média de Receita',
    MIN(Receita_Venda) AS 'Menor Receita',
    MAX(Receita_Venda) AS 'Maior Receita'
FROM pedidos;
