-- Antes de começar, alguns comentários...

# Este é um comentário (de 1 linha)

-- Este é outro comentário (de 1 linha)

/* Este é um bloco de comentário
PARTE 1 COMENTÁRIO
PARTE 2 COMENTÁRIO
PARTE 3 COMENTÁRIO */


-- SELECT (Parte 1)

# Selecione todas as colunas: SELECT *
# a) da tabela de pedidos
SELECT * FROM pedidos;

# b) da tabela de produtos
SELECT * FROM produtos;


-- SELECT (Parte 2)

# Selecione colunas específicas de uma tabela
# a) Recapitulando: Selecione todas as colunas da tabela PRODUTOS
SELECT * FROM produtos;

# b) Selecione apenas a coluna Nome_Produto da tabela PRODUTOS
SELECT Nome_Produto FROM produtos;

# c) Selecione as colunas ID_Produto, Nome_Produto, Preco_Unit da tabela PRODUTOS
SELECT ID_Produto, Nome_Produto, Preco_Unit FROM produtos;

# d) Escolha 4 colunas da tabela de PRODUTOS e as selecione
SELECT ID_Produto, Nome_Produto, Marca_Produto, Custo_Unit FROM produtos;

SELECT 
	ID_Produto, 
    Nome_Produto, 
    Marca_Produto, 
    Custo_Unit 
FROM produtos;


# Comando AS: Renomeando as colunas da sua consulta
SELECT 
	ID_Produto 		AS 'ID Produto', 
    Nome_Produto 	AS 'Nome do Produto', 
    Marca 	AS 'Marca do Produto', 
    Custo_Unit 		AS 'Custo Unitário' 
FROM produtos;


# Comando AS: Bônus: Renomeando a tabela
SELECT 
	p.ID_Produto, 
    p.Nome_Produto, 
    p.Marca_Produto, 
    p.Custo_Unit 
FROM produtos AS p;


# LIMIT e OFFSET

# Selecione todas as colunas da tabela PEDIDOS
SELECT * FROM pedidos;


# LIMIT: Utilizada para limitar o número de resultados do SELECT
SELECT * FROM pedidos LIMIT 100;


# LIMIT + OFFSET: Indica o início da leitura

SELECT * FROM pedidos LIMIT 10 OFFSET 5;


# DISTINCT

# Selecione os valores distintos da coluna de marcas da tabela PRODUTOS
SELECT * FROM produtos;

SELECT DISTINCT Marca_Produto FROM produtos;


# ORDER BY

# 1. Introdução
# O comando order by tem como objetivo ordenar uma tabela a partir de uma ou mais colunas daquela mesma tabela

# Podemos escolher a ordem de ordenação a partir dos comandos ASC e DESC.
-- ASC (padrão): Ordena de forma ASCendente (crescente)
	-- Textos: A - Z
    -- Números: Crescente
    -- Datas: Da mais antiga para a mais recente
-- DESC: Ordena de forma DESCendente (decrescente)
	-- Textos: Z - A
    -- Números: Decrescente
    -- Datas: Da mais recente para a mais antiga


# Exemplo 1. Ordenar a coluna Nome da tabela CLIENTES de forma ASC.
SELECT *
FROM clientes
ORDER BY Nome ASC;


# Exemplo 2. Ordenar a coluna Nome da tabela CLIENTES de forma DESC.
SELECT *
FROM clientes
ORDER BY Nome DESC;


# Exemplo 3. Ordenar a coluna Renda_Anual de forma ASC.
SELECT *
FROM clientes
ORDER BY Renda_Anual;


# Exemplo 4. Ordenar a coluna Renda_Anual de forma DESC.
SELECT *
FROM clientes
ORDER BY Renda_Anual DESC;


# Exemplo 5. Ordenar a coluna Data_Nascimento de forma ASC.
SELECT *
FROM clientes
ORDER BY Data_Nascimento;


# Exemplo 6. Ordenar a coluna Data_Nascimento de forma DESC.
SELECT *
FROM clientes
ORDER BY Data_Nascimento DESC;


# Exemplo final. Ordenar as colunas Renda_Anual e Data_Nascimento.
SELECT *
FROM clientes
ORDER BY Renda_Anual DESC, Data_Nascimento DESC;


# Exemplo final 2. Ordenar as colunas Nome e Sobrenome.
SELECT *
FROM clientes
ORDER BY Nome, Sobrenome;