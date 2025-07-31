# Funções condicionais no MySQL

# IF: Função que permite tratar condições no MySQL
-- IF(teste_logico, valor_se_verdadeiro, valor_se_falso)
-- IF(teste_logico1, valor_se_verdadeiro1, IF(teste_logico2, valor_se_verdadeiro2, valor_se_falso))

-- Exemplo 1:
SELECT
	IF(10 > 5, 'Verdadeiro', 'Falso');
    
    
-- Exemplo 2: Uma empresa oferece um bônus de 10% para todos os funcionários que tiveram uma avaliação do RH de acordo com a seguinte regra:
-- NotaDesempenho >= 7 ---> Recebe bônus de 10%
-- NotaDesempenho < 7 ----> Não recebe bônus

SET @varNotaDesempenho = 8.5;

SELECT
	IF(@varNotaDesempenho >= 7, 0.1, 'Sem bônus');
    
    
-- Exemplo 3: Uma empresa oferece um bônus de 10% e 5% para todos os funcionários que tiveram uma avaliação do RH de acordo com a seguinte regra:
-- NotaDesempenho >= 7 ---> Recebe bônus de 10%
-- NotaDesempenho >= 5 ---> Recebe bônus de 5%
-- NotaDesempenho < 7 ----> Não recebe bônus

SET @varNotaDesempenho = 6;

SELECT
	IF(@varNotaDesempenho >= 7, 'Recebe bônus de 10%', IF(@varNotaDesempenho >= 5, 'Recebe bônus de 5%', 'Não recebe bônus')) AS 'Resultado';
    
    
-- Exemplo 4. As lojas da nossa empresa que tiverem mais de 20 funcionários receberão uma reforma de ampliação. Utilize a função IF para criar uma coluna na tabela Lojas que informe quais lojas receberão reforma e quais não receberão reforma.

SELECT * FROM lojas;

SELECT
	*,
    IF(Num_Funcionarios >= 20, 'Recebe reforma', 'Não recebe reforma') AS 'Status'
FROM lojas;




# IFNULL, ISNULL, NULLIF

# IFNULL: Retorna o valor alternativo caso a expressão seja NULL

-- IFNULL(expressão, valor_alternativo)

-- Exemplo 1. Utilize a função IFNULL para retornar um valor alternativo para o valor abaixo.

SELECT
	IFNULL(NULL, 'Valor alternativo');
    

-- Exemplo 2. A tabela de lojas pode ter lojas que não possuem telefone de contato. Neste caso, todas as lojas que tiverem um telefone NULL serão direcionadas para uma central de atendimento com um número padrão: 0800-999-9999. Utilize a função IFNULL para fazer esse ajuste. 

SELECT
	*,
    IFNULL(Telefone, '0800-999-9999') AS 'Telefone Corrigido'
FROM lojas;



# ISNULL: Testa se um determinado valor é NULL. Caso seja nulo, retorna 1; caso contrário, retorna zero.

-- Exemplo 1. Alguns clientes não cadastraram o telefone de contato. Faça uma consulta com uma coluna extra que identifique esses clientes de alguma forma.

SELECT
	*,
    ISNULL(Telefone) AS 'Status'
FROM clientes;


SELECT
	*,
    IF(ISNULL(Telefone), 'Verificar', 'OK') AS 'Status'
FROM clientes;


# NULLIF: Compara duas expressões e retorna NULL se as duas forem iguais. Se forem, retornar NULL; caso contrário, retorna a primeira expressão. 

SET @var1 = 500;
SET @var2 = 100;

SELECT
	NULLIF(@var1, @var2);
    
    
    

# CASE/THEN: A função CASE é uma outra estrutura para tratar condições dentro do SQL. 

# Sintaxe:
/*
CASE
	WHEN condicao1 THEN resultado1
    WHEN condicao2 THEN resultado2
    WHEN condicaoN THEN resultadoN
    ELSE resultado
END;
*/

-- Exemplo 1. Utilize a estrutura CASE para criar uma consulta da nossa tabela de clientes que substitua o valor 'M' por 'Masculino' e o valor 'F' por 'Feminino'

SELECT
	*,
    CASE
		WHEN Sexo = 'M' THEN 'Masculino'
        ELSE 'Feminino'
    END AS 'Sexo 2'
FROM clientes;


-- Exemplo 2. Na tabela de pedidos, crie uma estrutura CASE para avaliar as seguintes situações de Receita_Venda:

-- Caso Receita_Venda >= 3000 ---> 'Faturamento Alto'
-- Caso Receita_Venda >= 1000 ---> 'Faturamento Médio'
-- Caso Receita_Venda < 1000  ---> 'Faturamento Baixo'

SELECT
	*,
    CASE
		WHEN Receita_Venda >= 3000 THEN 'Faturamento Alto'
        WHEN Receita_Venda >= 1000 THEN 'Faturamento Médio'
        ELSE 'Faturamento Baixo'
    END AS 'Status'
FROM pedidos;



# CASE/THEN: Aplicações com AND e OR

# Sintaxe (AND):
/*
CASE
	WHEN condicao1 AND condicao2 THEN resultado1
    ELSE resultado2
END;
*/

# Sintaxe (OR):
/*
CASE
	WHEN condicao1 OR condicao2 THEN resultado1
    ELSE resultado2
END;
*/

-- APLICAÇÃO AND
-- Exemplo 1. A empresa está com uma ação de dia das mães/dia dos pais. Como vai funcionar?
-- Caso o cliente seja do sexo Feminino E tenha filhos, receberá ofertas de dia das mães
-- Caso o cliente seja do sexo Marculino E tenha filhos, receberá ofertas de dia dos pais
-- Caso contrário, não receberá oferta

-- As ofertas serão enviadas por e-mail, por isso o setor responsável precisa de uma tabela identificando facilmente quem receberá qual oferta:

-- 'Oferta dia das mães' ---> Mulher com filhos
-- 'Oferta dia dos pais' ---> Homem com filhos
-- 'Sem oferta' ---> Clientes sem filhos

-- Você deve criar uma coluna extra identificando cada status.

SELECT
	*,
    CASE
		WHEN Sexo = 'F' AND Qtd_Filhos > 0 THEN 'Oferta dia das mães'
        WHEN Sexo = 'M' AND Qtd_Filhos > 0 THEN 'Oferta dia dos pais'
        ELSE 'Sem oferta'
    END AS 'Situação'
FROM clientes;


-- APLICAÇÃO OR
-- Exemplo 2. A empresa está com uma parceria com as empresas das marcas 'DELL' e 'SAMSUNG'. Isso significa que os produtos dessas marcas receberão um desconto de 15% em seu custo de aquisição. Faça uma consulta que retorne uma coluna extra de desconto no custo de aquisição de cada produto. 

-- Custo_Unit = X
-- Custo_Unit = x - 15% de x = x - 0.15 * x = (1 - 0.15) * x 

SELECT
	*,
    CASE
		WHEN Marca_Produto = 'DELL' OR Marca_Produto = 'SAMSUNG' THEN (1 - 0.15) * Custo_Unit
        ELSE Custo_Unit
    END AS 'Desconto?'
FROM produtos;

-- Poderia usar o IN
SELECT
	*,
    CASE
		WHEN Marca_Produto IN ('DELL', 'SAMSUNG') THEN (1 - 0.15) * Custo_Unit
        ELSE Custo_Unit
    END AS 'Desconto?'
FROM produtos;

