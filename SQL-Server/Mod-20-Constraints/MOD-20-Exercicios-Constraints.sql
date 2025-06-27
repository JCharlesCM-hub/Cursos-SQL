/*
M�DULO 20: EXERC�CIOS - CONSTRAINTS
1. Voc� est� respons�vel por criar um Banco de Dados com algumas tabelas que v�o armazenar informa��es associadas ao aluguel de carros de uma locadora.
a) O primeiro passo � criar um banco de dados chamado AlugaFacil.
*/
CREATE DATABASE AlugaFacil

USE AlugaFacil
/*
b) O seu banco de dados deve conter 3 tabelas e a descri��o de cada uma delas � mostrada abaixo:
Obs: voc� identificar� as restri��es das tabelas a partir de suas descri��es.
Tabela 1: Cliente
- id_cliente
- nome_cliente
- cnh
- cartao
*/
CREATE TABLE Cliente(
	id_cliente INT IDENTITY(1, 1), 
	nome_cliente VARCHAR(100) NOT NULL, 
	cnh VARCHAR(100) NOT NULL, 
	cartao VARCHAR(100) NOT NULL, 
	CONSTRAINT cliente_id_cliente_pk PRIMARY KEY(id_cliente),
	CONSTRAINT cliente_cnh_un UNIQUE(cnh) 
)

/*
A tabela Cliente possui 4 colunas.
A coluna id_cliente deve ser a chave prim�ria da tabela, al�m de ser autoincrementada de forma autom�tica.
As colunas nome_cliente, cnh e cartao n�o podem aceitar valores nulos, ou seja, para todo cliente estes campos devem necessariamente ser preenchidos.
Por fim, a coluna cnh n�o pode aceitar valores duplicados.
Tabela 2: Carro
- id_carro
- placa
- modelo
- tipo
A tabela Carro possui 3 colunas.
A coluna id_carro deve ser a chave prim�ria da tabela, al�m de ser autoincrementada de forma autom�tica.
As colunas modelo, tipo e placa n�o podem aceitar valores nulos.
Os tipos de carros cadastrados devem ser: Hatch, Sedan, SUV.
Por fim, a coluna placa n�o pode aceitar valores duplicados.
*/
CREATE TABLE Carro(
	id_carro INT IDENTITY(1, 1), 
	placa VARCHAR(100) NOT NULL, 
	modelo VARCHAR(100) NOT NULL, 
	tipo VARCHAR(100) NOT NULL, 
	CONSTRAINT carro_id_carro_pk PRIMARY KEY(id_carro),
	CONSTRAINT carro_placa_un UNIQUE(placa), 
	CONSTRAINT carro_tipo_ck CHECK(tipo IN('Hatch', 'SUV', 'Sedan'))
)
/*
Tabela 3: Locacoes
- id_locacao
- data_locacao
- data_devolucao
- id_carro
- id_cliente
A tabela Locacoes possui 5 colunas.
A coluna id_locacao deve ser a chave prim�ria da tabela, al�m de ser autoincrementada de forma autom�tica.
Nenhuma das demais colunas devem aceitar valores nulos.
As colunas id_carro e id_cliente s�o chaves estrangeiras que permitir�o a rela��o da tabela Locacoes com as tabelas Carro e Cliente.
*/
CREATE TABLE Locacoes(
	id_locacao INT IDENTITY(1, 1), 
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
2. Tente violar as constraints criadas para cada tabela. Este exerc�cio � livre.
Obs: Para fazer o exerc�cio de viola��o de constraints basta utilizar o comando INSERT INTO para adicionar valores nas tabelas que n�o respeitem as restri��es (constraints) estabelecidas na cria��o das tabelas.
Ao final, exclua o banco de dados criado.
*/
-- ok
INSERT INTO Carro(placa, modelo, tipo) 
	VALUES('ABC-123', 'Hyundai HB20', 'Sedan')

-- Restri��o de placa
INSERT INTO Carro(placa, modelo, tipo) 
	VALUES('ABC-123', 'Citroen Cactus', 'Sedan')

-- Restri��o de tipo
INSERT INTO Carro(placa, modelo, tipo) 
	VALUES('GHI-456', 'Monza', 'Esportivo')

SELECT * FROM Carro 

-- Erro ao tentar deletar BD em uso

