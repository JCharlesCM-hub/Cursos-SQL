# Functions no MySQL

-- 1. Introdução 
-- Uma função é uma rotina, um conjunto de instruções que você pode salvar no seu banco de dados e executar quando quiser, sem a necessidade de criar o código do zero toda vez que você precisar dele. 

-- 2. Sintaxe
/*

DELIMITER $$

CREATE FUNCTION nome_funcao(param1 tipo1, param2 tipo2)
RETURNS tipo DETERMINISTIC
BEGIN
	instruções1;
    instruções2;
    instruções3;
	RETURN expressao
END $$

DELIMITER ;

SELECT nome_funcao(valor1, valor2);
*/


-- Exemplo 1. Crie uma função que retorna o seguinte texto: "Olá _____, tudo bem?"

DELIMITER $$

CREATE FUNCTION fn_BoasVindas(nome VARCHAR(100))
RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
	RETURN CONCAT('Olá ', nome, ', tudo bem?');
END $$

DELIMITER ;

SELECT fn_BoasVindas('Marcus');


-- Exemplo 2. Crie uma função chamada fn_Faturamento, que receba como parâmetros de entrada o preço (DECIMAL) e a quantidade (INT), e retorne o faturamento da venda, representado pela multiplicação entre preço e quantidade. 

DELIMITER $$

CREATE FUNCTION fn_Faturamento(preco DECIMAL(10, 2), quantidade INT)
RETURNS DECIMAL(10, 2) DETERMINISTIC
BEGIN
	RETURN preco * quantidade;
END $$

DELIMITER ;

SELECT fn_Faturamento(10.99, 100);


-- Exemplo 3. Crie uma função que substitua de um texto os caracteres com acentos para caracteres sem acentos (exemplo: 'á' por 'a', 'à' por 'a', e assim vai), assim como substituir o ç por c. 

DELIMITER $$

CREATE FUNCTION fn_RemoveAcentos(texto VARCHAR(100))
RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
	SET texto = REPLACE(texto, 'á', 'a'),
		texto = REPLACE(texto, 'é', 'e'),
		texto = REPLACE(texto, 'í', 'i'),
        texto = REPLACE(texto, 'ó', 'o'),
        texto = REPLACE(texto, 'ú', 'u'),
        texto = REPLACE(texto, 'à', 'a'),
        texto = REPLACE(texto, 'è', 'e'),
        texto = REPLACE(texto, 'ì', 'i'),
        texto = REPLACE(texto, 'ò', 'o'),
        texto = REPLACE(texto, 'ù', 'u'),
        texto = REPLACE(texto, 'ã', 'a'),
        texto = REPLACE(texto, 'õ', 'o'),
		texto = REPLACE(texto, 'Á', 'A'),
		texto = REPLACE(texto, 'É', 'E'),
        texto = REPLACE(texto, 'Í', 'I'),
        texto = REPLACE(texto, 'Ó', 'O'),
        texto = REPLACE(texto, 'Ú', 'U'),
        texto = REPLACE(texto, 'À', 'A'),
        texto = REPLACE(texto, 'È', 'E'),
        texto = REPLACE(texto, 'Ì', 'I'),
        texto = REPLACE(texto, 'Ò', 'O'),
        texto = REPLACE(texto, 'Ù', 'U'),
        texto = REPLACE(texto, 'Ã', 'A'),
        texto = REPLACE(texto, 'Õ', 'O'),
        texto = REPLACE(texto, 'ç', 'c'),
        texto = REPLACE(texto, 'Ç', 'C'),
        texto = REPLACE(texto, 'â', 'a'),
		texto = REPLACE(texto, 'ê', 'e'),
		texto = REPLACE(texto, 'î', 'i'),
        texto = REPLACE(texto, 'ô', 'o'),
        texto = REPLACE(texto, 'û', 'u'),
        texto = REPLACE(texto, 'Â', 'A'),
		texto = REPLACE(texto, 'Ê', 'E'),
		texto = REPLACE(texto, 'Î', 'I'),
        texto = REPLACE(texto, 'Ô', 'O'),
        texto = REPLACE(texto, 'Û', 'U');
        RETURN texto;
END $$

DELIMITER ;

SELECT 
	Loja,
    Endereco,
	fn_RemoveAcentos(Endereco)
FROM lojas;



-- O que significa o DETERMINISTIC?

-- Exemplo 1. Crie uma função que retorna o seguinte texto: "Olá _____, tudo bem?"

DELIMITER $$

CREATE FUNCTION fn_BoasVindas2(nome VARCHAR(100))
RETURNS VARCHAR(100)
BEGIN
	RETURN CONCAT('Olá ', nome, ', tudo bem?');
END $$

DELIMITER ;

-- Error Code: 1418. This function has none of DETERMINISTIC...

-- Ao criar uma função armazenada, você deve declarar que ela é determinística ou que não modifica os dados. Caso contrário, pode ser inseguro para recuperação ou replicação de dados. 


-- Solução 1)
-- Fazer da forma como fizemos até agora

-- Solução 2)
SET GLOBAL log_bin_trust_function_creators = 1;

-- Documentação: 
-- https://dev.mysql.com/doc/refman/8.0/en/stored-programs-logging.html






# Stored Procedures no MySQL

-- 1. Introdução 
-- As Stores Procedures podem ser vistas como programas/scripts (se fizermos uma analogia com qualquer linguagem de programação). Uma procedure permite alterar de forma global o banco de dados. 

-- Com elas, conseguimos utilizar instruções INSERT, UPDATE, DELETE. 

-- Procedures são utilizadas normalmente para juntar várias queries em um único bloco de código.

-- 2. Sintaxe
/*
DELIMITER $$

CREATE PROCEDURE nome_storedprocedure(param1 tipo1, param2 tipo2)
BEGIN
	DECLARE var1 tipo1;
    DECLARE var2 tipo2;
    
	instruções1;
    instruções2;
    instruções3;
END $$

DELIMITER ;

CALL nome_storedprocedure(valor1, valor2);
*/


-- Exemplo 1. Crie uma procedure que atualiza o preço de um curso com um novo preço. Sua procedure deve ser capaz de pesquisar o ID do curso de acordo com o parâmetro de ID informado como argumento da procedure. 

USE db_exemplo;

DELIMITER $$
CREATE PROCEDURE sp_AtualizaPreco(NovoPreco DECIMAL(10, 2), ID INT)
BEGIN
	-- 1º) Código de atualizar o preço na tabela dCursos
	UPDATE dcursos
    SET Preco_Curso = NovoPreco
    WHERE ID_Curso = ID;
    
    -- 2º) Enviar uma mensagem de executado com sucesso
    SELECT 'Preço atualizado com sucesso!';
END $$
DELIMITER ;

SELECT * FROM dCursos;

CALL sp_AtualizaPreco(360, 3);


-- Exemplo 2. Crie uma procedure capaz de receber 2 parâmetros: ID e Desconto.

-- Com a informação de ID, ela deve aplicar o desconto para o curso de ID informado. Além disso, sua procedure deve retornar as seguintes mensagens:

-- 'Desconto de ___ aplicado com sucesso!'
-- 'Curso: ____; Preço antigo = ____; Preço Novo = ____.'
-- 'Código finalizado com sucesso!'

DELIMITER $$
CREATE PROCEDURE sp_AplicaDesconto(ID INT, Desconto DECIMAL(10, 2))
BEGIN
	-- 1º) Declarar algumas variáveis importantes
    -- Variável para armazenar o preço com desconto
    DECLARE varPrecoComDesconto DECIMAL(10, 2);
    -- Variável para armazenar o nome do curso
    DECLARE varNomeCurso VARCHAR(100);
    -- Variável para armazenar o preço antigo do curso
    DECLARE varPrecoAntigo DECIMAL(10, 2);
    
    -- 2º) Atribuir o valor de preço antigo à variável varPrecoAntigo
    SET varPrecoAntigo = (SELECT Preco_Curso FROM dCursos WHERE ID_Curso = ID);
    
    -- 3º Atribuir o valor de preço com desconto à variável varPrecoComDesconto
	SET varPrecoComDesconto = (SELECT Preco_Curso FROM dCursos WHERE ID_Curso = ID) * (1 - Desconto);
    
    -- 4º) Atribuir o nome do curso à variável varNomeCurso
    SET varNomeCurso = (SELECT Nome_Curso FROM dCursos WHERE ID_Curso = ID);
    
    -- 5º) Atualizar a tabela com o novo preço 
    UPDATE dCursos
    SET Preco_Curso = varPrecoComDesconto
    WHERE ID_Curso = ID;
    
    SELECT CONCAT('Desconto de ', Desconto * 100, '% aplicado com sucesso!') AS 'Mensagem 1 de 3';
    SELECT CONCAT('Curso: ', varNomeCurso, '; Preço antigo = ', varPrecoAntigo, '; Preço Novo = ', varPrecoComDesconto) AS 'Mensagem 2 de 3';
    SELECT 'Código executado com sucesso' AS 'Mensagem 3 de 3';
END $$

DELIMITER ;


SELECT * FROM dCursos;

-- Excel = 400
-- VBA = 600
-- Power BI = 360

CALL sp_AplicaDesconto(1, 0.5);

