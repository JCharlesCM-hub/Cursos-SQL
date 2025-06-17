-- [SQL Server] Funções Condicionais
-- Aula 2 de 18: CASE WHEN... ELSE (Explicação)

-- Introdução: A função CASE permite tratar condições no SQL

/*
CASE
	WHEN teste_logico THEN 'resultado1'
	ELSE 'resultado2'
END
*/

-- Exemplo 1: Determine a situação do aluno. Se a Média for >= 6, então está aprovado. Caso contrário, reprovado.

DECLARE @varNota FLOAT
SET @varNota = 6

SELECT
	CASE
		WHEN @varNota >= 6 THEN 'Aprovado'
		ELSE 'Reprovado'
	END AS 'Situação'


-- Exemplo 2: A data de vencimento de um produto é no dia 10/03/2022. Faça um teste lógico para verificar se um produto passou da validade ou não.

DECLARE @varDataVencimento DATETIME, @varDataAtual DATETIME
SET @varDataVencimento = '10/03/2025'
SET @varDataAtual = '30/04/2022'

SELECT
	CASE
		WHEN @varDataAtual > @varDataVencimento THEN 'Produto Vencido'
		ELSE 'Na validade'
	END
