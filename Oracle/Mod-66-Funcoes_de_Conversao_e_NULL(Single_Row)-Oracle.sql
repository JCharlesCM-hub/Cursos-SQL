-- Funções Single Row

-- I. Funções de Conversão: TO_CHAR, TO_NUMBER, TO_DATE
-- 1. TO_CHAR: Converte números e datas para textos, usando um formato especificado.

-- a)Aplicação com DATAS

SELECT
    sysdate hoje,
    TO_CHAR(sysdate, 'YYYY') ano,
    TO_CHAR(sysdate, 'MM') num_mes,
    TO_CHAR(sysdate, 'MONTH') nome_mes,
    TO_CHAR(sysdate, 'MON') mes_abreviado,
    TO_CHAR(sysdate, 'DAY') nome_dia,
    TO_CHAR(sysdate, 'DD') num_dia,
    TO_CHAR(sysdate, 'DY') dia_abreviado,
    TO_CHAR(sysdate, 'HH12') hora_12,
    TO_CHAR(sysdate, 'HH24') hora_24,
    TO_CHAR(sysdate, 'MI') minutos,
    TO_CHAR(sysdate, 'SS') segundos,
    TO_CHAR(sysdate, 'DAY, DD "de" MONTH "de" YYYY') hora_24
FROM dual;


-- a)Aplicação com NÚMEROS

SELECT
    first_name,
    salary,
    TO_CHAR(salary, '999G999D99') numero_sem_zeros,  --      1.000
    TO_CHAR(salary, '000G000D00') numero_com_zeros,  --    001.000,00
    TO_CHAR(salary, 'L999G999D99') moeda
FROM employees;







-- 2. TO_NUMBER: Converte textos para números, sempre que possível.

SELECT
    TO_NUMBER('234,44')
FROM dual;





-- 3. TO_DATE: Converte textos para datas, sempre que possível.

SELECT
    TO_DATE('10/05/2022', 'DD/MM/YYYY')
FROM dual;



-- II. Funções NULL: NVL, NVL2, COALESCE, NULLIF
-- 1. NVL: Permite substituir o valor (null) por um outro valor.


SELECT
    first_name,
    commission_pct,
    NVL(commission_pct, 0)
FROM employees;

















SELECT
    first_name,
    commission_pct,
    NVL(commission_pct, 0)
FROM employees;
    

-- 2. COALESCE: Recebe uma lista de argumentos o primeiro valor não nulo.

SELECT
    COALESCE(NULL, NULL, NULL, NULL, 'Hashtag', NULL, 'SQL')
FROM dual;






-- 3. NVL2: É uma extensão do NVL. Se o primeiro argumento não for null, retorna o segundo argumento.
-- Se o primeiro argumento for null, retorna o terceiro.

SELECT
    first_name,
    commission_pct,
    NVL2(commission_pct, 0.5, 0)
FROM employees;



SELECT
    first_name,
    commission_pct,
    NVL2(commission_pct, 0.5, 0)
FROM employees;

-- 4. NULLIF: Recebe dois argumentos. Se os dois forem iguais, retorna nulo, se não retorna o 1º.

SELECT 
    NULLIF(10, 10),
    NULLIF(10, 5)
FROM dual;















    

-- III. Funções Condicionais
-- 1. CASE WHEN
-- a) Faça uma consulta que retorne o salário atualizado dos funcionários. 
-- Se o funcionário tiver o JOB_ID = 'ST_MAN' ele receberá 20% a mais do salário.
-- Se o funcionário tiver o JOB_ID = 'SA_REP' ele receberá 10% a mais do salário.
-- Se não for nenhum dos dois acima, o funcionário permanece com o mesmo salário.

-- Versão 1
SELECT
    first_name,
    salary,
    job_id,
    CASE
        WHEN job_id = 'ST_MAN' THEN
            salary * 1.2
        WHEN job_id = 'SA_REP' THEN
            salary * 1.1
        ELSE
            salary
        END salario_novo
FROM employees;

-- Versão 2
SELECT
    first_name,
    salary,
    job_id,
    CASE job_id
        WHEN 'ST_MAN' THEN
            salary * 1.2
        WHEN 'SA_REP' THEN
            salary * 1.1
        ELSE
            salary
        END salario_novo
FROM employees;
    

-- 3. DECODE
-- a) Faça uma consulta que retorne o salário atualizado dos funcionários. 
-- Se o funcionário tiver o JOB_ID = 'ST_MAN' ele receberá 20% a mais do salário.
-- Se o funcionário tiver o JOB_ID = 'SA_REP' ele receberá 10% a mais do salário.
-- Se não for nenhum dos dois acima, o funcionário permanece com o mesmo salário.

SELECT
    first_name,
    salary,
    job_id,
    DECODE(job_id,
            'ST_MAN', salary * 1.2,
            'SA_REP', salary * 1.1,
            salary) salario_novo
FROM employees;
    