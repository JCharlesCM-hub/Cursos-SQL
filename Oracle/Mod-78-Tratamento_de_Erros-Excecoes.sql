-- Tratamento de Erros (Exceções)


-- I. EXCEÇÕES DO SISTEMA

-- Exceções do sistema são exceções que possuem um nome no PL/SQL.


-- Exemplo 1. Crie uma function que calcule a variação percentual entre dois anos. Essa function deve tratar o erro de divisão por zero.

SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION fn_calcula_variavao_percentual(valor_ano1 NUMBER, valor_ano2 NUMBER)
RETURN VARCHAR2
IS

variacao_percentual NUMBER(10, 2);

BEGIN

    variacao_percentual := valor_ano2 / valor_ano1 - 1;
    
    RETURN 'A variação percentual entre os anos foi de: ' || variacao_percentual * 100 || '%.';
    
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        RETURN 'O ano 1 não teve resultado. Informe o valor de ano 1 corretamente.';

END;

SELECT fn_calcula_variavao_percentual(0, 85)
FROM dual;

























-- Exemplo 2: Crie uma procedure que cadastra clientes na tabela CLIENTES da conexão MARCUS. Caso haja a tentativa de cadastrar um CPF
-- já existente, um tratamento de erro deverá ser feito.

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE pr_cadastra_clientes(vnome_cliente clientes.nome_cliente%type, vsexo clientes.sexo%type, vemail clientes.email%type, vdata_nascimento clientes.data_nascimento%type, vcpf clientes.cpf%type)
AS

BEGIN

    INSERT INTO clientes(id_cliente, nome_cliente, sexo, email, data_nascimento, cpf) VALUES
        (clientes_seq.NEXTVAL, vnome_cliente, vsexo, vemail, vdata_nascimento, vcpf);
        
    dbms_output.put_line('Cadastro realizado com sucesso');
    
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        dbms_output.put_line('O cpf para o cliente cadastrado já existe na tabela.');
    

END pr_cadastra_clientes;







-- Cliente 1:
-- Nome: Katia Melo
-- Sexo: F
-- Email: katia@hotmail.com
-- Data de Nascimento: '01/01/2000'
-- CPF: '123.456.789-10'

EXEC pr_cadastra_clientes('Lucas Silva', 'M', 'lucas@hotmail.com', '01/01/2002', '123.456.789-99');













-- II. RAISE_APPLICATION_ERROR

-- RAISE_APPLICATION_ERROR é uma procedure da Oracle que permite ao desenvolvedor tratar uma exceção e associar um número e uma mensagem
-- de erro. Você pode gerar erros começando com o valor -20000 até -20999. Qualquer outro número é reservado para os erros padrão da Oracle.
-- A mensagem de erro pode conter até 2000 caracteres.

-- Exemplo 1. Crie uma function que calcule a variação percentual entre dois anos. Caso o valor de ano1 seja menor ou igual a zero, então
-- você deverá tratar o "erro" com o RAISE_APPLICATION_ERROR.

CREATE OR REPLACE FUNCTION fn_calcula_variacao_percentual2(valor_ano1 NUMBER, valor_ano2 NUMBER)
RETURN VARCHAR2
IS

variacao_percentual NUMBER(10, 2);

BEGIN

    IF valor_ano1 <= 0 THEN
        RAISE_APPLICATION_ERROR(-20300, 'O valor informado para o ano 1 deve ser maior que zero.');
    END IF;

    variacao_percentual := valor_ano2 / valor_ano1 - 1;
    
    RETURN 'A variação percentual entre os anos foi de: ' || variacao_percentual * 100 || '%.';
    

END;


SELECT fn_calcula_variacao_percentual2(-40, 20)
FROM dual;















-- III. EXCEÇÕES DEFINIDAS PELO USUÁRIO

-- O usuário de um banco de dados pode definir e tratar seus próprios erros de forma personalizada (erros que nao foram definidos ainda pelo
-- Oracle. Estes erros são chamados de Exceções Definidas pelo Usuário.


-- Exemplo 1. Crie uma Procedure que cadastra uma nova venda na tabela VENDAS. Caso a quantidade vendida informada seja igual a zero, 
-- o seu código deverá fazer um tratamento de erros.

CREATE OR REPLACE PROCEDURE pr_cadastra_venda(vid_cliente vendas.id_cliente%type, vid_produto vendas.id_produto%type, vquantidade vendas.quantidade%type) 
AS

sem_vendas EXCEPTION;

BEGIN

    IF vquantidade <= 0 THEN
        RAISE sem_vendas;
    ELSE
        INSERT INTO vendas(id_venda, data_venda, id_cliente, id_produto, quantidade) VALUES
            (vendas_seq.NEXTVAL, sysdate, vid_cliente, vid_produto, vquantidade);
            
        dbms_output.put_line('Venda registrada com sucesso.');
    
    END IF;

EXCEPTION
    WHEN sem_vendas THEN
        RAISE_APPLICATION_ERROR(-20400, 'A quantidade vendida cadastrada deve ser maior que zero.');


END;

EXEC pr_cadastra_venda(2, 3, 0);






















-- IV. WHEN OTHERS

-- A cláusula WHEN OTHERS é usada para tratar todas as exceções remanescentes que não forem tratadas pelas exceções do sistema ou 
-- pelas exceções definidas pelo usuário.

CREATE OR REPLACE FUNCTION fn_calcula_variacao_percentual(valor_ano1 NUMBER, valor_ano2 NUMBER)
RETURN VARCHAR2
IS

variacao_percentual NUMBER(10, 2);

BEGIN

    variacao_percentual := valor_ano2 / valor_ano1 - 1;
    
    RETURN 'A variação percentual entre os anos foi de: ' || variacao_percentual * 100 || '%.';
    
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        RETURN 'O ano 1 não teve resultado. Portanto, o crescimento foi igual ao valor do ano 2: ' || TRIM(TO_CHAR(valor_ano2, 'L999G999D99'));
    WHEN OTHERS THEN
        RETURN 'Outros erros foram identificados e tratados.';
    
    
END;








-- V. SQLCODE e SQLERRM

-- Podemos acessar o número e o nome do erro utilizando as funções SQLCODE e SQLERRM, conforme mostrado abaixo. 


CREATE OR REPLACE FUNCTION fn_calcula_variacao_percentual(valor_ano1 NUMBER, valor_ano2 NUMBER)
RETURN VARCHAR2
IS

variacao_percentual NUMBER(10, 2);

BEGIN

    variacao_percentual := valor_ano2 / valor_ano1 - 1;
    
    RETURN 'A variação percentual entre os anos foi de: ' || variacao_percentual * 100 || '%.';
    
EXCEPTION
    WHEN ZERO_DIVIDE THEN
       RETURN 'O seguinte erro foi identificado: ' || SQLCODE || ' - ' || SQLERRM;
    
END;

SELECT fn_calcula_variacao_percentual(0, 20)
FROM dual;
