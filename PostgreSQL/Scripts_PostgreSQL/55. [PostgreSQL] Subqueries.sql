-- +++++++++++++++++++++++++++++++++
/*
55. [PostgreSQL] Subqueries
1. O que é uma Subquery
2. Subquery: Cláusula WHERE
3. Subquery: Cláusula FROM
4. Subquery: Cláusula SELECT
5. Subquery: Corrigindo a análise de pedidos acima da média
Feedback do módulo
*/
/*
Em PostgreSQL, uma subquery, também conhecida como subseleção ou consulta aninhada, é uma consulta SQL que está inserida dentro de outra consulta, seja ela uma instrução SELECT, INSERT, UPDATE ou DELETE. Basicamente, a subquery é executada primeiro, e o resultado que ela retorna é utilizado pela consulta principal. 
Em termos mais simples: Imagine uma receita de bolo. A subquery é como misturar os ingredientes antes de colocar a massa no forno (a consulta principal). Você precisa ter os ingredientes certos (o resultado da subquery) para poder fazer o bolo (a consulta principal). 

Características:
Aninhamento:
	* Subqueries são sempre inseridas dentro de outras consultas, criando um nível de aninhamento. 
Execução:
	* A subquery é executada primeiro e seu resultado é usado pela consulta principal. 
Utilização:
	* Podem ser usadas em diversas partes de uma consulta, como na cláusula WHERE, FROM, SELECT, entre outras. 
Finalidade:
	* Permitem realizar operações mais complexas e sofisticadas, que seriam difíceis ou impossíveis de serem feitas com uma única consulta. 
Exemplos de uso:
	* Filtragem de dados: Usar o resultado de uma subquery para filtrar os dados da consulta principal. 
Cálculos complexos: Realizar cálculos complexos utilizando o resultado de uma subquery. 
	* Inserção, atualização e exclusão: Usar o resultado de uma subquery para inserir, atualizar ou excluir dados em uma tabela. 
Exemplo prático:
	* Suponha que você queira encontrar os produtos que têm o maior preço em uma tabela de produtos. Você poderia usar uma subquery para encontrar o preço máximo e, em seguida, usar essa informação na consulta principal para selecionar os produtos com esse preço. 

Vantagens:
Flexibilidade:
	* Permite criar consultas mais complexas e adaptáveis a diferentes cenários. 
Reutilização:
	* O resultado de uma subquery pode ser reutilizado em várias partes da consulta principal. 
Legibilidade:
	* Em alguns casos, pode tornar a consulta mais legível, especialmente quando a lógica é complexa. 

Desvantagens:
Desempenho:
	* Em alguns casos, subqueries podem ter um impacto negativo no desempenho da consulta, especialmente se não forem otimizadas. 
Complexidade:
	* Consultas com muitas subqueries podem se tornar difíceis de entender e manter. 

Em resumo, subqueries são uma ferramenta poderosa no PostgreSQL para lidar com consultas complexas e flexíveis. No entanto, é importante usá-las com cuidado e otimizá-las para garantir o melhor desempenho. 
*/
-- Aula 1 - O que é uma Subquery
-- Subqueries no SQL são queries dentro de queries. É a possibilidade de reaproveitar o resultado de uma query (select) dentro de outra.
-- Exemplo: Quais produtos têm um preço acima da média?
select * from products;

select avg(unit_price) from products; -- 28.833896...

select * from products
where unit_price >= (select avg(unit_price) from products);

-- Aula 2 - Subquery: Cláusula WHERE
-- Exemplo: Quais pedidos têm uma quantidade vendida acima da quantidade vendida média? 
select * from order_details;

select avg(quantity) from order_details; -- 23.81299...

select * from order_details
where quantity >= (
                    select 
                        avg(quantity) 
                    from order_details
                  );

-- Aula 3 - Subquery: Cláusula FROM
-- Exemplo: Qual é a média de clientes de acordo com o cargo?
select * from customers;

select
    avg(total_clientes)
from (
    select 
        contact_title,
        count(*) total_clientes
    from customers 
    group by contact_title) t;

-- Aula 4 - Subquery: Cláusula SELECT
-- Exemplo: Faça uma consulta à tabela products e adicione uma coluna que contenha a média geral de preço dos produtos.
select * from products;

select 
    *,
    (select avg(unit_price) from products) media_preco
from products;

-- Aula 5 - Subquery: Corrigindo a análise de pedidos acima da média
-- Exemplo: Quais pedidos têm uma quantidade vendida acima da quantidade vendida média? 
select * from order_details;
-- Quantidade no Pedido
select 
		order_id,
		sum(quantity) total_vendido
	from order_details
	group by order_id;   
--
select
		avg(total_vendido)
	from (
		select 
			order_id,
			sum(quantity) total_vendido
		from order_details
		group by order_id) t;  -- Media de quantidade = 61.827710843373....
--
select 
    order_id,
    sum(quantity)
from order_details
group by order_id
having sum(quantity) >= (
                select
                    avg(total_vendido)
                from (
                    select 
                        order_id,
                        sum(quantity) total_vendido
                    from order_details
                    group by order_id) t);


