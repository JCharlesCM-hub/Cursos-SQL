-- [SQL Server] Funções Condicionais
-- Aula 5 de 18: CASE WHEN WHEN... ELSE (Exemplo)
-- Exemplo: Crie uma coluna para substituir o 'M' por 'Masculino' e 'F' por 'Feminino'. Verifique se será necessário fazer alguma correção.

SELECT * FROM DimCustomer

SELECT
	CustomerKey,
	FirstName,
	Gender,
	CASE
		WHEN Gender = 'M' THEN 'Masculino'
		WHEN Gender = 'F' THEN 'Feminino'
		ELSE 'Empresa'
	END AS 'Sexo'
FROM
	DimCustomer

