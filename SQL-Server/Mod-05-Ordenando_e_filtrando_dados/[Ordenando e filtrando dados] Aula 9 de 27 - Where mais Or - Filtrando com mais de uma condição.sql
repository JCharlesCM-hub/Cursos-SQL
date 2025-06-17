-- [SQL Server] Ordenando e filtrando dados
-- Aula 9 de 27: Where mais Or - Filtrando com mais de uma condição

-- Podemos filtrar os dados nas nossas tabelas utilizando o comando WHERE

-- Quais produtos são da marca 'Contoso' OU são da cor 'White'?

SELECT * FROM DimProduct
WHERE BrandName = 'Contoso' OR ColorName = 'White'