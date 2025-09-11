-- Criar BD Zeustech
CREATE DATABASE zeustechtech;

use zeustechtech;

show tables;

UPDATE `zeustechtech`.`auth_user` SET `username` = 'adminAAA' WHERE (`id` = '18');

SELECT * FROM auth_user;
SELECT * FROM produtosapp_movimentacao;

SELECT * FROM produtosapp_movimentacao WHERE usuario_id = 26;
DELETE FROM auth_user WHERE id = 26;
DELETE FROM produtosapp_movimentacao WHERE usuario_id = 26; 

SELECT * FROM produtosapp_movimentacao;
SELECT * FROM produtosapp_movimentacao WHERE usuario_id = 26;
DELETE FROM auth_user WHERE id = 26;
DELETE FROM produtosapp_movimentacao WHERE usuario_id = 26; 