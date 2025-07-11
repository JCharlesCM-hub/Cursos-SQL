/*
MOD-16 - EXERC�CIOS LOOPS

1. Utilize o Loop While para criar um contador que comece em um valor inicial @ValorInicial e termine em um valor final @ValorFinal. Voc� dever� printar na tela a seguinte frase:
�O valor do contador �: � + ___
*/  
DECLARE @valorInicial INT
DECLARE @valorFinal INT

SET @valorInicial = 1
SET @valorFinal = 100

WHILE @valorInicial <= @valorFinal
BEGIN
	PRINT CONCAT('O valor do contador �: ', @valorInicial) 
	SET @valorInicial = @valorInicial +1
END
/*
2. Voc� dever� criar uma estrutura de repeti��o que printe na tela a quantidade de contrata��es para cada ano, desde 1996 at� 2003. A informa��o de data de contrata��o encontra-se na coluna HireDate da tabela DimEmployee. Utilize o formato:
X contrata��es em 1996
Y contrata��es em 1997
Z contrata��es em 1998
...
...
N contrata��es em 2003
Obs: a coluna HireDate cont�m a data completa (dd/mm/aaaa). Lembrando que voc� dever� printar a quantidade de contrata��es por ano.
*/
USE ContosoRetailDW
DECLARE @anoInicial INT = 1996
DECLARE @anoFinal INT = 2003

WHILE @anoInicial <= @anoFinal
BEGIN
	DECLARE @QtdFuncionarios INT = (SELECT COUNT(*) FROM DimEmployee 
									WHERE YEAR(HireDate) = @anoInicial)
	PRINT CONCAT(@QtdFuncionarios, ' contrata��es em: ', @anoInicial) 
	SET @anoInicial = @anoInicial +1
END
/*
3. Utilize um Loop While para criar uma tabela chamada Calendario, contendo uma coluna que comece com a data 01/01/2021 e v� at� 31/12/2021.
*/
USE Exercicios

CREATE TABLE Calendario (
	Data DATE
)

DECLARE @DataInicio DATE = '01/01/2021'
DECLARE @DataFim DATE = '31/12/2021'

WHILE @DataInicio <= @DataFim
BEGIN
	INSERT INTO Calendario (Data) VALUES(@DataInicio)
	SET @DataInicio = DATEADD(DAY, 1, @DataInicio) 
END

SELECT * FROM Calendario