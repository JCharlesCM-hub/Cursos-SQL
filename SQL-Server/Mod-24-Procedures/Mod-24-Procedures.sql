-- MOD - 24 - PROCEDURES

-- 1. O que é uma Procedure
-- É um bloco de código que possui um nome e pode ser armazenado no banco de dados.
-- Ele pode incluir uma série de comandos SQL para executar alguma tarefa.

-- 2. Por que usar uma Procedure
-- Procedures são usadas para fazer tarefas repetitivas que não são possíveis em queries do SQL ou que dariam muito trabalho.
-- Pode incluir estruturas de controle e comandos.

-- 3. Tipos de Procedure
-- Uma Procedure pode ou não aceitar parãmetros de entrada

-- Procedures Com Parâmetros
-- Procedures Sem Parâmetros

-- ************************************************
-- 2. Criando uma Procedure Sem Parâmetros

-- Exemplo 1. Crie uma Procedure que executa um SELECT simples (sem parâmetros).
USE Exercicios

CREATE PROCEDURE prOrdenaGerentes
AS
BEGIN
	SELECT
		id_gerente,
		nome_gerente,
		salario
	FROM dGerente
	ORDER BY salario DESC
END
-- Atualizar
EXECUTE prOrdenaGerentes

-- ************************************************
-- 3. Criando uma Procedure Com 1 Parâmetro

-- Exemplo 2. Crie uma Procedure que executa um SELECT que recebe um parâmetro de entrada para filtrar a tabela dClientes de acordo com o gênero informado.
USE Exercicios

SELECT * FROM dCliente

CREATE OR ALTER PROCEDURE prListaClientes(@gen VARCHAR(MAX))
AS
BEGIN
	SELECT
		nome_cliente,
		genero,
		data_de_nascimento,
		cpf
	FROM dCliente
	WHERE genero = @gen
END
-- Atualizar
EXECUTE prListaClientes 'M'

-- ****************************************
-- 4. Criando uma Procedure com mais de 1 parâmetro

-- Exemplo 3. Crie uma Procedure que executa um SELECT que recebe um parâmetro de entrada para filtrar a tabela dClientes de acordo com o gênero informado e ano de nascimento informado.
USE Exercicios

CREATE OR ALTER PROCEDURE prListaClientes(@gen VARCHAR(MAX), @ano INT)
AS
BEGIN
	SELECT
		nome_cliente,
		genero,
		data_de_nascimento,
		cpf
	FROM dCliente
	WHERE genero = @gen AND YEAR(data_de_nascimento) = @ano
END

EXECUTE prListaClientes 'M', 1989

-- ***********************************************
-- 5. Criando uma Procedure com Parâmetro Default

-- Exemplo 3. Crie uma Procedure que executa um SELECT que recebe um parâmetro de entrada para filtrar a tabela dClientes de acordo com o gênero informado e ano de nascimento informado.
USE Exercicios

CREATE OR ALTER PROCEDURE prListaClientes(@gen VARCHAR(MAX)='M', @ano INT)
AS
BEGIN
	SELECT
		nome_cliente,
		genero,
		data_de_nascimento,
		cpf
	FROM dCliente
	WHERE genero = @gen AND YEAR(data_de_nascimento) = @ano
END

EXECUTE prListaClientes @gen='F', @ano=1989

-- 6. Criando uma Procedure mais Complexa para Cadastro de Contratos

-- Exemplo: Crie uma procedure para cadastrar uma nova assinatura de um contrato na tabela fContratos (com parâmetros).
-- Gerente: Lucas Sampaio
-- Cliente: Gustavo Barbosa
-- Valor do Contrato: 5000

-- 1º Passo: Definir as variáveis a serem utilizadas.
-- 2º Passo: Armazenar o valor de id_gerente de acordo com o gerente associado
-- 3º Passo: Armazenar o valor de id_cliente de acordo com o nome do cliente
-- 4º Passo: Armazenar a data da assinatura como sendo a data atual do sistema
-- 5º Passo: Utilizar o INSERT INTO para inserir os dados na tabela fContratos
USE Exercicios

SELECT * FROM dCliente
SELECT * FROM dGerente
SELECT * FROM fContratos

CREATE OR ALTER PROCEDURE prRegistraContrato(@gerente VARCHAR(MAX), @cliente VARCHAR(MAX), @valor FLOAT)
AS
BEGIN
	DECLARE
		@vIdGerente INT,
		@vIdCliente INT
		
	SELECT
		@vIdGerente = id_gerente
		FROM dGerente
		WHERE nome_gerente = @gerente

	SELECT
		@vIdCliente = id_cliente
		FROM dCliente
		WHERE nome_cliente = @cliente

	INSERT INTO fContratos(data_assinatura, id_cliente, id_gerente, valor_contrato) VALUES
		(GETDATE(), @vIdCliente, @vIdGerente, @valor)

	PRINT 'Contrato registrado com sucesso!'
END

EXECUTE prRegistraContrato @gerente='Lucas Sampaio', @cliente='Gustavo Barbosa', @valor=5000

SELECT * FROM fContratos
SELECT * FROM dCliente
SELECT * FROM dGerente

-- ***************************************
-- 7. Excluindo uma Procedure
DROP PROCEDURE prRegistraContrato

-- ***************************************
-- 8. Functions vs. Procedures
/*

Temos abaixo uma lista de principais diferenças entre Functions e Procedures.

Diferença 1.
- Procedures são usadas para executar um processo, uma sequência de comandos e blocos SQL.
- Functions são usadas para fazer cálculos

Diferença 2.
- Procedures não podem ser 'chamadas' dentro da cláusula SELECT
- Functions podem ser 'chamadas' dentro da cláusula SELECT (desde que não contenham comandos SELECT)

Diferença 3.
- Procedures não precisam retornar nenhum valor
- Functions precisam retornar algum valor
*/


