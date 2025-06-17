-- [SQL Server] Ordenando e filtrando dados
-- Aula 16 de 27: Where mais Is Null e Is Not Null - Filtrando valores nulos

-- 1. Selecione os clientes que são pessoa física.

SELECT * FROM DimCustomer
WHERE CompanyName IS NULL