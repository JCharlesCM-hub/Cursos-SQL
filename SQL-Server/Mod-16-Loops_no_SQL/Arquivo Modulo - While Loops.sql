-- MOD-16 - LOOPs no SQL
-- [SQL Server] Loops no SQL

-- Loop While
-- 1. Crie um contador que fa�a uma contagem de 1 at� 10 utilizando a estrutura de repeti��o WHILE

DECLARE @vContador INT
SET @vContador = 1

WHILE @vContador <= 10
BEGIN
	PRINT 'O valor do contador �: ' + CONVERT(VARCHAR, @vContador)
	SET @vContador = @vContador + 1
END


-- 2. Cuidado com loops infinitos!!!

-- SOLU��O
DECLARE @vContador INT
SET @vContador = 1

WHILE @vContador <= 5
BEGIN
	PRINT 'Algu�m pare esse contador!!!'
END

-- SOLU��O
DECLARE @vContador INT
SET @vContador = 1

WHILE @vContador <= 5
BEGIN
	PRINT 'Algu�m pare esse contador!!!'
	SET @vContador = @vContador + 1
END

-- 3. Fa�a um contador de 1 a 100. OBS: Se o valor do contador for igual a 15, ent�o o loop WHILE deve ser encerrado

DECLARE @vContador INT
SET @vContador = 1

WHILE @vContador <= 100
BEGIN
	PRINT 'O valor do contador �: ' + CONVERT(VARCHAR, @vContador)
	IF @vContador = 15
	BREAK
	SET @vContador = @vContador + 1
END

-- 4. Fa�a um contador de 1 a 100. OBS: Os n�meros 3 ou 6 n�o podem ser printados na tela

DECLARE @varContador INT
SET @varContador = 0

WHILE @varContador <= 10
BEGIN
    SET @varContador += 1
    IF @varContador = 3 OR @varContador = 6
        CONTINUE
    PRINT @varContador
END
