-- [SQL Server] Manipulando Strings e Datas no SQL
-- Aula 2 de 23: LEN e DATALENGTH

-- Exemplo: Descubra a quantidade de caracteres da palavra 'SQL Hashtag'

SELECT
	LEN('SQL Hashtag') AS 'Len',
	DATALENGTH('SQL Hashtag') AS 'Datalength'