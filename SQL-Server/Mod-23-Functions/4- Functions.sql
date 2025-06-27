-- Mod - 23 - Functions

-- FUN��ES: S�o encontradas dentro do BD / Programa��o / Fun��es (v�rias Fun��es)
	-- Exemplo: Na columa da esquerda clique no BD Exercicios e siga o caminho acima.
-- 1. O que � uma Function?
-- Uma function � um conjunto de comandos que executam a��es e retorna um valor escalar. As functions ajudam a simplificar um c�digo. Por exemplo, se voc� tem um c�lculo complexo que aparece diversas vezes no seu c�digo, em vez de repetir v�rias vezes aquela s�rie de comandos, voc� pode simplesmente criar uma fun��o e reaproveit�-la sempre que precisar.
-- O pr�prio SQL tem diversas fun��es prontas e at� agora, j� vimos v�rios exemplos de fun��es deste tipo, como fun��es de data, texto, e assim vai.
-- Podemos visualizar as fun��es do sistema na pasta Programa��o > Fun��es > Fun��es do Sistema

-- 2. Como criar e utilizar uma Function
-- Imagine que voc� queira fazer uma formata��o diferenciada na coluna data_de_nascimento, utilizando a fun��o DATENAME.
USE Exercicios

SELECT * FROM dCliente
-- SQL sem Fun��o 
SELECT
	nome_cliente,
	data_de_nascimento, 
	DATENAME(DW, data_de_nascimento) + ', ' +  
	DATENAME(D, data_de_nascimento) + ' de ' + 
	DATENAME(M, data_de_nascimento) + ' de ' + 
	DATENAME(YY, data_de_nascimento)  
FROM
	dCliente

-- Criando uma fun��o para formata��o de data usando a DATENAME
CREATE FUNCTION fnDataCompleta(@data AS DATE)
RETURNS VARCHAR(MAX)
AS
BEGIN
	RETURN DATENAME(DW, @Data) + ', ' +
			DATENAME(D, @Data) + ' de ' +
			DATENAME(M, @Data) + ' de ' + 
			DATENAME(YY, @Data)
END

-- Atualizar BD (F5) em Fun��es com Valor Escalar
-- Executar SQL com a Fun��o anterior criada
SELECT
	nome_cliente,
	data_de_nascimento, 
	[dbo].[fnDataCompleta](data_de_nascimento) 
FROM
	dCliente

-- ***************************************************
-- 3. Alterando e excluindo uma function
CREATE OR ALTER FUNCTION fnDataCompleta(@data AS DATE)
RETURNS VARCHAR(MAX)
AS
BEGIN
	RETURN DATENAME(DW, @Data) + ', ' +
			DATENAME(D, @Data) + ' de ' +
			DATENAME(M, @Data) + ' de ' + 
			DATENAME(YY, @Data) + ' - ' +
			CASE
				WHEN MONTH(@Data) <= 6 THEN
					'(1� Semestre)'
				ELSE
					'(2� Semestre)'
			END
END
-- Consultar
SELECT
	nome_cliente,
	data_de_nascimento, 
	[dbo].[fnDataCompleta](data_de_nascimento) 
FROM
	dCliente

-- ***************************************************
-- 4. Criando fun��es complexas

-- Crie uma fun��o para retornar o primeiro nome de cada gerente
SELECT * FROM dGerente

INSERT INTO dGerente(nome_gerente, data_contratacao, salario) VALUES
	('Jo�o', '10/01/2019', 3100)

SELECT
	nome_gerente,
	dbo.fnPrimeiroNome(nome_gerente) AS primeiro_nome
FROM dGerente

CREATE OR ALTER FUNCTION fnPrimeiroNome(@nomeCompleto AS VARCHAR(MAX))
RETURNS VARCHAR(MAX)
AS
BEGIN
	DECLARE @posicaoEspaco AS INT
	DECLARE @resposta AS VARCHAR(MAX)

	SET @posicaoEspaco = CHARINDEX(' ', @nomeCompleto)

	IF @posicaoEspaco = 0
		SET @resposta = @nomeCompleto
	ELSE
		SET @resposta = LEFT(@nomeCompleto, @posicaoEspaco - 1)

	RETURN @resposta
END

SELECT
	nome_gerente,
	dbo.fnPrimeiroNome(nome_gerente) AS primeiro_nome
FROM dGerente



