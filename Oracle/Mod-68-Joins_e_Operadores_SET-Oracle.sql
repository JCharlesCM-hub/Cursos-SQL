-- Joins e Operadores SET

-- I. O que são Joins e Operadores SET?
/* 

Joins são comandos que utilizamos para criar relações entre as tabelas e fazer com que seja
possível trazer informações de uma tabela para outra tabela.

Já os operadores SET são comandos que usamos para trabalhar com conjuntos. Com eles, podemos
fazer a união entre tabelas, fazer a interseção entre duas tabelas ou a subtração de tabelas.


*/


-- II. Tabelas Dimensão e Fato. Chaves Primária e Estrangeira.

/*

- Tabela Dimensão: É uma tabela que contém as características de determinado elemento.
Por exemplo, uma tabela de clientes possui as características do elemento cliente. Nenhum dos
elementos da tabela dimensão pode se repetir.

- Tabela Fato: É uma tabela que contém os fatos de um negócio. Vendas, Contratos, Atendimentos.
Geralmente é uma tabela bem grande, com centenas, milhares ou até milhões de linhas. 

- Chave Primária: Coluna de uma tabela que identifica as linhas daquela tabela de forma única.

- Chave Estrangeira: Coluna de uma tabela que será usada para se relacionar com a chave primária 
de outra tabela.


*/


-- III. Joins
-- 1. (INNER) JOIN: Realiza o relacionamento entre as tabelas e retorna apenas as linhas
-- que são comuns entre as duas tabelas.

-- a) Utilize o (INNER) JOIN para relacionar as tabelas EMPLOYEES e DEPARTMENTS.

SELECT
    employees.employee_id,
    employees.first_name,
    employees.salary,
    departments.department_name
FROM employees
JOIN departments
ON employees.department_id = departments.department_id;

-- b) Faça o mesmo exercício anterior, mas dessa vez adicionando um ALIAS às tabelas.

SELECT
    e.employee_id,
    e.first_name,
    e.salary,
    d.department_name
FROM employees e
JOIN departments d
ON e.department_id = d.department_id;

-- c) Utilize o (INNER) JOIN para relacionar as tabelas DEPARTMENTS e LOCATIONS.

SELECT
    d.department_id,
    d.department_name,
    l.city,
    l.country_id
FROM departments d
JOIN locations l
ON d.location_id = l.location_id;

-- d) Faça um INNER JOIN entre múltiplas tabelas e relacione as tabelas 
-- EMPLOYEES, DEPARTMENTS, JOBS e LOCATIONS.

SELECT
    e.employee_id, e.first_name, d.department_name, j.job_title, l.city, l.country_id
FROM employees e
    JOIN departments d ON e.department_id = d.department_id
    JOIN jobs j ON e.job_id = j.job_id
    JOIN locations l ON d.location_id = l.location_id;


-- IV. SELF JOIN: Realiza o auto-relacionamento de uma tabela com ela mesma.

-- a) Como podemos visualizar a lista de funcionários e os respectivos gerentes em uma mesma tabela?

SELECT
    e.employee_id,
    e.first_name funcionario,
    g.first_name gerente    
FROM employees e JOIN employees g
ON e.manager_id = g.employee_id
ORDER BY e.employee_id;


-- V. LEFT JOIN: Realiza o relacionamento entre as tabelas e retorna as linhas que são 
-- comuns entre as duas tabelas e também as linhas que existem apenas na tabela da ESQUERDA.

-- a) Utilize o LEFT JOIN para relacionar as tabelas EMPLOYEES e DEPARTMENTS.

SELECT
    e.employee_id,
    e.first_name,
    e.salary,
    d.department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id;


-- VI. RIGHT JOIN: Realiza o relacionamento entre as tabelas e retorna as linhas que são 
-- comuns entre as duas tabelas e também as linhas que existem apenas na tabela da DIREITA.

-- a) Utilize o RIGHT JOIN para relacionar as tabelas EMPLOYEES e DEPARTMENTS.

SELECT
    e.employee_id,
    e.first_name,
    e.salary,
    d.department_name
FROM employees e RIGHT JOIN departments d
ON e.department_id = d.department_id
ORDER BY employee_id;



-- VII. FULL JOIN: Realiza o relacionamento entre as tabelas e retorna TODAS as linhas das tabelas.

-- a) Utilize o FULL JOIN para relacionar as tabelas EMPLOYEES e DEPARTMENTS.

SELECT
    e.employee_id,
    e.first_name,
    e.salary,
    d.department_name
FROM employees e FULL JOIN departments d
ON e.department_id = d.department_id;


-- VIII. CROSSJOIN: Realiza o produto cartesiano entre duas colunas.

-- a) Utilize o CROSS JOIN para fazer todas as combinações possíveis entre as colunas
-- DEPARTMENT_NAME e JOB_TITLE.

SELECT
    d.department_name,
    j.job_title
FROM departments d CROSS JOIN jobs j;


-- IX. NONEQUIJOIN: 

-- a) Retorne o id do departamento, nome do departamento e localidade das tabelas LOCATION e
-- DEPARTMENT para o intervalo de location_id entre 1800 e 2500 e department_id abaixo de 30.

SELECT
    d.department_id,
    d.department_name,
    l.location_id,
    l.city
FROM departments d, locations l
WHERE l.location_id BETWEEN 1800 AND 2500
AND d.department_id <= 30;


-- Operadores SET (Operadores de Conjunto)

-- I. UNION ALL: Faz a união entre duas tabelas. As linhas inteiramente iguais são mantidas.

SELECT
    employee_id, job_id, salary
FROM employees
WHERE department_id IN (50, 80, 100)
UNION ALL 
SELECT
    employee_id, job_id, salary
FROM employees
WHERE job_id = 'ST_MAN'
ORDER BY employee_id;



-- II. UNION: Faz a união entre duas tabelas. As linhas inteiramente iguais são excluídas, ficando
-- apenas uma delas.

SELECT
    employee_id, job_id, salary
FROM employees
WHERE department_id IN (50, 80, 100)
UNION
SELECT
    employee_id, job_id, salary
FROM employees
WHERE job_id = 'ST_MAN'
ORDER BY employee_id;



-- III. INTERSECT: Faz a interseção entre duas tabelas.

SELECT
    employee_id, department_id, job_id, salary
FROM employees
WHERE department_id IN (30, 50, 100)
INTERSECT
SELECT
    employee_id, department_id, job_id, salary
FROM employees
WHERE department_id IN (30, 60, 90)
ORDER BY employee_id;


-- IV. MINUS: Faz a 'subtração' entre duas tabelas.

SELECT
    employee_id, department_id, job_id, salary
FROM employees
WHERE department_id IN (30, 50, 100)
MINUS
SELECT
    employee_id, department_id, job_id, salary
FROM employees
WHERE department_id IN (30, 60, 90)
ORDER BY employee_id;

