/*
MODULO 21 � EXERC�CIOS - Functions

Todas as functions dos exerc�cios a seguir devem ser criadas para manipula��o de dados do banco de dados ContosoRetailDW.
1. Crie uma Function que calcule o tempo (em anos) entre duas datas. Essa function deve receber dois argumentos: data_inicial e data_final. Caso a data_final n�o seja informada, a function deve automaticamente considerar a data atual do sistema. Essa function ser� usada para calcular o tempo de casa de cada funcion�rio.
Obs: a fun��o DATEDIFF n�o � suficiente para resolver este problema.
*/
USE ContosoRetailDW
SELECT * FROM DimEmployee

SELECT 
	FirstName, 
	HireDate, 
	EndDate, 
	DATEDIFF(YEAR, HireDate, EndDate)  
FROM DimEmployee

CREATE OR ALTER FUNCTION CalculaDiferencaDatas(@data_inicial DATE, @data_final DATE) 
RETURNS INT
AS
BEGIN
	IF @data_final IS NULL SET @data_final = GETDATE()
	RETURN DATEDIFF(YEAR, @data_inicial, @data_final)
END
-- Atualizar 
SELECT 
	FirstName, 
	HireDate, 
	EndDate, 
	DATEDIFF(YEAR, HireDate, EndDate), 
	dbo.CalculaDiferencaDatas(HireDate, EndDate) 
FROM DimEmployee

/*
2. Crie uma function que calcula a bonifica��o de cada funcion�rio (5% a mais em rela��o ao BaseRate). Por�m, tome cuidado! Nem todos os funcion�rios dever�o receber b�nus...
*/  
SELECT * FROM DimEmployee

CREATE OR ALTER FUNCTION CalculaBonus (@salario FLOAT, @status VARCHAR(100), @percentual FLOAT) 
RETURNS FLOAT 
AS
BEGIN
	DECLARE @bonus AS FLOAT

	IF @status = 'Current' 
		SET @bonus = @salario * @percentual
	ELSE 
		SET @bonus = 0

	RETURN @bonus
END
-- Atualizar
SELECT 
	FirstName, 
	BaseRate, 
	Status, 
	dbo.CalculaBonus(Baserate, status, 0.5) 
FROM DimEmployee

/*
3. Crie uma Function que retorna uma tabela. Esta function deve receber como par�metro o g�nero do cliente e retornar todos os clientes que s�o do g�nero informado na function.
Observe que esta function ser� utilizada particularmente com a tabela DimCustomer.
*/
SELECT * FROM DimCustomer

CREATE OR ALTER FUNCTION select_genero(@genero VARCHAR(100))
RETURNS TABLE
AS 
RETURN (SELECT * FROM DimCustomer WHERE gender = @genero)
-- Atualizar 
SELECT * FROM dbo.select_genero('F')

/*
4. Crie uma Function que retorna uma tabela resumo com o total de produtos por cores. Sua function deve receber 1 argumento, onde ser� poss�vel especificar de qual marca voc� deseja o resumo.
*/
CREATE OR ALTER FUNCTION analisa_cores(@marca VARCHAR(100))
RETURNS TABLE
AS 
RETURN (SELECT ColorName, COUNT(*) Total 
		FROM DimProduct 
		WHERE BrandName = @marca 
		GROUP BY ColorName)
-- Atualizar 
SELECT * FROM dbo.analisa_cores('Contoso')
