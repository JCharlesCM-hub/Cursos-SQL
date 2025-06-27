/* 
MOD-20-Constraints

Objetivo: Entender o que s�o constraints e como trabalhar com elas na pr�tica.
*/

-- I. CONSTRAINTS
-- Constraints no SQL s�o regras (restri��es) que podemos definir para uma coluna de uma tabela.
-- Abaixo temos uma lista de restri��es:

-- 1. NOT NULL
-- 2. UNIQUE
-- 3. CHECK
-- 4. DEFAULT
-- 5. IDENTITY
-- 6. PRIMARY KEY
-- 7. FOREIGN KEY

-- 1. NOT NULL
-- Essa constraint n�o permite que sejam adicionados valores nulos na coluna.

-- 2. UNIQUE
-- Identifica uma coluna de forma �nica, sem permitir valores duplicados (mas, permite NULL).

-- 3. CHECK
-- Verifica se o valor adicionado na coluna atende a uma determinada condi��o.

-- 4. DEFAULT
-- Retorna um valor default caso a coluna n�o seja preenchida.

-- 5. IDENTITY
-- Permite que uma coluna siga uma auto numera��o (usada em colunas de ID).

-- 6. PRIMARY KEY
-- Uma CHAVE PRIM�RIA (PRIMARY KEY) � uma coluna que identifica de forma �nica as linhas 
-- de uma tabela. Nenhum dos valores de uma coluna de chave prim�ria deve ser nulo ou se repetir.
-- Ser� atrav�s dessa coluna que criaremos rela��es entre as tabelas.

-- 7. FOREIGN KEY
-- Uma CHAVE ESTRANGEIRA (FOREIGN KEY) � uma coluna que ser� relacionada com a CHAVE PRIM�RIA
-- de uma outra tabela.

-- Deletar BD
DROP DATABASE Exercicios

-- Criar BD
CREATE DATABASE Exercicios

-- Usar BD
USE Exercicios

-- Apagar ou Deletar Tabelas, quando o BD existe de outros exercicios
DROP TABLE fContratos
DROP TABLE dCliente
DROP TABLE dGerente

-- Tabela 1: dCliente

-- A tabela dCliente deve conter as seguintes colunas:

-- Coluna 1: id_cliente do tipo INT          --> Chave Prim�ria e deve ser auto incrementada
-- Coluna 2: nome_cliente do tipo VARCHAR    --> N�o aceita valores nulos
-- Coluna 3: genero VARCHAR                  --> N�o aceita valores nulos e devem ser ('M', 'F', 'O', 'PND')
-- Coluna 4: data_nascimento DATE            --> N�o aceita valores nulos  
-- Coluna 5: cpf do tipo VARCHAR             --> N�o aceita valores duplicados nem valores nulos

-- Cria Tabela
CREATE TABLE dCliente(
	id_cliente INT IDENTITY(1, 1),
	nome_cliente VARCHAR(100) NOT NULL,
	genero VARCHAR(100) NOT NULL,
	data_de_nascimento DATE NOT NULL,
	cpf VARCHAR(100) NOT NULL,
	CONSTRAINT dcliente_id_cliente_pk PRIMARY KEY(id_cliente),
	CONSTRAINT dcliente_genero_ck CHECK(Genero IN ('M', 'F', 'O', 'PND')),
	CONSTRAINT dcliente_cpf_un UNIQUE(cpf)
)
-- Inserir dados na Tabela
INSERT INTO dCliente(Nome_Cliente, Genero, Data_de_Nascimento, CPF)
VALUES
	('Andr� Martins',  'M',  '12/02/1989', '839.283.190-00'),
	('B�rbara Campos',  'F', '07/05/1992', '351.391.410-02'),
	('Carol Freitas',  'F',  '23/04/1985', '139.274.921-12'),
	('Diego Cardoso',   'M', '11/10/1994', '192.371.081-17'),
	('Eduardo Pereira', 'M', '09/11/1988', '193.174.192-82'),
	('Fabiana Silva',  'F',  '02/09/1989', '231.298.471-98'),
	('Gustavo Barbosa', 'M', '27/06/1993', '240.174.171-76'),
	('Helen Viana',    'F',  '11/02/1990', '193.129.183-01'),
	('Igor Castro',    'M',  '21/08/1989', '184.148.102-29'),
	('Juliana Pires',   'F', '13/01/1991', '416.209.192-47')

SELECT * FROM dCliente

-- Tabela 2: dGerente

-- A tabela dGerente deve conter as seguintes colunas:

-- Coluna 1: id_gerente do tipo INT            --> Chave Prim�ria e auto incrementada
-- Coluna 2: nome_gerente do tipo VARCHAR      --> N�o aceita valores nulos
-- Coluna 3: data_contratacao VARCHAR          --> N�o aceita valores nulos
-- Coluna 4: salario do tipo FLOAT             --> N�o aceita valores nulos nem abaixo de zero

CREATE TABLE dGerente(
	id_gerente INT IDENTITY(1, 1),
	nome_gerente VARCHAR(100) NOT NULL,
	data_contratacao VARCHAR(100) NOT NULL,
	salario FLOAT NOT NULL,
	CONSTRAINT dgerente_id_gerente_pk PRIMARY KEY(id_gerente),
	CONSTRAINT dgerente_salario_ck CHECK(salario > 0)
)

INSERT INTO dGerente(Nome_Gerente, Data_Contratacao, Salario)
VALUES
	('Lucas Sampaio',   '21/03/2015', 6700),
	('Mariana Padilha', '10/01/2011', 9900),
	('Nath�lia Santos', '03/10/2018', 7200),
	('Ot�vio Costa',    '18/04/2017', 11000)

SELECT * FROM dGerente

-- Tabela 3: fContratos

-- A tabela fContratos deve conter as seguintes colunas:

-- Coluna 1: id_contrato do tipo INT           --> Chave Prim�ria e auto incremental
-- Coluna 2: data_assinatura do tipo DATE      --> Valor Padr�o (GETDATE) caso n�o seja preenchida
-- Coluna 3: id_cliente do tipo INT            --> Chave Estrangeira
-- Coluna 4: id_gerente do tipo INT            --> Chave Estrangeira
-- Coluna 5: valor_contrato do tipo FLOAT      --> N�o aceita valores nulos e deve ser maior que zero

CREATE TABLE fContratos(
	id_contrato INT IDENTITY(1, 1),
	data_assinatura DATE DEFAULT GETDATE(),
	id_cliente INT,
	id_gerente INT,
	valor_contrato FLOAT,
	CONSTRAINT fcontratos_id_contrato_pk PRIMARY KEY(id_contrato),
	CONSTRAINT fcontratos_id_cliente_fk FOREIGN KEY(id_cliente) REFERENCES dCliente(id_cliente),
	CONSTRAINT fcontratos_id_gerente_fk FOREIGN KEY(id_gerente) REFERENCES dGerente(id_gerente),
	CONSTRAINT fcontratos_valor_contrato_ck CHECK(valor_contrato > 0)
)

INSERT INTO fContratos(Data_Assinatura, ID_Cliente, ID_Gerente, Valor_Contrato)
VALUES
	('12/01/2019', 8, 1, 23000),
	('10/02/2019', 3, 2, 15500),
	('07/03/2019', 7, 2, 6500),
	('15/03/2019', 1, 3, 33000),
	('21/03/2019', 5, 4, 11100),
	('23/03/2019', 4, 2, 5500),
	('28/03/2019', 9, 3, 55000),
	('04/04/2019', 2, 1, 31000),
	('05/04/2019', 10, 4, 3400),
	('05/04/2019', 6, 2, 9200)

SELECT * FROM fContratos

-- Viola��o de constraints
SELECT * FROM dCliente;

-- Exemplo 1: Viola��o NOT NULL e CHECK(Genero: F ou M)
INSERT INTO dCliente(Nome_Cliente, Genero, Data_de_Nascimento, CPF) VALUES
	('Lucia Campos',  'F', '23/10/1994', '999.234.812-20');

-- Exemplo 2: Viola��o UNIQUE
SELECT * FROM dCliente

INSERT INTO dCliente(Nome_Cliente, Genero, Data_de_Nascimento, CPF) VALUES
	('Lucia Campos',  'F', '23/10/1994', '184.148.102-29');

-- Exemplo 3: Viola��o de FK e PK
SELECT * FROM dCliente
SELECT * FROM dGerente
SELECT * FROM fContratos

INSERT INTO fContratos(Data_Assinatura, ID_Cliente, ID_Gerente, Valor_Contrato) VALUES
    ('12/03/2022', 4, 10, 1500);

-- III. Gerenciando CONSTRAINTS

-- 1. Adicionar constraints
-- 2. Renomear constraints
-- 3. Remover constraints

-- Remova a constraint PK da tabela fContratos.
ALTER TABLE fContratos
DROP CONSTRAINT fcontratos_id_contrato_pk

-- Remova a constraint FK Cliente da tabela fContratos.
ALTER TABLE fContratos
DROP CONSTRAINT fcontratos_id_cliente_fk

-- Adicione a constraint PK id_venda na tabela fContratos.
ALTER TABLE fContratos
ADD CONSTRAINT fcontratos_id_contrato_pk PRIMARY KEY(id_contrato)

-- Adicione a constraint FK id_cliente na tabela VENDAS.
ALTER TABLE fContratos
ADD CONSTRAINT fcontratos_id_cliente_fk FOREIGN KEY(id_cliente) REFERENCES dCliente(id_cliente)

-- Alterar o nome de uma constraint criada.
-- Com o bot�o direito sobre o campo da tabela op��o 'Renomear' 
