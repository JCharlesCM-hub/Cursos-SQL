/* COMENTÁRIOS */
-- Para comentários de linha única, usa-se "--" no início da linha. 
-- Para comentários de múltiplas linhas, utiliza-se "/*" para iniciar e "*/" para finalizar. 

/* 
	Selecionar dados das tabelas.
*/
SELECT * FROM categories;

SELECT * FROM customers;

SELECT * FROM employees;

SELECT category_id, category_name  
	FROM categories;

SELECT first_name, last_name   
	FROM employees;

SELECT product_id, product_name, unit_price  
	FROM products;

-- 3. SELECT AS - Aliasing (renomeando) colunas e tabela
SELECT 
	pr.product_id AS id_produto, 
	pr.product_name AS nome_produto, 
	pr.unit_price AS preco_unitario  
	FROM products AS pr;

SELECT * FROM orders AS ordem;
SELECT ordem.* FROM orders AS ordem;

-- 4. SELECT LIMIT - Limitando a quantidade de linhas de uma query
SELECT * FROM orders LIMIT 5;
SELECT * FROM categories LIMIT 10;

-- 5. SELECT DISTINCT - Selecionando valores distintos de uma coluna
-- Consultar as profissões(contact_title) distintas da tabela customers:
SELECT * FROM customers;
SELECT DISTINCT contact_title FROM customers;
SELECT DISTINCT(contact_title) FROM customers;





