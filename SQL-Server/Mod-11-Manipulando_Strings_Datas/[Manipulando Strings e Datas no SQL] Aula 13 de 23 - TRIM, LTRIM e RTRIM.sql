-- [SQL Server] Manipulando Strings e Datas no SQL
-- Aula 13 de 23: TRIM, LTRIM e RTRIM

-- Funções para retirar espaços adicionais dentro de um texto
-- TRIM: Retira espaços adicionais à esquerda e à direita do texto
-- LTRIM: Retira espaços adicionais à esquerda do texto
-- RTRIM: Retira espaços adicionais à direita do texto

-- Utilize as funções acima no código '   ABC123   '

DECLARE @varCodigo VARCHAR(50)
SET @varCodigo = '   ABC123   '

SELECT
	TRIM(@varCodigo) AS 'Trim',
	LTRIM(@varCodigo) AS 'Ltrim',
	RTRIM(@varCodigo) AS 'Rtrim'

SELECT
	DATALENGTH(TRIM(@varCodigo)) AS 'Trim',
	DATALENGTH(LTRIM(@varCodigo)) AS 'Ltrim',
	DATALENGTH(RTRIM(@varCodigo)) AS 'Rtrim'
