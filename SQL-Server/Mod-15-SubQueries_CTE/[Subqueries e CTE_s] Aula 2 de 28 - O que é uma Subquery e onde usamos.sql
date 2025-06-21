-- [SQL Server] Subqueries e CTE's

-- Aula 2 de 28: O que é uma Subquery e onde usamos

/*
1. O que é uma Subquery?

Uma Subconsulta (ou Subquery ou SubSELECT) nada mais é do que uma consulta dentro de outra consulta. Ou seja, com uma subquery conseguimos utilizar o resultado de uma query (consulta) dentro de outra consulta.
*/


/*
2. Onde utilizamos uma Subquery
Subqueries podem ser utilizadas em 3 situações possíveis:
Junto com o Where, funcionando como um filtro variável
Junto com o SELECT, como uma nova coluna na tabela
Junto com o FROM, como uma nova tabela

Ex: Imagina que eu quero selecionar os produtos com o Preço maior do que a média.
*/
SELECT
	*
FROM
	Produtos
WHERE Preço > 10.5

SELECT AVG(Preço) FROM Produtos
/*
3. Onde usamos uma subquery?

Em 4 situações possíveis:

1- Subquery junto com um WHERE, como um filtro dinâmico e escalar (valor único)
*/
SELECT
	Coluna1,
	Coluna2
FROM
	Tabela
WHERE Coluna1 = (SELECT)
/*
2- Subquery junto com um WHERE, como um filtro dinâmico e em lista (vários valores)
*/
SELECT
	Coluna1,
	Coluna2
FROM
	Tabela
WHERE Coluna1 IN (SELECT)
/*
3- Subquery junto com um SELECT, como uma nova coluna
*/
SELECT
	Coluna1,
	Coluna2,
	(SELECT)
FROM
	Tabela
/*
4- Subquery junto com um FROM, como uma nova tabela
*/
SELECT
	Coluna1,
	Coluna2
FROM
	(SELECT) AS T
