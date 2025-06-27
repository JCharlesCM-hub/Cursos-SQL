-- Mod - 23 - Functions

-- FUNÇÕES: São encontradas dentro do BD / Programação / Funções (várias Funções)
	-- Exemplo: Na columa da esquerda clique no BD Exercicios e siga o caminho acima.
-- 1. O que é uma Function?
-- Uma function é um conjunto de comandos que executam ações e retorna um valor escalar. As functions ajudam a simplificar um código. Por exemplo, se você tem um cálculo complexo que aparece diversas vezes no seu código, em vez de repetir várias vezes aquela série de comandos, você pode simplesmente criar uma função e reaproveitá-la sempre que precisar.
-- O próprio SQL tem diversas funções prontas e até agora, já vimos vários exemplos de funções deste tipo, como funções de data, texto, e assim vai.
-- Podemos visualizar as funções do sistema na pasta Programação > Funções > Funções do Sistema

-- 2. Como criar e utilizar uma Function
-- Imagine que você queira fazer uma formatação diferenciada na coluna data_de_nascimento, utilizando a função DATENAME.
USE Exercicios

SELECT * FROM dCliente
-- SQL sem Função 
SELECT
	nome_cliente,
	data_de_nascimento, 
	DATENAME(DW, data_de_nascimento) + ', ' +  
	DATENAME(D, data_de_nascimento) + ' de ' + 
	DATENAME(M, data_de_nascimento) + ' de ' + 
	DATENAME(YY, data_de_nascimento)  
FROM
	dCliente

-- Criando uma função para formatação de data usando a DATENAME
CREATE FUNCTION fnDataCompleta(@data AS DATE)
RETURNS VARCHAR(MAX)
AS
BEGIN
	RETURN DATENAME(DW, @Data) + ', ' +
			DATENAME(D, @Data) + ' de ' +
			DATENAME(M, @Data) + ' de ' + 
			DATENAME(YY, @Data)
END

-- Atualizar BD (F5) em Funções com Valor Escalar
-- Executar SQL com a Função anterior criada
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
					'(1º Semestre)'
				ELSE
					'(2º Semestre)'
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
-- 4. Criando funções complexas

-- Crie uma função para retornar o primeiro nome de cada gerente
SELECT * FROM dGerente

INSERT INTO dGerente(nome_gerente, data_contratacao, salario) VALUES
	('João', '10/01/2019', 3100)

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



