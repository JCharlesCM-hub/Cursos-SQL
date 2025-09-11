-- Subqueries

-- I. O que é uma subquery? 

-- Subquery é um recurso dentro do SQL que nos permite criar queries mais otimizadas,
-- reaproveitando o resultado de uma query dentro de outra query.

-- Subqueries podem ser usadas em 3 situações:

-- 1) Dentro da cláusula WHERE, como um filtro

-- 2) Dentro da cláusula SELECT, como uma nova coluna

-- 3) Dentro da cláusula FROM, como uma nova tabela


-- Essas subqueries podem ser divididas em 3 tipos:
-- 1) Subqueries escalares
-- 2) Subqueries de linha múltipla
-- 3) Subqueries correlacionadas




-- Quais são os funcionários que ganham um salário acima da média.

SELECT AVG(salary) FROM employees;

SELECT * FROM employees
WHERE salary >= 6461.68;





-- II. Subqueries escalar na cláusula WHERE (single row)

-- Subqueries escalares retornam valores únicos, sempre 1 linha e 1 coluna.

-- a) Quais funcionários recebem um salário acima da média de todos os funcionários?


-- 1º) Descobrir a média de salário

SELECT AVG(salary) FROM employees;


-- 2º) Filtrar a tabela EMPLOYEES baseado no valor acima.

SELECT *
FROM employees
WHERE salary >= (SELECT AVG(salary) FROM employees)
ORDER BY salary DESC;



-- Um detalhe importante sobre a subquery acima é que ela é executada de dentro pra fora.
-- Primeiro é executado a query mais interna, para só depois executar a query mais externa.
-- Dessa forma, não existe nenhuma dependência da query interna em relação à query externa.
-- Ela é calculada de forma independente.
-- Em alguns casos, no entanto, a query mais interna depende da query externa.






-- III) Subqueries de linha múltipla na cláusula WHERE (multiple row): IN e NOT IN

-- Exemplo: Quais são os funcionários que pertencem aos departamentos de location_id = 1700 (Seattle US)?

-- SELECT * FROM employees
-- WHERE department_id IN (10, 30, 90...)  


-- 1º)  Descobrir quais ids dos departamentos dessas localidades.

SELECT department_id FROM departments
WHERE location_id = 1700;




-- 2º) Quais funcionários são destes departamentos. 

SELECT * FROM employees
WHERE department_id IN (
                        SELECT department_id FROM departments
                        WHERE location_id = 1700
                        );













-- III) Subqueries de linha múltipla na cláusula WHERE (multiple row): ANY e ALL

-- Exemplo: Faça um filtro na tabela EMPLOYEES que mostre todos os funcionários que possuem
-- um salário igual a qualquer uma das médias salarias agrupadas por departamento.

SELECT AVG(salary) FROM employees 
GROUP BY department_id
ORDER BY AVG(salary) DESC;

-- IN

SELECT *
FROM employees
WHERE salary IN (SELECT AVG(salary) FROM employees GROUP BY department_id);



-- Exemplo: Faça um filtro na tabela EMPLOYEES que mostre todos os funcionários que possuem
-- um salário MENOR QUE QUALQUER uma das médias salarias agrupadas por departamento.

-- ANY

SELECT *
FROM employees
WHERE salary > ANY (SELECT AVG(salary) FROM employees GROUP BY department_id)
ORDER BY salary DESC;


-- Exemplo: Faça um filtro na tabela EMPLOYEES que mostre todos os funcionários que possuem
-- um salário MENOR QUE TODAS as médias salarias agrupadas por departamento.

-- ALL

SELECT *
FROM employees
WHERE salary > ALL (SELECT AVG(salary) FROM employees GROUP BY department_id)
ORDER BY salary DESC;








-- Subquery linha múltipla e coluna múltipla.

-- Encontre os funcionários que ganham o maior salário de cada departamento.

SELECT
    department_id,
    MAX(salary)
FROM employees
GROUP BY department_id;


SELECT *
FROM employees
WHERE (department_id, salary) IN (
                                SELECT
                                    department_id,
                                    MAX(salary)
                                FROM employees
                                GROUP BY department_id
                                )
ORDER BY department_id;




















-- IV. EXISTS/NOT EXISTS: Exemplo 1

-- Exemplo: Liste as informações dos departamentos que possuem funcionários. 
-- Liste também os departamentos que NÃO possuem funcionários.

-- Passo 1: Descobrir os valores distintos de department_id da tabela EMPLOYEES.

SELECT DISTINCT(department_id) FROM employees;

-- Passo 2: Descobrir os valores distintos de department_id da tabela DEPARTMENTS.

SELECT DISTINCT department_id FROM departments;






-- Passo 3: Utilizar o IN/NOT IN para descobrir os departamentos que têm funcionários. 


 SELECT * FROM departments
 WHERE department_id NOT IN (
                        SELECT DISTINCT department_id 
                        FROM employees 
                        WHERE department_id IS NOT NULL
                        );
 
 
 
 
 
 

-- IV. EXISTS/NOT EXISTS: Exemplo 1

-- Exemplo: Liste as informações dos departamentos que possuem funcionários. 
-- Liste também os departamentos que NÃO possuem funcionários.


SELECT * FROM departments;

SELECT * FROM employees
WHERE department_id = 120;


SELECT * FROM departments d
WHERE NOT EXISTS (SELECT * FROM employees e
                WHERE e.department_id = d.department_id);






















-- EXISTS: Exemplo 2
-- Faça uma consulta que retorna apenas os funcionários que também são gerentes.

SELECT * FROM employees;

SELECT * FROM employees
WHERE manager_id = 130;


SELECT * FROM employees g
WHERE EXISTS (
                SELECT * FROM employees e
                WHERE e.manager_id = g.employee_id
                )
ORDER BY employee_id;




















-- V. Subquery correlacionada

-- Uma subquery correlacionada é aquela em que a subquery interna possui uma dependência
-- da subquery externa.


-- Exemplo 1. Funcionários que ganham acima da média salarial do seu departamento.

SELECT * FROM employees;

SELECT AVG(salary) FROM employees
WHERE department_id = 10;


SELECT *
FROM employees e1
WHERE e1.salary >= (
                    SELECT AVG(e2.salary) 
                    FROM employees e2
                    WHERE e2.department_id = e1.department_id
                );


















-- Exemplo 2: Funcionários que ganham o maior salário de seus departamentos.

SELECT *
FROM employees e1
WHERE e1.salary = (
                    SELECT
                        MAX(e2.salary)
                    FROM employees e2
                    WHERE e2.department_id = e1.department_id
                );

















-- VI. Subconsulta na cláusula SELECT
-- Faça uma consulta à tabela EMPLOYEES que retorne as seguintes colunas:
-- 1. employee_id
-- 2. first_name
-- 3. job_id
-- 4. salary
-- 5. média de salary

SELECT
    employee_id,
    first_name,
    job_id,
    salary,
    ROUND((SELECT AVG(salary) FROM employees), 2) media_salario,
    salary - ROUND((SELECT AVG(salary) FROM employees), 2) desvio_salario
FROM employees;














-- VII. Subconsulta na cláusula FROM
-- Considerando a quantidade de funcionários por JOB_ID, qual é o total para o JOB_ID com 
-- a maior quantidade de funcionários? E a menor? E a média?

SELECT
    MAX(qtd_funcionarios) max_funcionarios,
    MIN(qtd_funcionarios) min_funcionarios,
    AVG(qtd_funcionarios) avg_funcionarios
FROM (
        SELECT
            job_id,
            COUNT(*) qtd_funcionarios
        FROM employees
        GROUP BY job_id
    ) t;



















