# WHERE

# 1. Introdução
# O comando WHERE tem como objetivo filtrar as linhas de uma tabela.

# 2. Sintaxe
# SELECT Coluna1, Coluna 2, Coluna3
# FROM Tabela
# WHERE Coluna1 = valor;


# Exemplo 1. Crie um filtro na tabela de CLIENTES para mostrar apenas as linhas referentes aos clientes com Renda_Anual >= 80000.

SELECT *
FROM clientes
WHERE Renda_Anual >= 80000; -- >, <, =, >=, <=, <>


# Exemplo 2. Crie um filtro na tabela de CLIENTES para mostrar apenas as linhas referentes aos clientes do sexo Masculino.

SELECT *
FROM clientes
WHERE Sexo = 'M';

# Exemplo 2.1. Crie um filtro na tabela de CLIENTES para mostrar apenas as linhas referentes aos clientes com escolaridade = 'Parcial'

SELECT *
FROM clientes
WHERE Escolaridade = 'Parcial';


# Exemplo 3. Crie um filtro na tabela de CLIENTES para mostrar apenas as linhas referentes aos clientes que nasceram após o dia '01/01/2000'.

SELECT *
FROM clientes
WHERE Data_Nascimento > '2000-01-01'; -- >, <, =, >=, <=, <>



# WHERE (AND, OR e NOT)ALTER

# 1. Introdução
# O comando WHERE pode ser usado em conjunto com os operadores AND e OR para filtrar mais de uma coluna ao mesmo tempo, e também com o operador NOT, para criar negações.

# 2. Sintaxe
# (AND)
# SELECT Coluna1, Coluna 2, Coluna3
# FROM Tabela
# WHERE Coluna1 = valor1 AND Coluna2 = valor2;

# (OR)
# SELECT Coluna1, Coluna 2, Coluna3
# FROM Tabela
# WHERE Coluna1 = valor1 OR Coluna2 = valor2;

# (NOT)
# SELECT *
# FROM Tabela
# WHERE NOT Coluna1 = valor;


# Exemplo 1. Crie um filtro na tabela PRODUTOS para mostrar apenas as linhas referentes aos produtos da Marca_Produto DELL e Preco_Unit maior ou igual a R$2.000.
SELECT *
FROM produtos
WHERE Marca_Produto = 'DELL' AND Preco_Unit >= 2000;


# Exemplo 2. Crie um filtro na tabela PRODUTOS para mostrar apenas as linhas referentes aos produtos da marca DELL OU ALTURA.
SELECT *
FROM produtos
WHERE Marca_Produto = 'DELL' OR Marca_Produto = 'ALTURA';


# Exemplo 3. Crie um filtro na tabela PRODUTOS para mostrar apenas as os produtos que não são da Marca_Produto igual a SAMSUNG.
SELECT *
FROM produtos
WHERE NOT Marca_Produto = 'SAMSUNG';



# WHERE (IS NULL e IS NOT NULL)

# 1. Introdução
# O comando WHERE pode ser usado em conjunto com o IS NULL ou o IS NOT NULL para filtrar apenas as linhas que são nulas ou não são nulas, respectivamente.

# 2. Sintaxe
# SELECT Coluna1, Coluna 2, Coluna3
# FROM Tabela
# WHERE Coluna1 IS NULL;

# SELECT Coluna1, Coluna 2, Coluna3
# FROM Tabela
# WHERE Coluna1 IS NOT NULL;


# Exemplo 1. Descubra quais clientes não cadastraram o celular.
SELECT *
FROM clientes
WHERE Telefone IS NULL;


# Exemplo 2. Descubra quais lojas cadastraram um contato telefônico.
SELECT *
FROM lojas
WHERE Telefone IS NOT NULL;


# Não confunda NULL com vazio ('')

# Exemplo. Descubra quais clientes não cadastraram o celular.
SELECT *
FROM clientes
WHERE Telefone IS NULL OR Telefone = '';



# WHERE (LIKE)

# 1. Introdução
# O comando WHERE pode ser usado em conjunto com o LIKE para filtrar apenas as linhas que contenham determinado valor.

# 2. Sintaxe
# SELECT Coluna1, Coluna 2, Coluna3
# FROM Tabela
# WHERE Coluna1 LIKE valor;


# Exemplo 1. Descubra quais clientes possuem um e-mail do gmail.
SELECT *
FROM clientes
WHERE Email LIKE '%gmail%';


# Exemplo 2. Descubra quais clientes possuem um e-mail terminado em '.br'.
SELECT *
FROM clientes
WHERE Email LIKE '%.br';



# WHERE (IN e NOT IN)

# 1. Introdução
# O comando WHERE pode ser usado em conjunto com o IN ou o NOT IN como uma alternativa ao operador lógico OR. Com ele, é possível filtrar apenas as linhas que contenham um dos valores especificados em uma lista de valores.

# 2. Sintaxe
# SELECT Coluna1, Coluna 2, Coluna3
# FROM Tabela
# WHERE Coluna1 IN (valor1, valor2, valor3);
-- WHERE Coluna1 = valor 1 OR Coluna2 = valor 2 OR Coluna3 = valor 3;

# Exemplo. Faça um filtro que retorne todos os produtos de uma das 3 marcas a seguir: DELL, SONY ou ALTURA.
SELECT *
FROM produtos
WHERE Marca_Produto IN ('DELL', 'SONY', 'ALTURA');

-- Retornar os produtos que NÃO SÃO das marcas DELL, SONY ou ALTURA.
SELECT *
FROM produtos
WHERE Marca_Produto NOT IN ('DELL', 'SONY', 'ALTURA');



# WHERE (BETWEEN)

# 1. Introdução
# O comando WHERE pode ser usado em conjunto com o BETWEEN para filtrar intervalos. Esses intervalos podem ser de números ou de datas.

# 2. Sintaxe
# SELECT Coluna1, Coluna 2, Coluna3
# FROM Tabela
# WHERE Coluna1 BETWEEN valor1 AND valor2;


# Exemplo 1. Faça um filtro que retorno todos os produtos com Preco_Unit entre R$1.000 e R$2.500. 
SELECT *
FROM produtos
WHERE Preco_Unit BETWEEN 1000 AND 2500;


# Exemplo 2. Faça um filtro que retorno todos os clientes que nasceram entre 01/01/1995 e 31/12/1999.
SELECT *
FROM clientes
WHERE Data_Nascimento BETWEEN '1995-01-01' AND '1999-12-31';


