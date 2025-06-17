-- [SQL Server] [Ordenando e filtrando dados] Aula 2 de 27: Order By (Parte 1)

-- Selecionando as TOP 100 linhas da tabela DimStore, ordenando pela coluna EmployeeCount de forma decrescente

SELECT TOP(100) * FROM DimStore
ORDER BY EmployeeCount DESC