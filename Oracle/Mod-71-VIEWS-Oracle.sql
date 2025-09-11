-- Criando Views

-- O que é?
-- Uma View nada mais é do que o resultado do SELECT salvo no nosso banco de dados.

SELECT * FROM employees
WHERE job_id = 'ST_MAN';



-- Vantagens de se usar Views:
-- 1. Restringir acesso aos dados 
-- Por exemplo, se queremos dar acesso à tabela de employees a um usuário, mas não à coluna 
-- de salário. Podemos criar uma view a partir da tabela, e dar acesso apenas à view.

-- 2. Reutilizar consultas complexas
-- Se precisamos usar com frequência uma consulta que possui muitos joins, where, group by, etc,
-- em vez de recriar o código toda vez, podemos criar uma view e reaproveitar de forma mais simples.

-- 3. Representar diferentes visões de uma mesma tabela
-- Podemos fazer diferentes filtros em uma mesma tabela, para que diferentes visões sejam 
-- compartilhadas entre diferentes usuários.















-- 1. Criando/Substituindo uma View
-- Crie uma View armazenando o resultado dos funcionários de JOB_ID = 'ST_MAN'.

CREATE OR REPLACE VIEW vEmpSTMan AS
SELECT *
FROM employees
WHERE job_id = 'ST_MAN';


SELECT * FROM vEmpSTMan;


-- 2. Excluindo uma view

DROP VIEW vEmpSTMan;








