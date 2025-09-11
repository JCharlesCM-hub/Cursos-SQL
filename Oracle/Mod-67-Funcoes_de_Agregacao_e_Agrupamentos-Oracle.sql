-- Funções de Agregação e Agrupamentos

-- I. Funções de Agregação: COUNT, SUM, AVG, MIN, MAX

-- 1. COUNT: Faz a contagem de valores de uma coluna. 

/*
Sintaxe:

SELECT
    COUNT(coluna)
FROM tabela;
*/

-- Mas, tome cuidado...





-- a) Descubra o total de funcionários a partir da coluna de EMPLOYEE_ID da tabela EMPLOYEES.

SELECT
    COUNT(employee_id) total_funcionarios
FROM employees;

-- b) Descubra o total de funcionários a partir da coluna de FIRST_NAME da tabela EMPLOYEES.

SELECT
    COUNT(first_name) total_funcionarios
FROM employees;

-- c) Descubra o total de funcionários a partir da coluna de COMMISSION_PCT da tabela EMPLOYEES.
-- É possível?

SELECT
    COUNT(commission_pct) total_funcionarios
FROM employees;


-- 2. COUNT(*): Faz a contagem de valores de uma coluna, sejam eles nulos ou não.

-- a) Descubra o total de funcionários na tabela EMPLOYEES independente da coluna a ser usada.

SELECT
    COUNT(*) total_funcionarios
FROM employees;


-- 3. COUNT DISTINCT: Conta os valores distintos de uma coluna.

-- a) Descubra quais são os valores distintos de JOB_ID na tabela EMPLOYEES.
-- Qual é o total de valores distintos?

SELECT
    job_id
FROM employees;


SELECT
    DISTINCT job_id
FROM employees;


SELECT
    COUNT(DISTINCT job_id)
FROM employees;


-- 4. SUM: Faz a soma de valores de uma coluna.

/*
Sintaxe

SELECT
    SUM(coluna)
FROM tabela;
*/


-- a) Qual é a soma total de salário dos funcionários?

SELECT
    SUM(salary) total_salario
FROM employees;


-- 5. AVG: Faz a média de valores de uma coluna.

/*
Sintaxe

SELECT
    AVG(coluna)
FROM tabela;
*/

-- a) Qual é a média salarial dos funcionários?

SELECT
    AVG(salary) total_salario
FROM employees;


-- 6. MAX: Retorna o maior dos valores de uma coluna.

/*
Sintaxe

SELECT
    MAX(coluna)
FROM tabela;
*/


-- a) Qual é a maior de todos os salários?

SELECT
    MAX(salary) total_salario
FROM employees;


-- 7. MIN: Retorna o menor dos valores de uma coluna.

/*
Sintaxe

SELECT
    MIN(coluna)
FROM tabela;
*/

-- a) Qual é a menor de todos os salários?

SELECT
    MIN(salary) total_salario
FROM employees;


-- 8. Cuidado com valores nulos no cálculo das funções de agregação.
-- a) Qual é a média de comissão dos funcionários?

SELECT 
    AVG(NVL(commission_pct, 0)) media_comissao
FROM employees;


-- II. Agrupamentos

/* Sintaxe:

SELECT
    coluna1,
    funcao_agregacao(coluna2)
FROM tabela
GROUP BY coluna1;


-- Na hora de criar agrupamentos, podemos utilizar uma série de comandos, na seguinte ordem:

SELECT
    coluna,
    funcao_agregacao()
FROM tabela
[WHERE condicao]         -- Condição para selecionar as linhas desejadas da tabela
GROUP BY coluna          -- Comando para criar o agrupamento
[HAVING condicao]        -- Condição para selecionar os agrupamentos desejados
[ORDER BY coluna];        -- Comando para ordenar a consulta final

*/


-- 1. GROUP BY: Agrupa os dados a partir de uma ou mais colunas da tabela.
-- a) Faça um agrupamento da quantidade total de funcionários por JOB_ID.

SELECT
    job_id,
    COUNT(*) total_funcionarios
FROM employees
GROUP BY job_id;

-- b) Faça um agrupamento da soma total de salário por JOB_ID.

SELECT
    job_id,
    SUM(salary) total_salario
FROM employees
GROUP BY job_id;

-- c) Faça um agrupamento da soma total de salário por DEPARTMENT_ID e JOB_ID.

SELECT
    department_id,
    job_id,
    SUM(salary) total_salario
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id;


-- 2. Funções de agrupamento aninhadas.
-- a) Qual é a maior média salarial dentre todos os departamentos.

SELECT MAX(AVG(salary))
FROM employees
GROUP BY department_id;


-- 3. GROUP BY + WHERE: Agrupa os dados a partir de uma ou mais colunas da tabela; mas antes,
-- faz um filtro na tabela a ser agrupada.

-- a) Faça um agrupamento de quantidade total de funcionários por JOB_ID, mas apenas para os
-- funcionários que foram contratados no ano de 1998.

SELECT
    job_id,
    COUNT(*) total_funcionarios
FROM employees
WHERE TO_CHAR(hire_date, 'YYYY')  = '1998'
GROUP BY job_id;


-- 4. GROUP BY + HAVING: Agrupa os dados a partir de uma ou mais colunas da tabela e após fazer
-- o agrupamento, filtramos a tabela agrupada.
    
-- a) Faça um agrupamento de quantidade total de funcionários por JOB_ID. A agrupamento final
-- deve considerar apenas os JOB_ID com mais de 1 funcionário.

SELECT
    job_id,
    COUNT(*) total_funcionarios
FROM employees
GROUP BY job_id
HAVING COUNT(*) > 1;
