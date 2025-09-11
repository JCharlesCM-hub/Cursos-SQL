/* Blocos Anônimos
*
*

-- I. Introdução

Um Bloco Anônimo é um bloco de código sem nome. Aprender sua estrutura será muito
importante no momento em que falarmos de Functions e Procedures.

Um Bloco Anonônimo é composto por 3 partes: Bloco de Execução, Bloco de Declaração e 
Bloco de Exceção.

O bloco de execução é o único obrigatório para um bloco anônimo. Ele inicia com a palavra 
BEGIN e termina com a palavra END. Dentro dele, escrevemos as instruções que queremos executar.

O bloco de declaração é onde faremos, por exemplo, a declaração de variáveis. 

Por fim, o bloco de exceção contém tratamentos de erros.
*/

-- A estrutura mais básica de um bloco anônimo é mostrada abaixo.

-- 1). Bloco de Execução

-- Exemplo 1: BA que printa na tela uma mensagem de boas vindas.

SET SERVEROUTPUT ON

BEGIN
    dbms_output.put_line('Bem vindo, Impressionador(a)!');
END;


-- 2). Bloco de declaração

-- Exemplo 2: Refaça o exercício anterior, dessa vez usando uma variável.

DECLARE
    texto VARCHAR2(50);
BEGIN
    texto := 'SQL Impressionador';
    dbms_output.put_line(texto);
END;


-- 3) Bloco de exceção
-- Podemos tratar os erros utilizando a instrução EXCEPTION.

DECLARE
    var1 INT;
    var2 INT;
BEGIN
    var1 := 100;
    var2 := 'A';
    dbms_output.put_line(var1 + var2);
    EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('FATAL ERROR!!!');
END;



-- Exemplo: Calcule a receita de uma venda de 10 celulares, ao valor de R$1500 cada.

DECLARE
    vQuantidade INT;
    vPreco NUMBER(10, 2);
    vReceita NUMBER(10, 2);
BEGIN
    /*
    *
    **** Análise de Receita de Venda
    **** Autor: Marcus Cavalcanti
    **** Data: 08/02/2022
    */
    
    vQuantidade := 10;
    vPreco := 1500;
    vReceita := vQuantidade * vPreco;
    dbms_output.put_line('Quantidade vendida: ' || vQuantidade);  -- Retorna a quantidade vendida
    dbms_output.put_line('Preço unitário: ' || vPreco);           -- Retorna o preço unitário
    dbms_output.put_line('Receita total: ' || vReceita);          -- Retorna a receita total

END;



-- II. Utilizando funções dentro de blocos anônimos
-- Exemplo: Em um determinado mês, uma empresa enviou 137 propostas no valor de R$1.000 e conseguiu fechar 25 contratos. 
-- Calcule a receita total (em R$) e a conversão (com 4 casas decimais).

DECLARE
    vPropostasEnv INT;
    vContratosAss INT;
    vConversao NUMBER(10, 4);
    vReceita NUMBER(10, 4);
BEGIN
    /*
    *
    **** Análise de Conversão
    **** Autor: Marcus Cavalcanti
    **** Data: 08/02/2022
    */
    
    vPropostasEnv := 137;
    vContratosAss := 24;
    vReceita := vContratosAss * 1000;
    vConversao := vContratosAss / vPropostasEnv;
    dbms_output.put_line('Propostas enviadas: ' || vPropostasEnv); 
    dbms_output.put_line('Contratos assinados: ' || vContratosAss); 
    dbms_output.put_line('Receita total: ' || TO_CHAR(vReceita, 'L999G999D99'));
    dbms_output.put_line('Conversão %: ' || ROUND(vConversao, 2));     

END;


-- III. Blocos Anônimos aninhados e escopo de variáveis

DECLARE
    vBloco1 INT;
BEGIN
    vBloco1 := 10;
    dbms_output.put_line('Variável do bloco 1: ' || vBloco1);

    DECLARE
        vBloco2 INT;    
    BEGIN
        vBloco2 := 20;
        dbms_output.put_line('Variável do bloco 1: ' || vBloco1);
        dbms_output.put_line('Variável do bloco 2: ' || vBloco2);
    END;
    
    dbms_output.put_line('Variável do bloco 1: ' || vBloco1);
    
END;





