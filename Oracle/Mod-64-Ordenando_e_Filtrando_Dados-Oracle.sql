/***  ORDENANDO E FILTRANDO DADOS ***
*
*/

-- I. ORDENANDO DADOS DE UMA TABELA: ORDER BY

-- O comando ORDER BY é usado para ordenar os dados de uma tabela, a partir de uma coluna.
-- A sua sintaxe é a seguinte:

/*
SELECT coluna1, coluna2, ...
FROM tabela
ORDER BY coluna1 [ASC/DESC]
*/

-- Onde ASC significa uma ordenação CRESCENTE, enquanto DESC significa uma ordenação DECRESCENTE.

-- Também podemos ordenar a tabela por mais de uma coluna:

/*
SELECT coluna1, coluna2, ...
FROM tabela
ORDER BY coluna1 [ASC/DESC], coluna2 [ASC/DESC], ...
*/



-- II. ORDER BY: APLICAÇÃO

-- 1. Comando ORDER BY com coluna de NÚMEROS

-- a) Faça uma ordenação na tabela EMPLOYEES para visualizar os funcionários do menor
-- para o maior salário.

SELECT * FROM employees
ORDER BY employee_id
FETCH NEXT 5 ROWS ONLY;

-- b) Faça uma ordenação na tabela EMPLOYEES para visualizar os funcionários do maior
-- para o menor salário.

SELECT * FROM employees
ORDER BY salary DESC;

-- 1.2. Comando ORDER BY com coluna de TEXTOS

-- a) Ordene a tabela de EMPLOYEES para mostrar os funcionários em ordem alfabética.

SELECT * FROM employees
ORDER BY first_name;

-- b) Ordene a tabela de EMPLOYEES para mostrar os funcionários em ordem "anti"-alfabética.

SELECT * FROM employees
ORDER BY first_name DESC;

-- 1.3. Comando ORDER BY com coluna de DATAS

-- a) Ordene a tabela de EMPLOYEES para mostrar os funcionários de acordo com a data de
-- contratação: da mais antiga pra mais recente.

SELECT * FROM employees
ORDER BY hire_date;

-- b) Ordene a tabela de EMPLOYEES para mostrar os funcionários de acordo com a data de
-- contratação: da mais recente pra mais antiga.

SELECT * FROM employees
ORDER BY hire_date DESC;


-- 1.4. Comando ORDER BY com mais de uma coluna

-- a) Alguns funcionários possuem o mesmo first_name (por exemplo, o JAMES).
-- Ordene a tabela EMPLOYEES de acordo com first_name e last_name para fazer o desempate. 

SELECT * FROM employees
ORDER BY first_name ASC, last_name ASC;

-- 1.5. Comando ORDER BY com NULLS FIRST e NULLS LAST.

-- a) A coluna MANAGER_ID da tabela DEPARTMENTS possui valores nulos. Faça uma ordenação dessa
-- coluna utilizando NULLS FIRST e NULLS LAST.

SELECT * FROM departments
ORDER BY manager_id DESC NULLS LAST;



-- FETCH NEXT: Filtrando as N primeiras linhas de uma tabela

-- a) TOP N linhas
-- FETCH NEXT N ROWS ONLY

-- Retorne as 10 primeiras linhas da tabela EMPLOYEES, ordenadas por employee_id.

SELECT *
FROM employees
ORDER BY salary DESC
FETCH NEXT 10 ROWS ONLY;


-- b) TOP N linhas, incluindo os empatados
-- FETCH NEXT N ROWS WITH TIES

-- Retorne as 12 primeiras linhas da tabela EMPLOYEES, ordenadas por salary.

SELECT *
FROM employees
ORDER BY salary DESC
FETCH NEXT 12 ROWS WITH TIES;



-- c) Limitando por um percentual de linhas
-- FETCH NEXT N PERCENT ROWS ONLY

-- Retorne os 10% funcionários de salário mais alto.

SELECT *
FROM employees
ORDER BY salary DESC
FETCH NEXT 10 PERCENT ROWS ONLY;


-- d) Criando um OFFSET (deslocamento) de linhas
-- OFFSET N ROWS

-- Retorne os 10 primeiros funcionários logo após os 5 primeiros (ordenando por employee_id).

SELECT *
FROM employees
ORDER BY employee_id
OFFSET 5 ROWS
FETCH NEXT 10 ROWS ONLY;



-- III. FILTRANDO DADOS DE UMA TABELA: COMANDO WHERE

-- O comando WHERE é usado para para filtrar tabelas em um banco de dados. Sua sintaxe é muito simples:

/*
SELECT coluna1, coluna2, ...
FROM tabela
WHERE condicao;
*/

-- Dentro de 'condicao' podemos usar uma série de operadores, como: IN, BETWEEN, LIKE, AND, OR,
-- e assum vai. Veremos vários exemplos de aplicação.


-- IV. FILTRANDO NÚMEROS, TEXTOS E DATAS

-- 1.1. Filtros de número, texto e data.

-- a) Filtre a tabela EMPLOYEES e retorne apenas 
-- os funcionários do departamento ID = 100

SELECT employee_id, first_name, salary, department_id
FROM employees
WHERE department_id = 100;

-- b) Filtre a tabela JOBS e retorne aqueles que 
-- tem um salário mínimo maior que 6000

SELECT *
FROM jobs
WHERE min_salary > 6000;


-- c) Filtre a tabela EMPLOYEES para retornar apenas o job_id = ST_MAN.
-- Cuidado: Oracle é case sensitive.

SELECT
    first_name,
    last_name,
    salary,
    job_id
FROM employees
WHERE job_id = 'ST_MAN';

-- d) Filtre a tabela EMPLOYEES para mostrar apenas os funcionários que foram contratados
-- após o dia 01/01/00

SELECT
    *
FROM employees
WHERE hire_date >= '01/01/00';


-- V. Filtro WHERE combinado com AND, OR e NOT.

-- Os operadores AND e OR nos permitem criar filtros a partir de mais de uma coluna da tabela.

/*
-- AND
-- Todas as condições devem ser VERDADEIRAS

SELECT coluna1, coluna2, ...
FROM tabela
WHERE condicao1 AND condicao2;
*/

/*
-- OR
-- Basta que 1 condição seja VERDADEIRA

SELECT coluna1, coluna2, ...
FROM tabela
WHERE condicao1 AND condicao2;
*/



-- a) Quais funcionários têm o JOB_ID = 'IT_PROG' e SALARY >= 5000?

SELECT * FROM employees
WHERE job_id = 'IT_PROG' AND salary >= 5000;


-- b) Quais funcionários são do departamento 90 ou 100?

SELECT * FROM employees
WHERE department_id = 90 OR department_id = 100
ORDER BY department_id DESC;

-- c) Faça um filtro pra mostrar apenas os funcionários que NÃO são do departamento 90.

SELECT * FROM employees
WHERE NOT department_id = 90;


-- VI. Operador LIKE, NOT LIKE e Wildcards

-- O operador LIKE permite que a gente faça filtros que buscam um padrão dentro de uma coluna.

/*
-- Sintaxe

SELECT coluna1, coluna2, ...
FROM tabela
WHERE coluna1 LIKE 'padrao';
*/

-- a) Quais funcionários possuem um JOB_ID que começam com o texto: 'ST'?

SELECT * FROM employees
WHERE job_id LIKE 'ST%';

-- b) Quais funcionários possuem um JOB_ID que termina com o texto: 'MAN'?

SELECT * FROM employees
WHERE job_id LIKE '%MAN';

-- c) O telefone é formado por 3 partes: AAA.BBB.CCCC. Quais telefones têm a 2ª parte igual a 123?

SELECT * FROM employees
WHERE phone_number LIKE '____123_____';

-- d) Utilize o operador NOT para negar todos os exemplos anteriores.

    
-- VII. OPERADORES BETWEEN e NOT BETWEEN

-- O operador BETWEEN permite realizar um filtro em intervalo de valores.

/*
-- Sintaxe

SELECT coluna1, coluna2, ...
FROM tabela
WHERE coluna1 BETWEEN valor1 AND valor2;
*/


-- a) Selecione os funcionários que recebam um salário ENTRE 10.000 e 30.000.

SELECT * FROM employees
WHERE salary BETWEEN 10000 AND 30000;

-- b) Selecione os funcionários que têm nomes começando com a letra 'A' até a letra 'D'.

SELECT * FROM employees
WHERE first_name BETWEEN 'A' AND 'D';

-- c) Selecione os funcionários que foram contratados entre as datas '01/01/99' e 31/12/00'

SELECT * FROM employees
WHERE hire_date BETWEEN '01/01/99' AND '31/12/00';

-- d) Utilize o NOT para fazer a negação dos exemplos anteriores.


-- VIII. OPERADORES IN e NOT IN

-- O operador IN permite especificar múltiplos valores no filtro.

/*
-- Sintaxe

SELECT coluna1, coluna2, ...
FROM tabela
WHERE coluna1 IN (valor1, valor2, valor3, ...);
*/

-- a) Selecione os funcionários que são de um dos seguintes departamentos: 30, 50, 80.

SELECT * FROM employees
WHERE department_id IN (30, 50, 80);

-- b) Selecione os funcionários que NÃO são dos departamentos acima.

SELECT * FROM employees
WHERE department_id NOT IN (30, 50, 80);


-- IX. OPERADORES IS NULL e IS NOT NULL

-- Permite filtrar valores nulos.

/*
-- Sintaxe

SELECT coluna1, coluna2, ...
FROM tabela
WHERE coluna1 IS NULL;
*/

-- a) Quais funcionários têm o percentual de comissão igual a (null)?

SELECT * FROM employees
WHERE commission_pct IS NULL;

-- b) Quais funcionários têm o percentual de comissão diferente de null.

SELECT * FROM employees
WHERE commission_pct IS NOT NULL;


-- X. REGRAS DE PRECEDÊNCIA

-- Quando utilizamos diversos filtros em conjunto, começa a ficar confuso a ordem que cada
-- filtro será executado. Utilizamos os parênteses para especificar qual é a ordem de prioridade
-- de execução dos filtros. Caso contrário, a execução será feita na seguinte ordem:


-- 1. Condições de comparação
-- 2. IS NULL, LIKE, IN
-- 3. BETWEEN
-- 4. NOT
-- 5. AND
-- 6. OR


-- No exemplo abaixo, qual é o resultado esperado?

SELECT first_name, job_id, salary
FROM employees
WHERE job_id = 'IT_PROG' OR job_id = 'ST_MAN' AND salary > 5000;



-- X1. VARIÁVEIS DE SUBSTITUIÇÃO

-- As variáveis de substituição nos permitem interagir com a nossa consulta ao abrir uma
-- janela para input de dados por parte do usuário.


-- a) Faça uma consulta dinâmica à tabela EMPLOYEES para que seja retornado o funcionário
-- de id informado pelo usuário.

SELECT * FROM employees
WHERE employee_id = &employee_id;

-- b) Faça uma consulta à tabela DEPARTMENTS para que seja retornado as informações do departamento
-- department_name informado pelo usuário (teste com Marketing, IT, Sales).

SELECT * FROM departments
WHERE department_name = '&department_name';

-- c) Faça uma consulta à tabela EMPLOYEES e retorne os funcionários com o salário entre um range
-- da escolha do usuário.

SELECT * FROM employees
WHERE salary BETWEEN &salary AND &salary;
