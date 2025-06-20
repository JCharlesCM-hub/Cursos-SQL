/*
Exercícios 
 
1. a) A partir da tabela DimProduct, crie uma View contendo as informações de 
ProductName, ColorName, UnitPrice e UnitCost, da tabela DimProduct. Chame essa View 
de vwProdutos. 
*/
CREATE VIEW vwProdutos AS
SELECT 
	ProductName AS 'Nome do Produto', 
	ColorName AS 'Cor', 
	UnitPrice AS 'Preço', 
	UnitCost AS 'Custo' 
From
	DimProduct 

GO
SELECT * FROM vwProdutos


/*
b) A partir da tabela DimEmployee, crie uma View mostrando FirstName, BirthDate, 
DepartmentName. Chame essa View de vwFuncionarios. 
*/
GO
CREATE VIEW vwFuncionarios AS
SELECT 
	FirstName AS 'Nome do Funcionário', 
	BirthDate AS 'Data de Nascimento', 
	DepartmentName AS 'Departamento'  
From
	DimEmployee

GO
SELECT * FROM vwFuncionarios

/*
c) A partir da tabela DimStore, crie uma View mostrando StoreKey, StoreName e 
OpenDate. Chame essa View de vwLojas. 
*/
GO
CREATE VIEW vwLojas AS 
SELECT 
	StoreKey, 
	StoreName, 
	OpenDate 
FROM 
	DimStore

GO
SELECT * FROM vwLojas

GO
/*
 
2. Crie uma View contendo as informações de Nome Completo (FirstName + 
LastName), Gênero (por extenso), E-mail e Renda Anual (formatada com R$). 
Utilize a tabela DimCustomer. Chame essa View de vwClientes. 
*/
CREATE VIEW vwClientes AS 
SELECT 
	CONCAT(FirstName, ' ', LastName) as 'Nome Completo' , 
	Replace(Replace(Gender, 'M', 'Masculino'), 'F', 'Feminino') AS 'Gênero',   
	EmailAddress AS 'E-mail',  
	FORMAT(YearlyIncome, 'C') AS 'Renda Anual' 
FROM 
	DimCustomer

GO
SELECT * FROM vwClientes

/* 
3. a) A partir da tabela DimStore, crie uma View que considera apenas as lojas ativas. Faça 
um SELECT de todas as colunas. Chame essa View de vwLojasAtivas. 
*/
GO
CREATE VIEW vwLojasAtivas AS 
SELECT * FROM DimStore 
WHERE Status = 'On'

GO
SELECT * FROM vwLojasAtivas

GO
/*
b) A partir da tabela DimEmployee, crie uma View de uma tabela que considera apenas os 
funcionários da área de Marketing. Faça um SELECT das colunas: FirstName, EmailAddress 
e DepartmentName. Chame essa de vwFuncionariosMkt. 
*/ 
GO
CREATE VIEW vwFuncionariosMkt AS
SELECT 
	FirstName, 
	BirthDate, 
	DepartmentName  
From
	DimEmployee
WHERE DepartmentName = 'Marketing'

GO
SELECT * FROM vwFuncionariosMkt


/* 
c) Crie uma View de uma tabela que considera apenas os produtos das marcas Contoso e 
Litware. Além disso, a sua View deve considerar apenas os produtos de cor Silver. Faça 
um SELECT de todas as colunas da tabela DimProduct. Chame essa View de 
vwContosoLitwareSilver. 
*/
GO
CREATE VIEW vwContosoLitwareSilver AS
SELECT * From DimProduct 
WHERE BrandName IN('Contoso', 'Litware') AND ColorName = 'Silver'

GO
SELECT * FROM vwContosoLitwareSilver
/*
4. Crie uma View que seja o resultado de um agrupamento da tabela FactSales. Este 
agrupamento deve considerar o SalesQuantity (Quantidade Total Vendida) por Nome do 
Produto. Chame esta View de vwTotalVendidoProdutos. 
 
OBS: Para isso, você terá que utilizar um JOIN para relacionar as tabelas FactSales e 
DimProduct. 
*/
GO
CREATE VIEW vwTotalVendidoProdutos AS
SELECT 
	ProductName as 'Nome do Produto', 
	Sum(SalesQuantity) AS 'Qtd. Vendida' 
From 
	FactSales 
INNER JOIN DimProduct 
	ON FactSales.ProductKey = DimProduct.ProductKey
GROUP BY ProductName

GO
SELECT * FROM vwTotalVendidoProdutos


/*
5. Faça as seguintes alterações nas tabelas da questão 1. 
a. Na View criada na letra a da questão 1, adicione a coluna de BrandName. 
*/
GO
ALTER VIEW vwProdutos AS
SELECT 
	ProductName AS 'Nome do Produto',
	BrandName AS 'Marca',
	ColorName AS 'Color', 
	UnitCost AS 'Custo Unitário' 
FROM 
	DimProduct

GO
SELECT * FROM vwProdutos

/*
b. Na View criada na letra b da questão 1, faça um filtro e considere apenas os 
funcionários do sexo feminino. 
*/  
GO
ALTER VIEW vwFuncionarios AS
SELECT 
	FirstName AS 'Nome', 
	BirthDate AS 'Data de Nascimento', 
	DepartmentName AS 'Departamento'  
From
	DimEmployee
WHERE Gender = 'F'

GO
SELECT * FROM vwFuncionarios
/*
c. Na View criada na letra c da questão 1, faça uma alteração e filtre apenas as lojas 
ativas.  
*/
GO
ALTER VIEW vwLojas AS 
SELECT 
	StoreKey AS 'ID Loja', 
	StoreName AS 'Nome da Loja', 
	OpenDate AS 'Data de Abertura'   
FROM 
	DimStore
WHERE Status = 'On' 

GO
SELECT * FROM vwLojas



/*
6. a) Crie uma View que seja o resultado de um agrupamento da tabela DimProduct. O 
resultado esperado da consulta deverá ser o total de produtos por marca. Chame essa 
View de vw_6a.
*/
GO
CREATE VIEW vw_6A AS
SELECT 
	BrandName AS 'Marca', 
	COUNT(*) AS 'Qtd. Produtos'  
FROM 
	DimProduct
GROUP BY BrandName

GO
SELECT * FROM vw_6A
/*
b) Altere a View criada no exercício anterior, adicionando o peso total por marca. Atenção: 
sua View final deverá ter então 3 colunas: Nome da Marca, Total de Produtos e Peso Total. 
*/
GO
ALTER VIEW vw_6A AS
SELECT 
	BrandName AS 'Marca', 
	COUNT(*) AS 'Qtd. Produtos', 
	SUM(Weight) AS 'Peso Total' 
FROM 
	DimProduct
GROUP BY BrandName

GO
SELECT * FROM vw_6A
/*
c) Exclua a View vw_6a. 
*/
GO

DROP VIEW vw_6A