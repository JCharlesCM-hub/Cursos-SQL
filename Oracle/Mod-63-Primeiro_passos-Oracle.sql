/***  INTRODUÇÃO AO SQL ***
*
*

-- I. INTRODUÇÃO AO SQL E GRUPOS DE COMANDOS
-- O SQL é uma linguagem de programação para trabalhar com dados. Podemos dividir esses comandos em 4 grupos:
-- a) DDL - Data Definition Language
-- 

-- b) DML - Data Manipulation Language
-- c) TCL - Transact Control Language
-- d) DCL - Data Control Language



-- II. DOCUMENTAÇÃO DA ORACLE
-- A Oracle possui uma documentação muito rica, que pode ser acessada através do site abaixo.
https://otn.oracle.com


-- III . EXPLORANDO AS TABELAS DO BANCO DE DADOS HR
-- Para acessar as tabelas do banco de dados HR é muito simples. Basta clicar em cima da tabela
-- que você deseja visualizar e uma janela será aberta.

-- Nessa janela, temos acesso a informações como: Colunas, Dados, Modelo, Restrições (Constraints) e assim vai.


-- IV. DESCRIBE/DESC - EXIBINDO A ESTRUTURA DE TABELAS
*/

DESCRIBE employees;

DESC employees;

DESC departments;

DESC regions;

-- V. SELECT *, SELECT: Como selecionar colunas em uma tabela.

-- Existem duas formas de selecionar colunas de uma tabela:
-- a) Todas de uma vez
-- b) Apenas colunas específicas

-- Selecione a tabela LOCATIONS

SELECT * FROM locations;

-- Selecione a tabela EMPLOYEES

SELECT * FROM employees;

-- Selecione a coluna DEPARTMENT_NAME da tabela DEPARTMENTS

SELECT department_name FROM departments;

-- Selecione apenas as colunas FIRST_NAME, EMAIL e SALARY da tabela EMPLOYEES

SELECT first_name, email, salary
FROM employees;
    

-- Dica: Seleção rápida de tabelas (arrastando com o mouse)



-- VI. FORMAS DE EXECUTAR UM CÓDIGO

-- Existem duas formas de executar códigos no Oracle
-- a) Executar instrução (CTRL + ENTER)
-- b) Executar script (F5)




-- VII. FORMAS DE COMENTAR UM CÓDIGO

-- Existem duas formas de criar comentários em um código.
-- a) Comentário de 1 linha
-- b) Comentário de linha múltipla


-- É um comentário de 1 linha.
SELECT * FROM employees;

/*

SELECT * 
FROM employees;

permite
comentar
múltiplas
linhas

*/


-- VIII. DEFININDO ALIAS PARA COLUNAS E TABELAS

-- Um alias é uma forma de dar um nome mais intuitivo para as colunas e tabelas do código
-- Podemos deefinir um alias para:
-- a) Colunas
-- b) Tabelas

-- Selecione as colunas FIRST_NAME, EMAIL e SALARY da tabela EMPLOYEES. 
-- Dê um nome para as colunas da tabela.

SELECT 
    first_name "primeiro nome", 
    email "e-mail", 
    salary "salário (R$)"
FROM employees;

-- Selecione todas as colunas da tabela JOBS.
-- Dê um nome para a tabela JOBS.

SELECT *
FROM JOBS J;


-- Relaciona as tabelas employees e departments por meio de um LEFT JOIN.
-- Além disso, as tabelas são renomeadas com o aliasing.
SELECT 
    e.employee_id,
    e.first_name,
    e.email,
    e.department_id,
    d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id;


-- IX. OPERADOR || (CONCATENAR) E RESOLVENDO PROBLEMA DO ' DENTRO DE UMA STRING

-- Faça uma consulta que retorne o nome completo dos funcionários (FIRST_NAME + LAST_NAME)

SELECT 
    first_name || ' ' || last_name "Nome Completo"
FROM employees;


-- Faça uma consulta que retorne o nome completo + o salário do funcionário (FIRST_NAME + LAST_NAME + SALARY)

SELECT 
    first_name || ' ' || last_name || '. Salário: R$' || salary "Funcionário"
FROM employees;


-- Faça uma consulta que retorne a lista de funcionários e seus respectivos gerentes

SELECT
    first_name || q'[. Employee's manager id: ]' || manager_id "Funcionário e Gerente"
FROM employees;


-- X. CÁLCULOS SIMPLES E TABELA DUAL

-- Adicione um bônus de R$100 aos salários de todos os funcionários

SELECT
    first_name,
    last_name,
    salary,
    salary + 100 "salário + bônus"
FROM employees;


-- Adicione um bônus de 25% do salário para todos os funcionários

SELECT
    first_name,
    last_name,
    salary,
    salary * (1 + 0.25) "salário + bônus (25%)"
FROM employees;

-- Execute simplesmente uma multiplicação de valores ( 2 * 2)

SELECT 2 * 2
FROM dual;


-- Retorne a data atual do sistema

SELECT sysdate
FROM dual;




-- XI. DISTINCT: RETORNANDO VALORES DISTINTOS DA TABELA


-- Qual é o total de departamentos? Faça esta análise em cima da tabela

SELECT
    DISTINCT department_id
FROM employees;

-- Retorne os valores distintos de nomes completos dos funcionários

SELECT
    DISTINCT first_name, last_name
FROM employees;

