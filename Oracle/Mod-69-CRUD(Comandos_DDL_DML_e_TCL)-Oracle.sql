/* CRUD (Comandos DDL, DML e TCL)
*
*

-- I. O que é CRUD e o que são os comandos DDL, DML e TCL.

CRUD é um nome dado para as operações realizadas dentro de um banco de dados. É a sigla para:
CREATE, READ, UPDATE e DELETE.

De forma mais geral, podemos dividir os comandos dentro de um banco de dados em alguns grupos:

- DDL: Data Definition Language
São comandos para manipulação de objetos em um banco de dados.

Exemplos: CREATE, ALTER, TRUNCATE, DROP, COMMENT

- DML: Data Manipulation Language
São comandos para manipulação de dados em um banco de dados.

Exemplos: INSERT, UPDATE, DELETE

- TCL: Transact Control Language
Comandos para controle de transações em um banco de dados.

Exemplos: COMMIT, ROLLBACK e SAVEPOINT

*/

/* SHOW autocommit;
SET autocommit OFF; */


-- II. Tipos de Dados

-- Os dados armazenados dentro de um banco de dados poderão ser de uma série de tipos.
-- Abaixo, listamos os mais comuns.

-- 1. INT
-- 2. NUMBER(p, s)
-- 3. VARCHAR2(n)
-- 4. DATE
-- 5. TIMESTAMP


-- III. DDL CREATE
-- Vamos criar 3 tabelas de exemplos.

-- Tabela 1: CLIENTES

-- A tabela CLIENTES deve conter as seguintes colunas:

-- Coluna 1: id_cliente do tipo INT
-- Coluna 2: nome_cliente do tipo VARCHAR2
-- Coluna 3: sexo do tipo VARCHAR2
-- Coluna 4: email do tipo VARCHAR2
-- Coluna 5: data_nascimento do tipo DATE

CREATE TABLE clientes(
	id_cliente INT,
	nome_cliente VARCHAR2(100),
    sexo VARCHAR2(100),
	email VARCHAR2(100),
    data_nascimento DATE,
    cpf VARCHAR2(100)
);

-- Tabela 2: PRODUTOS

-- A tabela PRODUTOS deve conter as seguintes colunas:

-- Coluna 1: id_produto do tipo INT
-- Coluna 2: nome_produto do tipo VARCHAR2
-- Coluna 3: marca do tipo VARCHAR2
-- Coluna 4: categoria do tipo VARCHAR2
-- Coluna 5: preco_unit do tipo DECIMAL
-- Coluna 6: custo_unit do tipo DECIMAL

CREATE TABLE produtos(
	id_produto INT,
	nome_produto VARCHAR2(100),
	marca VARCHAR2(100),
    categoria VARCHAR2(100),
	preco_unit DECIMAL(10, 2),
    custo_unit NUMBER(10, 2)
);

-- Tabela 3: VENDAS

-- A tabela VENDAS deve conter as seguintes colunas:

-- Coluna 1: id_venda do tipo INT
-- Coluna 2: data_venda do tipo DATE
-- Coluna 3: id_cliente do tipo INT
-- Coluna 4: id_produto do tipo INT
-- Coluna 5: quantidade do tipo DECIMAL

CREATE TABLE vendas(
	id_venda INT,
	data_venda DATE,
	id_cliente INT,
    id_produto INT,
	quantidade NUMBER(10, 2)
);

-- DML SELECT
-- Criadas as tabelas, podemos usar o comando SELECT para selecioná-las.

SELECT * FROM clientes;
SELECT * FROM produtos;
SELECT * FROM vendas;

-- IV. DML INSERT INTO
-- Para preencher os dados nas tabelas, usamos o INSERT INTO.

-- Preenche a tabela CLIENTES

INSERT INTO clientes(id_cliente, nome_cliente, sexo, email, data_nascimento, cpf) VALUES
    (1,  'André Martins',   'M', 'andre.m@gmail.com', '12/02/1989', '839.283.190-00');
INSERT INTO clientes(id_cliente, nome_cliente, sexo, email, data_nascimento, cpf) VALUES
    (2,  'Bárbara Campos',  'F', 'barb_campos@hotmail.com', '07/05/1992', '351.391.410-02');
INSERT INTO clientes(id_cliente, nome_cliente, sexo, email, data_nascimento, cpf) VALUES
    (3,  'Carol Freitas',   'F', 'carol@gmail.com', '23/04/1985', '139.274.921-12');
INSERT INTO clientes(id_cliente, nome_cliente, sexo, email, data_nascimento, cpf) VALUES
	(4,  'Diego Cardoso', 'M', 'dcardoso@gmail.com', '11/10/1994', '192.371.081-17');
INSERT INTO clientes(id_cliente, nome_cliente, sexo, email, data_nascimento, cpf) VALUES
	(5,  'Eduardo Pereira', 'M', 'edupe@yahoo.com.br', '09/11/1988', '193.174.192-82');
INSERT INTO clientes(id_cliente, nome_cliente, sexo, email, data_nascimento, cpf) VALUES
	(6,  'Fabiana Silva', 'F', 'fabiisilva@gmail.com', '02/09/1989', '231.298.471-98');
INSERT INTO clientes(id_cliente, nome_cliente, sexo, email, data_nascimento, cpf) VALUES
	(7,  'Gustavo Barbosa', 'M', 'guto.barbosa@hotmail.com', '27/06/1993', '240.174.171-76');
INSERT INTO clientes(id_cliente, nome_cliente, sexo, email, data_nascimento, cpf) VALUES
	(8,  'Helen Viana', 'F', 'helenvianaa@gmail.com', '11/02/1990', '193.129.183-01');
INSERT INTO clientes(id_cliente, nome_cliente, sexo, email, data_nascimento, cpf) VALUES
	(9,  'Irene Castro', 'F', 'castroirene@yahoo.com.br', '21/08/1989', '184.148.102-29');
INSERT INTO clientes(id_cliente, nome_cliente, sexo, email, data_nascimento, cpf) VALUES
	(10, 'Juliana Pires', 'F', 'jupires@gmail.com', '13/01/1991', '416.209.192-47');

-- Preenche a tabela PRODUTOS

INSERT INTO produtos(id_produto, nome_produto, marca, categoria, preco_unit, custo_unit) VALUES
	(1,  'iPhone 11',   'Apple', 'Celular', 3500, 2200);
INSERT INTO produtos(id_produto, nome_produto, marca, categoria, preco_unit, custo_unit) VALUES
    (2,  'iPhone 12',   'Apple', 'Celular', 4100, 3000);
INSERT INTO produtos(id_produto, nome_produto, marca, categoria, preco_unit, custo_unit) VALUES
    (3,  'Moto G60',   'Motorola', 'Celular', 1600, 800);
INSERT INTO produtos(id_produto, nome_produto, marca, categoria, preco_unit, custo_unit) VALUES
    (4,  'Samsung S22',   'Samsung', 'Celular', 5000, 2800);
INSERT INTO produtos(id_produto, nome_produto, marca, categoria, preco_unit, custo_unit) VALUES
    (5,  'Aspire 5',   'Acer', 'Notebook', 3300, 1800);
INSERT INTO produtos(id_produto, nome_produto, marca, categoria, preco_unit, custo_unit) VALUES
    (6,  'Inspiron 15 3000',   'Dell', 'Notebook', 2800, 1100);
INSERT INTO produtos(id_produto, nome_produto, marca, categoria, preco_unit, custo_unit) VALUES
    (7,  'Smart TV 4K',   'LG', 'Televisão', 1800, 700);
INSERT INTO produtos(id_produto, nome_produto, marca, categoria, preco_unit, custo_unit) VALUES
    (8,  'Smart TV Crystal UHD 4K', 'Samsung', 'Televisão', 3000, 1200);

-- Preenche a tabela VENDAS

INSERT INTO vendas(id_venda, data_venda, id_cliente, id_produto, quantidade) VALUES
	(1,  '09/01/2022',   5, 1, 2);
INSERT INTO vendas(id_venda, data_venda, id_cliente, id_produto, quantidade) VALUES
    (2,  '10/01/2022',   2, 3, 1);
INSERT INTO vendas(id_venda, data_venda, id_cliente, id_produto, quantidade) VALUES
    (3,  '13/01/2022',   1, 7, 1);
INSERT INTO vendas(id_venda, data_venda, id_cliente, id_produto, quantidade) VALUES
    (4,  '02/02/2022',   7, 1, 1);
INSERT INTO vendas(id_venda, data_venda, id_cliente, id_produto, quantidade) VALUES
    (5,  '17/02/2022',   4, 1, 3);
INSERT INTO vendas(id_venda, data_venda, id_cliente, id_produto, quantidade) VALUES
    (6,  '21/02/2022',   6, 5, 3);
INSERT INTO vendas(id_venda, data_venda, id_cliente, id_produto, quantidade) VALUES
    (7,  '05/03/2022',   7, 5, 1);
INSERT INTO vendas(id_venda, data_venda, id_cliente, id_produto, quantidade) VALUES
    (8,  '07/03/2022',   10, 2, 1);
INSERT INTO vendas(id_venda, data_venda, id_cliente, id_produto, quantidade) VALUES
    (9,  '09/03/2022',   9, 1, 1);
INSERT INTO vendas(id_venda, data_venda, id_cliente, id_produto, quantidade) VALUES
    (10,  '12/03/2022',   4, 3, 3);
    

-- V. DML UPDATE
-- Atualize o preço unitário do produto de ID = 1 para R$3900.

SELECT * FROM produtos;

UPDATE produtos
SET preco_unit = 4500
WHERE id_produto = 1;



-- VI. DML DELETE
-- Exclua da tabela CLIENTES o cliente de ID = 10.

SELECT * FROM produtos;

DELETE FROM clientes
WHERE id_cliente = 1;



-- VII. DDL TRUNCATE
-- Exclua todas as linhas da tabela VENDAS, mas mantenha a tabela no banco de dados.


TRUNCATE TABLE vendas;



-- VIII. DDL DROP
-- Exclua a tabela VENDAS do banco de dados.

DROP TABLE vendas;


-- IX. DDL COMMENT
-- Crie comentários para tabelas e colunas do banco de dados.


-- 1) Na tabela produtos, crie o seguinte comentário: 'Informações de Produtos'.

DESC produtos;

COMMENT ON TABLE produtos
IS 'Informação de Produtos';

SELECT * FROM USER_TAB_COMMENTS;

-- Exclui um comentário na tabela
COMMENT ON TABLE produtos
IS '';


-- 2) Crie um comentário na coluna MARCA da tabela PRODUTOS: 'Descreve a categoria do produto'.

COMMENT ON COLUMN produtos.categoria
IS 'Descreve a categoria do produto';

SELECT * FROM USER_COL_COMMENTS
WHERE table_name = 'PRODUTOS';

-- X. Comandos TCL
-- Utilize os comandos COMMIT, ROLLBACK e SAVEPOINT para controlar as transações.


SELECT * FROM clientes;

COMMIT;
-- TCL COMMIT e ROLLBACK

ROLLBACK;



-- SAVEPOINT

SELECT * FROM clientes;

INSERT INTO CLIENTES(ID_CLIENTE, NOME_CLIENTE, SEXO, EMAIL, DATA_NASCIMENTO) VALUES
    (2,  'Bárbara Campos',  'F', 'barb_campos@hotmail.com', '07/05/1992');
    
SAVEPOINT P1;

INSERT INTO CLIENTES(ID_CLIENTE, NOME_CLIENTE, SEXO, EMAIL, DATA_NASCIMENTO) VALUES
    (3,  'Carol Freitas',   'F', 'carol@gmail.com', '23/04/1985');

SAVEPOINT P2;

INSERT INTO CLIENTES(ID_CLIENTE, NOME_CLIENTE, SEXO, EMAIL, DATA_NASCIMENTO) VALUES
	(4,  'Diego Cardoso', 'M', 'dcardoso@gmail.com', '11/10/1994');
    
SAVEPOINT P3;

ROLLBACK TO SAVEPOINT P1;


-- XI. ALTER TABLE

-- 1. Como adicionar uma coluna
-- 2. Como modificar uma coluna
-- 3. Como excluir uma coluna
-- 4. Como renomear uma coluna
-- 5. Como renomear uma tabela


SELECT * FROM clientes;

-- 1. Como adicionar uma coluna

-- Adicionar uma coluna de telefone na tabela CLIENTES
ALTER TABLE clientes
    ADD telefone VARCHAR2(100);

UPDATE clientes
SET telefone = '(22)99425-8319'
WHERE id_cliente = 2;

-- Adicionar uma coluna de estoque na tabela PRODUTOS
ALTER TABLE produtos
    ADD estoque INT;
    
UPDATE produtos
SET estoque = 100;


-- Adicionar mais de uma coluna
ALTER TABLE clientes
    ADD (endereco VARCHAR2(100),
            salario DECIMAL(10, 2),
            qtd_filhos INT);


-- 2. Como modificar uma coluna

-- Modificar uma coluna
ALTER TABLE clientes
    MODIFY salario INT;


-- Modificar mais de uma coluna
ALTER TABLE clientes
    MODIFY 
        (endereco INT,
        salario INT,
        qtd_filhos DATE);



-- 3. Como excluir uma coluna


ALTER TABLE clientes
    DROP COLUMN endereco;


-- 4. Como renomear uma coluna

ALTER TABLE clientes
    RENAME COLUMN sexo TO genero;
