# USER-DEFINED VARIABLES

# Uma variável é um local onde armazenamos um determinado valor, que pode ser usado ao longo do nosso código. 

# Tipos de dados:

-- INT: Inteiros
-- DECIMAL(M, D): Decimais com D dígitos e M cadas decimais
-- VARCHAR(N): Textos com N caracteres
-- DATE: Data
-- DATETIME: Data/Hora

# Declaramos uma variável da seguinte forma:

-- SET @Nome = 'SQL';


# Exemplo 1: Uma loja vendeu 10 unidades de um determinado produto, a um preço de R$10,90 cada. Utilize variáveis para calcular a receita total gerada nessa venda. 

-- Declarando a variável de quantidade

SET @varQuantidade = 10;
SET @varPreco = 10.9;
SET @varReceita = @varQuantidade * @varPreco;

SELECT @varReceita AS 'Receita Total';


# Exemplo 2. Crie uma consulta à tabela de produtos para mostrar apenas os produtos da marca DELL. 

# Faça de forma que a marca DELL seja armazenada em uma variável. 

SET @varMarca = 'DELL';

SELECT *
FROM produtos
WHERE Marca_Produto = @varMarca;



# CAST

# A função CAST converte um valor de qualquer típo em outro tipo de dados especificado. 

-- Obs.: No CAST, especificamos o INT coo SIGNED ou UNSIGNED e o VARCHAR como CHAR. 

SET @varNumero = 10.9200;

SELECT @varNumero,
		CAST(@varNumero AS SIGNED),
        CAST(@varNumero AS DECIMAL(10, 2)),
        CAST(@varNumero AS CHAR(3));
        
        
SET @varData = '2021-01-01';

SELECT @varData,
		CAST(@varData AS DATE),
        CAST(@varData AS DATETIME);
