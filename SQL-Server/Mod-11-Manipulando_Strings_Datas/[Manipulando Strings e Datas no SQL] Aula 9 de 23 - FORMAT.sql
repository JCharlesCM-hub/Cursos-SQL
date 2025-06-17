-- [SQL Server] Manipulando Strings e Datas no SQL
-- Aula 9 de 23: FORMAT


--SELECT * FROM DimCustomer

-- Formatação de Data
SELECT 
	GETDATE() AS 'Data',
	FORMAT(GETDATE(),'dd/MMMM/yyyy','pt-br') AS 'Data Formatada'

-- Formatação de Número
SELECT 
	50123 AS 'Número',
	FORMAT(5123, '000000.00') AS 'Número Formatado'

-- Formatação de Moeda
SELECT 
	3670.5 AS 'Moeda',
	FORMAT(5670.5, 'R$####.00') AS 'Moeda Formatada'


-- Formatar as colunas de Data de Nascimento e Renda Anual da tabela DimCustomer, de acordo com as formatações aprendidas.

SELECT
	FirstName AS 'Nome',
	BirthDate AS 'Data de Nascimento',
	FORMAT(BirthDate, 'dd/MMMM/yyyy', 'pt-BR') AS 'Data Formatada',
	YearlyIncome AS 'Renda Anual',
	FORMAT(YearlyIncome, 'R$##,###.00') AS 'Renda Anual Formatada'
FROM
	DimCustomer
