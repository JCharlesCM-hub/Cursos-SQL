-- Functions

-- O que é?
-- Uma Function é uma sub-rotina que retorna obrigatoriamente 1 único valor.

/*
Sintaxe

CREATE OR REPLACE FUNCTION fn_name (f1 NUMBER, f2 INT)
RETURN NUMBER IS

variáveis

BEGIN

    instruções da function

END;

*/



-- Exemplo 1: Função para calcular a área de um círculo.
CREATE OR REPLACE FUNCTION area_circulo (raio NUMBER)
RETURN NUMBER IS

pi NUMBER(10, 4);
area NUMBER(10, 4);

BEGIN
    -- Área do círculo: pi * r * r
    pi := 3.1413;
    area := pi * (raio * raio);
    RETURN area;
END;

SET SERVEROUTPUT ON;

DECLARE 
    teste NUMBER(10, 4);
BEGIN
    teste := area_circulo(3);
    dbms_output.put_line('A área do círculo é: ' || teste);
END;

SELECT area_circulo(10)
FROM dual;





-- Exemplo 2: Cria uma function que recebe 2 argumentos: salário e percentual de bônus. 
-- Essa function deverá calcular a comissão recebida pelo funcionário (salario * perc_comissao).

CREATE OR REPLACE FUNCTION calcula_bonus(salario NUMBER, perc_comissao NUMBER)
RETURN NUMBER
IS

bonus NUMBER(10, 2);

BEGIN

    bonus := NVL(salario * perc_comissao, 0);
    
    RETURN bonus;

END;

SELECT
    employee_id,
    first_name,
    salary,
    commission_pct,
    calcula_bonus(salary, commission_pct) bonus
FROM employees;


DROP FUNCTION calcula_bonus;
















-- Removendo uma Function

