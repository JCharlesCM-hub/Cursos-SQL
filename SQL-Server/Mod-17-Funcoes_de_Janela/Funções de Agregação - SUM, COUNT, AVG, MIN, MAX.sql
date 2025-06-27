-- Funções de Janela
-- Funções de Agregação: SUM, COUNT, AVG, MIN, MAX

-- 1. Crie uma coluna contendo a SOMA total das vendas da tabela lojas
SELECT 
	ID_Loja,
	Nome_Loja,
	Regiao,
	Qtd_Vendida,
	SUM(Qtd_Vendida) OVER() AS 'Total Vendido'
FROM Lojas
ORDER BY ID_Loja

SELECT 
	ID_Loja,
	Nome_Loja,
	Regiao,
	Qtd_Vendida,
	SUM(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'Total Vendido'
FROM Lojas
ORDER BY ID_Loja

-- 2. Crie uma coluna contendo a CONTAGEM das vendas da tabela lojas
SELECT 
	ID_Loja,
	Nome_Loja,
	Regiao,
	Qtd_Vendida,
	COUNT(*) OVER() AS 'Qtd. Lojas'
FROM Lojas
ORDER BY ID_Loja

SELECT 
	ID_Loja,
	Nome_Loja,
	Regiao,
	Qtd_Vendida,
	COUNT(*) OVER(PARTITION BY Regiao) AS 'Qtd. Lojas'
FROM Lojas
ORDER BY ID_Loja

-- 3. Crie uma coluna contendo a MÉDIA das vendas da tabela lojas
SELECT 
	ID_Loja,
	Nome_Loja,
	Regiao,
	Qtd_Vendida,
	AVG(Qtd_Vendida) OVER() AS 'Qtd. Lojas'
FROM Lojas
ORDER BY ID_Loja

SELECT 
	ID_Loja,
	Nome_Loja,
	Regiao,
	Qtd_Vendida,
	AVG(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'Qtd. Lojas'
FROM Lojas
ORDER BY ID_Loja

-- 4. Crie uma coluna contendo o MIN/MAX das vendas da tabela lojas
SELECT 
	*,
	MIN(Qtd_Vendida) OVER() AS 'Qtd. Lojas'
FROM Lojas
ORDER BY ID_Loja

SELECT 
	*,
	MIN(Qtd_Vendida) OVER(PARTITION BY Regiao) AS 'Qtd. Lojas'
FROM Lojas
ORDER BY ID_Loja
