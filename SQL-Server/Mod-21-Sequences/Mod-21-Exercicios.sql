/*
MÓDULO 21 – EXERCÍCIOS SEQUENCES

0. Crie o Banco de Dados AlugaFacil, onde serão criadas as sequences e tabelas dos exercícios.
*/
USE Exercicios
-- Apagar BD
DROP DATABASE AlugaFacil
-- Criar BD
CREATE DATABASE AlugaFacil
-- F5 e Usar BD
USE AlugaFacil

-- Criar Cliente Sequences
CREATE SEQUENCE clientes_seq
AS INT
START WITH 1
INCREMENT BY 1
NO MAXVALUE 

-- Criar Carro Sequences
CREATE SEQUENCE carro_seq
AS INT
START WITH 1
INCREMENT BY 1
NO MAXVALUE 

-- Criar Locações Sequences
CREATE SEQUENCE locacoes_seq
AS INT
START WITH 1
INCREMENT BY 1
NO MAXVALUE 

DROP TABLE Locacoes
DROP TABLE Cliente
DROP TABLE Carro

-- Criar a Tabela Cliente Sem a IDENTITY(1, 1) no ID
CREATE TABLE Cliente(
	id_cliente INT, 
	nome_cliente VARCHAR(100) NOT NULL, 
	cnh VARCHAR(100) NOT NULL, 
	cartao VARCHAR(100) NOT NULL, 
	CONSTRAINT cliente_id_cliente_pk PRIMARY KEY(id_cliente),
	CONSTRAINT cliente_cnh_un UNIQUE(cnh) 
)

SELECT * FROM Cliente

-- Criar a Tabela Carro
CREATE TABLE Carro(
	id_carro INT, 
	placa VARCHAR(100) NOT NULL, 
	modelo VARCHAR(100) NOT NULL, 
	tipo VARCHAR(100) NOT NULL, 
	CONSTRAINT carro_id_carro_pk PRIMARY KEY(id_carro),
	CONSTRAINT carro_placa_un UNIQUE(placa), 
	CONSTRAINT carro_tipo_ck CHECK(tipo IN('Hatch', 'SUV', 'Sedan'))
)

SELECT * FROM Carro

-- Criar a Tabela Locações
CREATE TABLE Locacoes(
	id_locacao INT, 
	data_locacao DATE NOT NULL, 
	data_devolucao DATE NOT NULL, 
	id_carro INT NOT NULL, 
	id_cliente INT NOT NULL, 
	CONSTRAINT locacoes_id_locacoes_pk PRIMARY KEY(id_locacao),
	CONSTRAINT locacoes_id_carro_pk FOREIGN KEY(id_carro) 
		REFERENCES Carro(id_carro), 
	CONSTRAINT locacoes_id_cliente_fk FOREIGN KEY(id_cliente)  
		REFERENCES Cliente(id_cliente) 
)

SELECT * FROM Locacoes
SELECT * FROM Carro
SELECT * FROM Cliente

/*
1. Vamos criar Sequences que serão utilizadas nas tabelas: Carro, Cliente e Locacoes.
Essas sequences serão chamadas de: cliente_seq, carro_seq e locaçoes_seq.
Todas essas sequences devem começar pelo número 1, incrementar de 1 em 1 e não terem valor máximo.
*/

/*

2. Utilize as sequences nas 3 tabelas: Carro, Cliente e Locacoes. Você deve excluir as tabelas existentes e recriá-las. Lembre-se que não é necessário utilizar a constraint IDENTITY nas colunas de chave primária uma vez que nelas serão usadas as Sequences.
Tabela 1: Cliente
- id_cliente
- nome_cliente
- cnh
- cartao
A tabela Cliente possui 4 colunas.
A coluna id_cliente deve ser a chave primária da tabela.
As colunas nome_cliente, cnh e cartao não podem aceitar valores nulos, ou seja, para todo cliente estes campos devem necessariamente ser preenchidos.
Por fim, a coluna cnh não pode aceitar valores duplicados.
*/
INSERT INTO Cliente(id_cliente, nome_cliente, cnh, cartao) VALUES
	(NEXT VALUE FOR clientes_seq, 'Ana', '111111', '1111-1111-1111-1111'), 
	(NEXT VALUE FOR clientes_seq, 'Jose', '222222', '22222-22222'), 
	(NEXT VALUE FOR clientes_seq, 'Bruno', '333333', '3333333-33333333'), 
	(NEXT VALUE FOR clientes_seq, 'Charles', '4444444', '444444-4444444') 

SELECT * FROM Cliente
/*
Tabela 2: Carro
- id_carro
- placa
- modelo
- tipo
A tabela Carro possui 3 colunas.
A coluna id_carro deve ser a chave primária da tabela.
As colunas modelo, tipo e placa não podem aceitar valores nulos.
Os tipos de carros cadastrados devem ser: Hatch, Sedan, SUV.
Por fim, a coluna placa não pode aceitar valores duplicados.
*/
INSERT INTO Carro(id_carro, placa, modelo, tipo) VALUES
	(NEXT VALUE FOR carro_seq, 'ABC-123', 'Hyundai HB20', 'Sedan'), 
	(NEXT VALUE FOR carro_seq, 'DEF-123', 'FORD KA', 'SUV')

SELECT * FROM Carro

/*
Tabela 3: Locacoes
- id_locacao
- data_locacao
- data_devolucao
- id_carro
- id_cliente
A tabela Locacoes possui 5 colunas.
A coluna id_locacao deve ser a chave primária da tabela.
Nenhuma das demais colunas devem aceitar valores nulos.
As colunas id_carro e id_cliente são chaves estrangeiras que permitirão a relação da tabela Locacoes com as tabelas Carro e Cliente.
*/
INSERT INTO Locacoes(id_locacao, data_locacao, data_devolucao, id_carro, id_cliente) VALUES
	(NEXT VALUE FOR locacoes_seq, '12/01/2025', '12/02/2025', 1, 3), 
	(NEXT VALUE FOR locacoes_seq, '14/01/2025', '12/03/2025', 2, 4)

SELECT * FROM Locacoes
SELECT * FROM Carro
SELECT * FROM Cliente

/*
3. Exclua as sequences criadas.
*/
DROP SEQUENCE locacoes_seq
DROP SEQUENCE carro_seq
DROP SEQUENCE clientes_seq

SELECT * FROM Locacoes
SELECT * FROM Carro
SELECT * FROM Cliente

