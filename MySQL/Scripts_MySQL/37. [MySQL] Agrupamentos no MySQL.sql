# GROUP BY: Criando agrupamentos no MySQL

# O GROUP BY permite criar resumos de tabelas, permitindo que sejam feitas análises dos dados, como total de produtos por marca, total de clientes por região, total de vendas por produtos, e assim vai.

# Sintaxe 1 (agrupamentos de 1 coluna):

# SELECT Coluna1, COUNT(Coluna1)
# FROM Tabela
# GROUP BY Coluna 1


# Sintaxe 2 (agrupamentos de mais de 1 coluna):

# SELECT Coluna1, Coluna 2, COUNT(Coluna1)
# FROM Tabela
# GROUP BY Coluna 1, Coluna2


# Pra quem vem do Excel, o GROUP BY executa algo muito semelhante às Tabelas Dinâmicas.


# Exemplo 1. Crie um agrupamento mostrando o total de produtos por marca.
SELECT *
FROM produtos;

SELECT Marca_Produto, COUNT(*) AS 'Qtd. de Produtos'
FROM produtos
GROUP BY Marca_Produto;


# Exemplo 2. Crie um agrupamento mostrando o total de clientes por sexo.
SELECT *
FROM clientes;

SELECT Sexo, COUNT(*) AS 'Qtd. de Clientes'
FROM clientes
GROUP BY Sexo;


# Exemplo 3. Crie um agrupamento mostrando o total de vendas por ID do Produto.
SELECT *
FROM pedidos;

SELECT ID_Produto, SUM(Receita_Venda) AS 'Total Receita'
FROM pedidos
GROUP BY ID_Produto;


# Exemplo 4. Crie um agrupamento mostrando o total de clientes por escolaridade e sexo.
SELECT *
FROM clientes;

SELECT Sexo, Escolaridade, COUNT(*) AS 'Qtd. Clientes'
FROM clientes
GROUP BY Sexo, Escolaridade;


# Exemplo 5. Crie um agrupamento mostrando o total de receita por ID do Produto e ID da Loja.
SELECT *
FROM pedidos;

SELECT ID_Produto, ID_Loja, SUM(Receita_Venda) AS 'Total Receita'
FROM pedidos
GROUP BY ID_Produto, ID_Loja;



# GROUP BY + WHERE: Criando filtros antes de agrupamentos no MySQL

# Conseguimos utilizar o WHERE em conjunto com o GROUP BY para criar filtros antes de realizar os agrupamentos. Por exemplo, mostrar o total de clientes por escolaridade, só que apenas os clientes do sexo feminino.


# Exemplo 1. Crie um agrupamento mostrando o total de clientes por escolaridade, mas apenas os clientes do sexo feminino.
SELECT * FROM clientes;

SELECT Escolaridade, COUNT(*) AS 'Qtd. Clientes'
FROM clientes
WHERE Sexo = 'F'
GROUP BY Escolaridade;



# GROUP BY + HAVING: Criando filtros depois de agrupamentos no MySQL

# Conseguimos utilizar o HAVING em conjunto com o GROUP BY para criar filtros depois de um determinado agrupamento. Por exemplo, mostrar apenas os produtos que tiveram uma receita total acima de um determinado valor.

# Sintaxe

# SELECT Coluna1, COUNT(*)
# FROM Tabela
# GROUP BY Coluna1
# HAVING COUNT(*) >= 100;


# Exemplo 1. Crie um agrupamento mostrando o total de clientes por escolaridade.

# Filtre o agrupamento resultante para mostrar apenas as escolaridades com mais de 25 clientes.

SELECT * FROM clientes;

SELECT Escolaridade, COUNT(*) AS 'Qtd. Clientes'
FROM clientes
GROUP BY Escolaridade
HAVING COUNT(*) > 25;


# Exemplo 2. Crie um agrupamento mostrando o total de receita por ID_Produto.

# Filtre o agrupamento resultante para mostrar apenas os produtos que tiveram uma receita total superior a R$5MM.

SELECT ID_Produto, SUM(Receita_Venda) AS 'Total Receita'
FROM pedidos
GROUP BY ID_Produto
HAVING SUM(Receita_Venda) >= 5000000;

