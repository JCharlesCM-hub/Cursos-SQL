/* 
MOD - 24 - EXERCICIOS - PROCEDURES

Obs. As Procedures dos exerc�cios 1 a 3 ser�o executadas nas tabelas originais do banco de dados ContosoRetailDW.
1. Crie uma Procedure que resume o total de produtos por nome da categoria. Essa Procedure deve solicitar ao usu�rio qual marca deve ser considerada na an�lise.
*/ 
USE ContosoRetailDW

SELECT TOP(5) * FROM DimProduct
SELECT TOP(5) * FROM DimProductSubcategory
SELECT TOP(5) * FROM DimProductCategory

CREATE OR ALTER PROCEDURE analisa_produtos(@marca VARCHAR(100))
AS
BEGIN
	SELECT
		c.ProductCategoryName, 
		COUNT(*) 
	FROM DimProduct p 
	INNER JOIN DimProductSubcategory s ON p.ProductSubcategoryKey = s.ProductSubcategoryKey 
		INNER JOIN DimProductCategory c ON s.ProductCategoryKey = c.ProductCategoryKey 
	WHERE p.BrandName = @marca 
	GROUP BY c.ProductCategoryName
END

EXECUTE analisa_produtos 'Contoso'

EXECUTE analisa_produtos 'Litware' 

/*
2. Crie uma Procedure que lista os top N clientes de acordo com a data de primeira compra. O valor de N deve ser um par�metro de entrada da sua Procedure.
*/ 
USE ContosoRetailDW

SELECT TOP(5) * FROM DimCustomer
CREATE OR ALTER PROCEDURE lista_top_clientes(@topn INT)
AS
BEGIN
	SELECT TOP(@topn) 
		FirstName,
		EmailAddress, 
		DateFirstPurchase 
	FROM DimCustomer 
	WHERE CustomerType = 'Person'  
	ORDER BY DatefirstPurchase
END

EXECUTE lista_top_clientes 100

/*
3. Crie uma Procedure que recebe 2 argumentos: M�S (de 1 a 12) e ANO (1996 a 2003). Sua Procedure deve listar todos os funcion�rios que foram contratados no m�s/ano informado.
*/  
SE ContosoRetailDW

CREATE OR ALTER PROCEDURE lista_funcionarios(@mes INT, @ano INT)
AS
BEGIN
	SELECT *  
	FROM DimEmployee 
	WHERE DATEPART(MM, HireDate) = @mes AND DATEPART(YYYY, HireDate) = @ano  
	ORDER BY HireDate
END

EXECUTE lista_funcionarios 1, 2000


/*
Obs. Para os exerc�cios 4, 5 e 6, utilize os c�digos abaixo.
*/

DROP DATABASE AlugaFacil

CREATE DATABASE AlugaFacil

USE AlugaFacil

CREATE TABLE Carro(
	id_carro INT,
	placa VARCHAR(100) NOT NULL,
	modelo VARCHAR(100) NOT NULL,
	tipo VARCHAR(100) NOT NULL,
	valor FLOAT NOT NULL,
	CONSTRAINT carro_id_carro_pk PRIMARY KEY(id_carro)
)

INSERT INTO Carro(id_carro, placa, modelo, tipo, valor) VALUES
	(1, 'CRU-1111', 'Chevrolet Cruze', 'Sedan', 140000),
	(2, 'ARG-2222', 'Fiat Argo', 'Hatch', 80000),
	(3, 'COR-3333', 'Toyota Corolla', 'Sedan', 170000),
	(4, 'TIG-4444', 'Caoa Chery Tiggo', 'SUV', 190000)

SELECT * FROM Carro
-- 4. Crie uma Procedure que insere uma nova linha na tabela Carro. Essa nova linha deve conter os seguintes dados:
-- id = 5
-- placa = GOL-5555
-- modelo = Volkswagen Gol
-- tipo = Hatch
-- valor = 80000

CREATE OR ALTER PROCEDURE cadastro_carro
AS
BEGIN
	BEGIN TRANSACTION 
	INSERT INTO Carro(id_carro, placa, modelo, tipo, valor)  
		VALUES (7, 'GOL-5555', 'Volkswagem Gol', 'Hatch', 80000)
	COMMIT
END

EXECUTE cadastro_carro

SELECT * FROM Carro

-- 5. Crie uma Procedure que altera o valor de venda de um carro. A Procedure deve receber como par�metros o id_carro e o novo valor.

CREATE OR ALTER PROCEDURE altera_valor(@id INT, @novo_valor FLOAT)
AS
BEGIN
	BEGIN TRANSACTION
		UPDATE Carro 
		SET valor = @novo_valor 
		WHERE id_carro = @id
	COMMIT
END

SELECT * FROM Carro

EXECUTE altera_valor 1, 200000

SELECT * FROM Carro

-- 6. Crie uma Precedure que exclui um carro a partir do id informado.
CREATE OR ALTER PROCEDURE deleta_carro(@id INT)
AS
BEGIN
	BEGIN TRANSACTION
		DELETE FROM Carro 
		WHERE id_carro = @id
	COMMIT
END

SELECT * FROM Carro

EXECUTE deleta_carro 1

SELECT * FROM Carro
