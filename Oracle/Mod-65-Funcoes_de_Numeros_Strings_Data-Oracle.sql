/***  FUNÇÕES SINGLE ROW ***
*
*/

-- I. FUNÇÕES DE TEXTO: LOWER, UPPER, INITCAP, CONCAT, SUBSTR, LENGTH, INSTR, 
-- LPAD, RPAD e REPLACE

-- 1. LOWER: Coloca todos os caracteres de uma palavra em minúsculas.

SELECT 
    first_name,
    LOWER(first_name)
FROM employees;


-- 2. UPPER: Coloca todos os caracteres de uma palavra em MAIÚSCULAS.

SELECT 
    first_name,
    UPPER(first_name)
FROM employees;




-- 3. INITCAP: Deixa o primeiro caractere de cada palavra em MAIÚSCULA e o resto em minúscula.

SELECT 
    job_id,
    INITCAP(job_id)
FROM employees;


SELECT *
FROM employees
WHERE UPPER(first_name) = 'DAVID';


















-- 4. CONCAT: Junta dois textos em 1 só. Tem a mesma aplicação do ||.

SELECT
    first_name,
    last_name,
    CONCAT(first_name, CONCAT(' ', last_name)) nome_completo
FROM employees;
















-- 5. SUBSTR: Extrai uma parte de dentro de um texto.

SELECT
    job_id,
    SUBSTR(job_id, 4, 100)
FROM employees;







-- 6. INSTR: Retorna a posição de um caractere dentro de um texto.

SELECT
    job_id,
    INSTR(job_id, 'MGR')
FROM employees;







-- 7. LENGTH: Retorna o tamanho de uma palavra em quantidade de caracteres.

SELECT
    first_name,
    LENGTH(first_name)
FROM employees;







-- 8. LPAD: Cria um novo texto com tamanho N, alinha o texto antigo à direita e completa 
-- os caracteres restantes com o caractere especificado.

SELECT
    job_id,
    LENGTH(job_id),
    LPAD(job_id, 20, '*')
FROM employees;















-- 9. RPAD: Cria um novo texto com tamanho N, alinha o texto antigo à esquerda e completa 
-- os caracteres restantes com o caractere especificado.

SELECT
    job_id,
    LENGTH(job_id),
    RPAD(job_id, 20, '*')
FROM employees;









-- 10. REPLACE: Substitui um texto por outro texto.

SELECT
    job_id,
    REPLACE(job_id, 'PROG', 'PR')
FROM employees;







-- II. FUNÇÕES NUMÉRICAS: ROUND, TRUNC e MOD

-- 1. ROUND: Arredonda um valor para a quantidade de casas decimais especificada.

SELECT 
    ROUND(37.548, 2) duas_casas,
    ROUND(37.548, 0) zero_casas
FROM dual;


-- 2. TRUNC: Trunca o valor para a casa decimal especificada.

SELECT 
    TRUNC(37.548, 2) duas_casas,
    TRUNC(37.548, 0) zero_casas
FROM dual;






-- 3. MOD: Retorna o resto de uma divisão.

SELECT 
    MOD(10, 4) resto
FROM dual;











-- III. FUNÇÕES DE DATA: MONTHS_BETWEEN, ADD_MONTHS, NEXT_DAY, LAST_DAY, EXTRACT

-- 1. SYSDATE: Retorna a data atual do sistema, no formato 'DD/MM/YY'.

SELECT sysdate
FROM dual;














-- 2. MONTHS_BETWEEN: Retorna o número de meses entre duas datas.

SELECT
    first_name,
    hire_date,
    TRUNC(MONTHS_BETWEEN(sysdate, hire_date), 0) meses_ativo
FROM employees;







-- 3. ADD_MONTHS: Adiciona meses a uma data.

SELECT
    sysdate,
    ADD_MONTHS(sysdate, 3)
FROM dual;






-- 4. NEXT_DAY: Retorna o próximo dia relativo à data especificada.

-- SUNDAY: domingo; MONDAY: segunda; TUESDAY: terça; WEDNESDAY: quarta; THURSDAY: quinta; 
-- FRIDAY: sexta; SATURDAY: sábado

SELECT
    sysdate,
    NEXT_DAY(sysdate, 'wednesday')
FROM dual;








-- 5. LAST_DAY: Retorna o último dia do mês.

SELECT
    sysdate,
    LAST_DAY(sysdate)
FROM dual;



-- 6. EXTRACT: Extrai informações de uma data

SELECT
    sysdate data_atual,
    EXTRACT(YEAR FROM sysdate) ano,
    EXTRACT(MONTH FROM sysdate) mes,
    EXTRACT(DAY FROM sysdate) dia
FROM dual;






