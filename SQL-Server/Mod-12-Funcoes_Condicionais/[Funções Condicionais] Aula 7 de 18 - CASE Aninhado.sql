-- [SQL Server] Funções Condicionais
-- Aula 7 de 18: CASE Aninhado


-- DimEmployee
SELECT * FROM DimEmployee

-- 4 Cargos (Title):
-- Sales Group Manager
-- Sales Region Manager
-- Sales State Manager
-- Sales Store Manager

-- Assalariado (SalariedFlag)?
-- SalariedFlag = 0: não é assalariado
-- SalariedFlag = 1: é assalariado

-- Situação: Cálculo do bônus
-- Sales Group Manager: Se for assalariado, 20%; Se não, 15%.
-- Sales Region Manager: 15%
-- Sales State Manager: 7%
-- Sales Store Manager: 2%


SELECT
	FirstName,
	Title,
	SalariedFlag,
	CASE
		WHEN Title = 'Sales Group Manager' THEN
		CASE	
			WHEN SalariedFlag = 1 THEN 0.3
			ELSE 0.2
		END
		WHEN Title = 'Sales Region Manager' THEN 0.15
		WHEN Title = 'Sales State Manager' THEN 0.07
		ELSE 0.02
	END AS 'Bônus'
FROM
	DimEmployee

