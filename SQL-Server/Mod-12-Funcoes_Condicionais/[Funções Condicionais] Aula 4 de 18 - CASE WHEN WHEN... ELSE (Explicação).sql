-- [SQL Server] Funções Condicionais
-- Aula 4 de 18: CASE WHEN WHEN... ELSE (Explicação)

/*
CASE
	WHEN teste_logico1 THEN 'resultado1'
	WHEN teste_logico2 THEN 'resultado2'
	ELSE 'resultado3'
END

Exemplo 1:

Crie um código para verificar a nota do aluno e determinar a situação:
- Aprovado: nota maior ou igual a 6
- Prova final: noa entre 4 e 6
- Reprovado: nota abaixo de 4

DECLARE @varNota FLOAT
SET @varNota = 1

SELECT
CASE
	WHEN @varNota >= 6 THEN 'Aprovado'
	WHEN @varNota >= 4 THEN 'Prova final'
	ELSE 'Reprovado'
END

*/

-- Exemplo 2: Classifique o produto de acordo com o seu preço:
-- Preço >= 40000: Luxo
-- Preço >= 10000 e Preço < 40000: Econômico
-- Preço < 10000: Básico


DECLARE @varPreco FLOAT
SET @varPreco = 30000

SELECT
	CASE
		WHEN @varPreco >= 40000 THEN 'Luxo'
		WHEN @varPreco >= 10000 THEN 'Econômico'
		ELSE 'Básico'
	END