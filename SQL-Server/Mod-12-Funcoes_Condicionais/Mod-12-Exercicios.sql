/*
MÓDULO 11: EXERCÍCIOS 
 
1. O  setor de vendas decidiu  aplicar um desconto aos produtos de  acordo com a sua classe. O 
percentual aplicado deverá ser de: 
 
Economy -> 5% 
Regular -> 7% 
Deluxe -> 9% 
 
a)  Faça  uma  consulta  à  tabela  DimProduct  que  retorne  as  seguintes  colunas:  ProductKey, 
ProductName, e outras duas colunas que deverão retornar o % de Desconto e UnitPrice com 
desconto.   
b) Faça uma adaptação no código para que os % de desconto de 5%, 7% e 9% sejam facilmente 
modificados (dica: utilize variáveis). 
*/
SELECT TOP(10) * FROM DimProduct

DECLARE @varDescEco FLOAT, @varDescReg FLOAT, @varDescDe FLOAT
SET @varDescEco = 0.10
SET @varDescReg = 0.07
SET @varDescDe = 0.09
SELECT 
	ProductKey AS 'ID Produto', 
	ProductName AS 'Nome Produto',
	ClassName AS 'Classe',  
	CASE
		WHEN ClassName = 'Economy' THEN (1 - @varDescEco) * UnitPrice 
		WHEN ClassName = 'Regular' THEN (1 - @varDescReg) * UnitPrice 
		ELSE (1 - @varDescDe) * UnitPrice 
	END AS ' % Desconto' 
FROM 
	DimProduct

/* 
2.  Você  ficou  responsável  pelo  controle  de  produtos  da  empresa  e  deverá  fazer  uma  análise  da 
quantidade de produtos por Marca. 
 
A divisão das marcas em categorias deverá ser a seguinte: 
 
CATEGORIA A: Mais de 500 produtos  
CATEGORIA B: Entre 100 e 500 produtos  
CATEGORIA C: Menos de 100 produtos  
Faça uma consulta à tabela DimProduct e  retorne  uma tabela com um agrupamento de Total de 
Produtos por Marca, além da coluna de Categoria, conforme a regra acima.
*/
SELECT TOP(10) * FROM DimProduct

SELECT 
	BrandName AS 'Marca', 
	COUNT(*) AS 'Qtd. Pruduto', 
	CASE
		WHEN COUNT(*) >= 500 THEN 'CATEGORIA A'
		WHEN COUNT(*) >= 100 THEN 'CATEGORIA B'
		ELSE 'CATEGORIA C' 
	END AS ' Categoria' 
FROM 
	DimProduct 
GROUP BY BrandName 

/* 
3. Será necessário criar uma categorização de cada loja da empresa considerando a quantidade de 
funcionários de cada uma. A lógica a ser seguida será a lógica abaixo: 
 
EmployeeCount >= 50; 'Acima de 50 funcionários' 
EmployeeCount >= 40; 'Entre 40 e 50 funcionários' 
EmployeeCount >= 30; 'Entre 30 e 40 funcionários' 
EmployeeCount >= 20; 'Entre 20 e 30 funcionários' 
EmployeeCount >= 40; 'Entre 10 e 20 funcionários' 
Caso contrário: 'Abaixo de 10 funcionários' 
 
Faça uma consulta à tabela DimStore que retorne as seguintes informações: StoreName, 
EmployeeCount e a coluna de categoria, seguindo a regra acima. 
 
*/
SELECT TOP(10) * FROM DimStore

SELECT 
	StoreName AS 'Nome da Loja',
	EmployeeCount AS 'Qtd. Funcionários', 
	CASE
		WHEN EmployeeCount >= 50 THEN 'Acima de 50 Funcionários' 
		WHEN EmployeeCount >= 40 THEN 'Acima de 40 Funcionários' 
		WHEN EmployeeCount >= 30 THEN 'Acima de 30 Funcionários' 
		WHEN EmployeeCount >= 20 THEN 'Acima de 20 Funcionários' 
		WHEN EmployeeCount >= 10 THEN 'Acima de 10 Funcionários' 
		ELSE 'Abaixo de 10 Funcionários' 
	END AS 'Categoria'
FROM 
	DimStore
	
/*   
4. O setor de logística deverá realizar um transporte de carga dos produtos que estão no depósito 
de Seattle para o depósito de Sunnyside.  
Não  se  tem  muitas  informações  sobre  os  produtos  que  estão  no  depósito,  apenas  se  sabe  que 
existem  100  exemplares  de  cada  Subcategoria.  Ou  seja,  100  laptops,  100  câmeras  digitais,  100 
ventiladores, e assim vai. 
O gerente de logística definiu que os produtos serão transportados por duas rotas distintas. Além 
disso, a divisão dos produtos em cada uma das rotas será feita de acordo com as subcategorias (ou 
seja, todos os produtos de uma mesma subcategoria serão transportados pela mesma rota): 
Rota 1: As subcategorias que tiverem uma soma total menor que 1000 kg deverão ser 
transportados pela Rota 1. 
Rota  2:  As  subcategorias  que  tiverem  uma  soma  total  maior  ou  igual  a  1000  kg  deverão  ser 
transportados pela Rota 2. 
Você deverá realizar uma consulta à tabela DimProduct e fazer essa divisão das subcategorias por 
cada rota. Algumas dicas: 
- Dica 1: A sua consulta deverá ter um total de 3 colunas: Nome da Subcategoria, Peso Total e Rota. 
-  Dica  2:  Como  não  se  sabe  quais  produtos  existem  no  depósito,  apenas  que  existem  100 
exemplares  de  cada  subcategoria,  você  deverá  descobrir  o  peso  médio  de  cada  subcategoria  e 
multiplicar essa média por 100, de forma que você descubra aproximadamente qual é o peso total 
dos produtos por subcategoria. 
- Dica 3: Sua resposta final deverá ter um JOIN e um GROUP BY.
*/
SELECT TOP(10) * FROM DimProduct

SELECT 
	ProductSubcategoryName AS 'Nome SubCategoria',
	ROUND(AVG(Weight) * 100, 2) AS 'Peso Total', 
	CASE
		WHEN ROUND(AVG(Weight) * 100,2) >= 1000 THEN 'Rota 2' 
		ELSE 'Rota 1' 
	END AS 'Rota'
FROM 
	DimProduct
INNER JOIN DimProductSubcategory 
	ON DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey 
GROUP BY ProductSubcategoryName

