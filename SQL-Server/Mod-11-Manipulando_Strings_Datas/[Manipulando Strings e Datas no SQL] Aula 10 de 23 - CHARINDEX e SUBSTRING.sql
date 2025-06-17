-- [SQL Server] Manipulando Strings e Datas no SQL
-- Aula 10, 11 e 12 de 23: CHARINDEX e SUBSTRING

-- CHARINDEX: Descobre a posição de um determinado caractere dentro de um texto
-- SUBSTRING: Extrai alguns caracteres de dentro de um texto

SELECT CHARINDEX('Moreno', 'Raquel Moreno') AS 'Posição Sobrenome'

SELECT SUBSTRING('Raquel Moreno', 8, 6) AS 'Sobrenome'


SELECT 'Marcus Cavalcanti' AS 'Nome'

SELECT CHARINDEX(' ', 'Marcus Cavalcanti') AS 'Posição'

SELECT SUBSTRING('Marcus Cavalcanti', CHARINDEX(' ', 'Marcus Cavalcanti') + 1, 100) AS 'Sobrenome'
