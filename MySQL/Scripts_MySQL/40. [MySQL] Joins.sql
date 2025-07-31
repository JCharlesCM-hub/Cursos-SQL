# INNER JOIN

-- O INNER JOIN tem como objetivo juntar/relacionar os dados de uma tabela A com uma tabela B. 

-- Sintaxe
/* 
SELECT
	Tabela_A.coluna1,
    Tabela_A.coluna2,
    Tabela_A.coluna3,
    Tabela_B.coluna4,
FROM
	Tabela_A
INNER JOIN Tabela_B
	ON Tabela_A.id_chave_estrangeira = Tabela_B.id_chave_primaria
*/


-- Exemplo 1. Faça uma consulta para relacionar as tabelas de produtos e pedidos.

SELECT * FROM produtos;
SELECT * FROM pedidos;

-- Tabela Fato --> Tabela Pedidos --> Tabela A
-- Tabela Dimensão --> Tabela Produtos --> Tabela B

-- Chave Primária (dimensão) --> ID_Produto (produtos)
-- Chave Estrangeira (fato) --> ID_Produto (pedidos)

-- Tabela Pedidos --> ID_Pedido, Data_Venda, ID_Produto, Qtd_Vendida, Receita_Venda
-- Tabela Produtos --> Nome_Produto, Marca_Produto

SELECT
	pedidos.ID_Pedido,
    pedidos.Data_Venda,
    pedidos.ID_Produto,
    pedidos.Qtd_Vendida,
    pedidos.Receita_Venda,
    produtos.Nome_Produto,
    produtos.Marca_Produto
FROM pedidos
INNER JOIN produtos
	ON pedidos.ID_Produto = produtos.ID_Produto;


-- Exemplo 2. Faça uma consulta para relacionar as tabelas de clientes e pedidos. 

SELECT * FROM pedidos;
SELECT * FROM clientes;

-- 1º passo) Identificar as tabelas fato e dimensão
-- Tabela Fato --> Tabela Pedidos --> Tabela A
-- Tabela Dimensão --> Tabela Clientes --> Tabela B

-- 2º passo) Identificar as chaves primária e estrangeira
-- Chave Primária (dimensão) --> ID_Cliente (clientes)
-- Chave Estrangeira (fato) --> ID_Cliente (pedidos)

-- 3º passo) Escolher quais colunas de cada tabela vamos querer visualizar
-- Tabela Pedidos --> ID_Pedido, Data_Venda, ID_Cliente, Qtd_Vendida
-- Tabela Clientes --> Nome, Email

-- 4º passo) solução!!

SELECT
	p.ID_Pedido AS 'ID Pedido',
    p.Data_Venda AS 'Data da Venda',
    p.ID_Cliente AS 'ID Cliente',
    p.Qtd_Vendida AS 'Qtd. Vendida',
    c.Nome AS 'Nome do Cliente',
    c.Email AS 'E-mail'
FROM pedidos AS p
INNER JOIN clientes AS c
	ON p.ID_Cliente = c.ID_Cliente;
    
    
    
    
-- INNER JOIN + WHERE

-- Exercício a) Altere a consulta abaixo para incluir a coluna de Sexo da tabela clientes. 
-- Exercício b) Faça um filtro para mostrar apenas os clientes do sexo masculino.

-- Consulta Original
SELECT
	p.ID_Pedido AS 'ID Pedido',
    p.Data_Venda AS 'Data da Venda',
    p.ID_Cliente AS 'ID Cliente',
    p.Qtd_Vendida AS 'Qtd. Vendida',
    c.Nome AS 'Nome do Cliente',
    c.Email AS 'E-mail'
FROM pedidos AS p
INNER JOIN clientes AS c
	ON p.ID_Cliente = c.ID_Cliente;

-- Resultado
SELECT
	p.ID_Pedido AS 'ID Pedido',
    p.Data_Venda AS 'Data da Venda',
    p.ID_Cliente AS 'ID Cliente',
    p.Qtd_Vendida AS 'Qtd. Vendida',
    c.Nome AS 'Nome do Cliente',
    c.Email AS 'E-mail',
    c.Sexo AS 'Sexo'
FROM pedidos AS p
INNER JOIN clientes AS c
	ON p.ID_Cliente = c.ID_Cliente
WHERE Sexo = 'M';




-- INNER JOIN + GROUP BY

-- Exercício 1
-- a) Faça um agrupamento para mostrar o total de receita por ID do produto. 
-- b) Altere a consulta criada para mostrar o nome do produto em vez do ID do produto.

SELECT * FROM pedidos;

SELECT
    Nome_Produto,
    SUM(Receita_Venda) AS 'Receita Total'
FROM pedidos
INNER JOIN produtos
	ON pedidos.ID_Produto = produtos.ID_Produto
GROUP BY Nome_Produto;


-- Exercício 2
-- a) Faça um agrupamento para mostrar o total de receita e custo por ID da loja. 
-- b) Altere a consulta criada para mostrar o nome da loja em vez do ID da loja.

SELECT
	Loja,
    SUM(Receita_Venda) AS 'Receita Total',
    SUM(Custo_Venda) AS 'Custo Total'
FROM pedidos
INNER JOIN lojas
	ON pedidos.ID_Loja = lojas.ID_Loja
GROUP BY Loja;

