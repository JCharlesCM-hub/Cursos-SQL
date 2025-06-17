-- [SQL Server] Manipulando Strings e Datas no SQL
-- Aula 7 de 23: TRANSLATE e STUFF


-- TRANSLATE e STUFF: Outras funções de substituição

SELECT TRANSLATE('3*[2+1]/{8-4}', '[]{}', '()()')

SELECT TRANSLATE('ABCD-490123', 'ABCD', 'WXYZ')

SELECT STUFF('VBA Impressionador', 1, 3, 'Excel')
