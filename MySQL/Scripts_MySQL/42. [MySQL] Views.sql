# Views no MySQL
-- Criando, alterando e excluindo uma View. 

-- CREATE VIEW: Cria uma view no nosso banco de dados. 
SELECT * FROM clientes;

CREATE VIEW vwclientes AS
SELECT
	ID_Cliente,
    Nome,
    Data_Nascimento,
    Email,
    Telefone
FROM clientes;

SELECT * FROM vwclientes;


-- ALTER VIEW: Altera uma view existente no banco de dados.

ALTER VIEW vwclientes AS
SELECT
	ID_Cliente,
    Nome,
    Email,
    Telefone, 
    Escolaridade
FROM clientes
WHERE Escolaridade = 'Parcial';

SELECT * FROM vwclientes;


-- DROP VIEW: Exclui uma view de um banco de dados.

DROP VIEW vwclientes;




# Exemplos Views

#. VIEWS + WHERE: Criando Views com consultas filtradas. 

-- Exemplo 1. Crie uma View chamada vwReceitaAcima4000 que armazene todas as colunas da tabela Pedidos. A sua View deverá conter apenas as vendas com receita acima de R$4.000. 

SELECT * FROM pedidos;


CREATE VIEW vwReceitaAcima4000 AS
SELECT
	*
FROM pedidos
WHERE Receita_Venda >= 4000;


SELECT * FROM vwReceitaAcima4000;


ALTER VIEW vwReceitaAcima4000 AS
SELECT
	*
FROM pedidos
WHERE Receita_Venda >= 4000 AND ID_Loja IN (1, 2, 3, 4);


SELECT * FROM vwReceitaAcima4000;


-- Exemplo 2. Crie uma View chamada vwProdutosAtualizada que armazene todas as colunas da tabela Produtos. A sua view deverá conter apenas os produtos das marcas DELL, SAMSUNG e SONY. 

CREATE VIEW vwProdutosAtualizada AS
SELECT
	*
FROM produtos
WHERE Marca_Produto IN ('DELL', 'SAMSUNG', 'SONY');


SELECT * FROM vwProdutosAtualizada;




# 1. VIEWS + GROUP BY: Criando Views com consultas filtradas. 

-- Exemplo 1. Crie uma view que será o resultado de um agrupamento da tabela de pedidos. A ideia é que você tenha nessa view o total de Receita e Custo agrupados por ID_Produto. 

SELECT * FROM pedidos;

CREATE VIEW vwReceitaECustoTotal AS
SELECT
	ID_Produto,
    SUM(Receita_Venda) AS 'Total Receita',
    SUM(Custo_Venda) AS 'Total Custo'
FROM pedidos
GROUP BY ID_Produto;

SELECT * FROM vwReceitaECustoTotal;


-- Exemplo 2. Altere a view anterior para mostrar o agrupamento apenas para os produtos da loja 2. 

ALTER VIEW vwReceitaECustoTotal AS
SELECT
	ID_Produto,
    SUM(Receita_Venda) AS 'Total Receita',
    SUM(Custo_Venda) AS 'Total Custo'
FROM pedidos
WHERE ID_Loja = 2
GROUP BY ID_Produto;

SELECT * FROM vwReceitaECustoTotal;


-- Exemplo 3. Altere a view anterior para mostrar o agrupamento apenas para os produtos que tiveram uma receita total maior que 1 milhão, na loja 2. 

ALTER VIEW vwReceitaECustoTotal AS
SELECT
	ID_Produto,
    SUM(Receita_Venda) AS 'Total Receita',
    SUM(Custo_Venda) AS 'Total Custo'
FROM pedidos
WHERE ID_Loja = 2
GROUP BY ID_Produto
HAVING SUM(Receita_Venda) >= 1000000;

SELECT * FROM vwReceitaECustoTotal;




# 1. VIEWS + JOIN e GROUP BY: Aplicando Join nas views criadas. 

-- Exemplo 1. Crie uma view que seja a junção entre as tabelas de pedidos e de produtos. Ou seja, essa view deve conter todas as colunas da tabela pedidos e as colunas Nome_Produto, Marca_Produto e Num_Serie da tabela de produtos.

SELECT * FROM pedidos;
SELECT * FROM produtos;

CREATE VIEW vwPedidosCompleta AS
SELECT
	pe.*,
    pr.Nome_Produto,
    pr.Marca_Produto,
    pr.Num_Serie
FROM pedidos AS pe
INNER JOIN produtos AS pr
	ON pe.ID_Produto = pr.ID_Produto;

SELECT * FROM vwPedidosCompleta;


-- Exemplo 2. Crie uma view que será o resultado de um agrupamento da tabela de pedidos. A ideia é que você tenha nessa view o total de Receita e Custo agrupados por Nome_Produto.

CREATE VIEW vwResultadoFinal AS
SELECT
	pr.Nome_Produto,
    SUM(Receita_Venda) AS 'Receita_Total',
    SUM(Custo_Venda) AS 'Custo_Total'
FROM pedidos AS pe
INNER JOIN produtos AS pr
	ON pe.ID_Produto = pr.ID_Produto
GROUP BY Nome_Produto;

SELECT * FROM vwResultadoFinal;
