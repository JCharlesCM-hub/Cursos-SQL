-- [SQL Server] Ordenando e filtrando dados
-- Aula 5 de 27: Where (Pt. 3) - Filtrando colunas de data

-- Podemos filtrar os dados nas nossas tabelas utilizando o comando WHERE

-- Quais clientes nasceram após o dia 31/12/1970?

SELECT * FROM DimCustomer
WHERE BirthDate >= '1970-12-31'
ORDER BY BirthDate DESC
