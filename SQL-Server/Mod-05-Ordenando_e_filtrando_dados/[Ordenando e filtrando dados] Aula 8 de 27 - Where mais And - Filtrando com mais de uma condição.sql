-- [SQL Server] Ordenando e filtrando dados
-- Aula 8 de 27: Where mais And - Filtrando com mais de uma condição

-- Podemos filtrar os dados nas nossas tabelas utilizando o comando WHERE

-- Quais produtos são da marca 'Fabrikam' E TAMBÉM são da cor 'Black'?

SELECT * FROM DimProduct
WHERE BrandName = 'Fabrikam' AND ColorName = 'Black'