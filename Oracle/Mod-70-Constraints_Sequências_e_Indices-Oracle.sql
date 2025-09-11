/* Constraints, Sequências e Índices
*
*

Objetivo: Trabalhar com constraints e entender o que são sequências e índices.
*/

-- I. CONSTRAINTS
-- Constraints no SQL são regras (restrições) que podemos definir para uma coluna de uma tabela.
-- Abaixo temos uma lista de restrições:

-- 1. NOT NULL
-- 2. UNIQUE
-- 3. CHECK
-- 4. PRIMARY KEY
-- 5. FOREIGN KEY



-- 1. NOT NULL
-- Essa constraint não permite que sejam adicionados valores nulos na coluna.


-- 2. UNIQUE
-- Identifica uma coluna de forma única, sem permitir valores duplicados (mas, permite NULL).

-- 3. CHECK
-- Verifica se o valor adicionado na coluna atende a uma determinada condição.

-- 4. DEFAULT
-- Retorna um valor default caso a coluna não seja preenchida.

-- 5. PRIMARY KEY
-- Uma CHAVE PRIMÁRIA (PRIMARY KEY) é uma coluna que identifica de forma única as linhas 
-- de uma tabela. Nenhum dos valores de uma coluna de chave primária deve ser nulo ou se repetir.
-- Será através dessa coluna que criaremos relações entre as tabelas.

-- 6. FOREIGN KEY
-- Uma CHAVE ESTRANGEIRA (FOREIGN KEY) é uma coluna que será relacionada com a CHAVE PRIMÁRIA
-- de uma outra tabela.

DROP TABLE clientes;
DROP TABLE produtos;
DROP TABLE vendas;



-- Tabela 1: CLIENTES

-- A tabela CLIENTES deve conter as seguintes colunas:

-- Coluna 1: id_cliente do tipo INT          --> Chave Primária
-- Coluna 2: nome_cliente do tipo VARCHAR2   --> Não aceita valores nulos
-- Coluna 3: sexo do tipo VARCHAR2           --> Não aceita valores nulos  
-- Coluna 4: email do tipo VARCHAR2          --> Não aceita valores nulos
-- Coluna 5: cpf do tipo VARCHAR2            --> Não aceita valores duplicados
-- Coluna 6: data_nascimento do tipo DATE    --> Não tem restrição

CREATE TABLE clientes(
	id_cliente INT,
	nome_cliente VARCHAR2(100) NOT NULL,
    sexo VARCHAR2(100) NOT NULL,
	email VARCHAR2(100) NOT NULL,
    data_nascimento DATE,
    cpf VARCHAR2(100) NOT NULL,
    CONSTRAINT clientes_id_cliente_pk PRIMARY KEY(id_cliente),
    CONSTRAINT clientes_cpf_un UNIQUE(cpf)
);

-- Tabela 2: PRODUTOS

-- A tabela PRODUTOS deve conter as seguintes colunas:

-- Coluna 1: id_produto do tipo INT            --> Chave Primária
-- Coluna 2: nome_produto do tipo VARCHAR2     --> Não aceita valores nulos
-- Coluna 3: marca do tipo VARCHAR2            --> Não aceita valores nulos
-- Coluna 4: categoria do tipo VARCHAR2        --> Não aceita valores nulos
-- Coluna 5: preco_unit do tipo NUMBER         --> Não aceita valores nulos nem abaixo de zero
-- Coluna 6: custo_unit do tipo NUMBER         --> Não aceita valores nulos nem abaixo de zero
-- Coluna 7: estoque do tipo INT               --> Não aceita valores nulos nem abaixo de zero

CREATE TABLE produtos(
	id_produto INT,
	nome_produto VARCHAR2(100) NOT NULL,
	marca VARCHAR2(100) NOT NULL,
    categoria VARCHAR2(100) NOT NULL,
	preco_unit NUMBER(10, 2) NOT NULL,
    custo_unit NUMBER(10, 2) NOT NULL,
    estoque INT NOT NULL,
    CONSTRAINT produtos_id_produto_pk PRIMARY KEY(id_produto),
    CONSTRAINT produtos_preco_ck CHECK(preco_unit > 0),
    CONSTRAINT produtos_custo_ck CHECK(custo_unit > 0),
    CONSTRAINT produtos_estoque_ck CHECK(estoque > 0)
);

-- Tabela 3: VENDAS

-- A tabela VENDAS deve conter as seguintes colunas:

-- Coluna 1: id_venda do tipo INT           --> Chave Primária
-- Coluna 2: data_venda do tipo DATE        --> Valor Padrão (sysdate) caso não seja preenchida
-- Coluna 3: id_cliente do tipo INT         --> Chave Estrangeira
-- Coluna 4: id_produto do tipo INT         --> Chave Estrangeira
-- Coluna 5: quantidade do tipo NUMBER      --> Não aceita valores nulos

CREATE TABLE vendas(
	id_venda INT,
	data_venda DATE DEFAULT SYSDATE,
	id_cliente INT,
    id_produto INT,
	quantidade NUMBER(10, 2) NOT NULL,
    CONSTRAINT vendas_id_venda_pk PRIMARY KEY(id_venda),
    CONSTRAINT vendas_id_cliente_fk FOREIGN KEY(id_cliente) REFERENCES clientes(id_cliente),
    CONSTRAINT vendas_id_produto_fk FOREIGN KEY(id_produto) REFERENCES produtos(id_produto)
);

-- DML SELECT
-- Criadas as tabelas, podemos usar o comando SELECT para selecioná-las.

SELECT * FROM clientes;
SELECT * FROM produtos;
SELECT * FROM vendas;

-- DML INSERT INTO
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

INSERT INTO produtos(id_produto, nome_produto, marca, categoria, preco_unit, custo_unit, estoque) VALUES
	(1,  'iPhone 11',   'Apple', 'Celular', 3500, 2200, 100);
INSERT INTO produtos(id_produto, nome_produto, marca, categoria, preco_unit, custo_unit, estoque) VALUES
    (2,  'iPhone 12',   'Apple', 'Celular', 4100, 3000, 100);
INSERT INTO produtos(id_produto, nome_produto, marca, categoria, preco_unit, custo_unit, estoque) VALUES
    (3,  'Moto G60',   'Motorola', 'Celular', 1600, 800, 100);
INSERT INTO produtos(id_produto, nome_produto, marca, categoria, preco_unit, custo_unit, estoque) VALUES
    (4,  'Samsung S22',   'Samsung', 'Celular', 5000, 2800, 100);
INSERT INTO produtos(id_produto, nome_produto, marca, categoria, preco_unit, custo_unit, estoque) VALUES
    (5,  'Aspire 5',   'Acer', 'Notebook', 3300, 1800, 100);
INSERT INTO produtos(id_produto, nome_produto, marca, categoria, preco_unit, custo_unit, estoque) VALUES
    (6,  'Inspiron 15 3000',   'Dell', 'Notebook', 2800, 1100, 100);
INSERT INTO produtos(id_produto, nome_produto, marca, categoria, preco_unit, custo_unit, estoque) VALUES
    (7,  'Smart TV 4K',   'LG', 'Televisão', 1800, 700, 100);
INSERT INTO produtos(id_produto, nome_produto, marca, categoria, preco_unit, custo_unit, estoque) VALUES
    (8,  'Smart TV Crystal UHD 4K', 'Samsung', 'Televisão', 3000, 1200, 100);

-- Preenche a tabela VENDAS

INSERT INTO vendas(id_venda, id_cliente, id_produto, quantidade) VALUES
	(1,   5, 1, 2);
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
    

-- II. Gerenciando CONSTRAINTS

-- 1. Adicionar constraints
-- 2. Remover constraints

-- Remova a constraint PK da tabela VENDAS.
ALTER TABLE vendas
DROP CONSTRAINT vendas_id_venda_pk;

-- Remova a constraint FK Cliente da tabela VENDAS.
ALTER TABLE vendas
DROP CONSTRAINT vendas_id_cliente_fk;

-- Adicione a constraint PK id_venda na tabela VENDAS.
ALTER TABLE vendas
ADD CONSTRAINT vendas_id_venda_pk PRIMARY KEY(id_venda);

-- Adicione a constraint FK id_cliente na tabela VENDAS.
ALTER TABLE vendas
ADD CONSTRAINT vendas_id_cliente_fk FOREIGN KEY(id_cliente) REFERENCES clientes(id_cliente);


-- Remova a constraint PK id_produto da tabela PRODUTOS (CASCADE).
ALTER TABLE produtos
DROP CONSTRAINT produtos_id_produto_pk CASCADE;


-- III. Violação de constraints

-- Exemplo 1: Violação NOT NULL e CHECK

INSERT INTO produtos(id_produto, nome_produto, marca, preco_unit, custo_unit) VALUES
	(11,  'iPhone 13', 'Apple', 1000, 2200);
    
-- Exemplo 2: Violação UNIQUE

INSERT INTO clientes(id_cliente, nome_cliente, sexo, email, data_nascimento, cpf) VALUES
	(11, 'Karine Dias', 'F', 'kdias@gmail.com', '15/06/1993', '416.209.192-47');

-- Exemplo 3: Violação de FK e PK

INSERT INTO vendas(id_venda, data_venda, id_cliente, id_produto, quantidade) VALUES
    (11,  '12/03/2022',   4, 50, 3);


-- IV. Cuidados ao deletar tabelas com CONSTRAINTS

DROP TABLE clientes CASCADE CONSTRAINTS;
DROP TABLE produtos;
DROP TABLE vendas;





-- V. SEQUÊNCIAS

-- O que é?
-- Uma sequência (Sequence) é um objeto que utilizamos para criação de números 
-- sequenciais automáticos. São usados especialmente para gerar valores sequenciais
-- únicos para as chaves primárias das tabelas.

-- Dessa forma, não precisamos ficar preenchendo a sequência de ids manualmente (como fizemos
-- até então), podemos gerar automaticamente por meio de uma sequence.

/* Sintaxe
*

CREATE SEQUENCE nome_sequencia
INCREMENT BY n
START WITH n
MAXVALUE n | NOMAXVALUE
MINVALUE n | NOMINVALUE
CYCLE | NOCYCLE       -- quando atinge o valor máximo, pode ou não voltar do começo
CACHE n | NOCACHE;

*/

-- Crie uma sequência para o id_venda

CREATE SEQUENCE vendas_seq
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
NOCACHE;

-- Crie uma sequência para o id_cliente

CREATE SEQUENCE clientes_seq
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
NOCACHE;

-- Crie uma sequência para o id_produto

CREATE SEQUENCE produtos_seq
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
NOCACHE;

SELECT * FROM user_sequences;


-- Próximo valor da sequência

SELECT vendas_seq.NEXTVAL
FROM dual;


-- Valor atual da sequência

SELECT vendas_seq.CURRVAL
FROM dual;

-- Excluir uma sequence
DROP SEQUENCE vendas_seq;


-- Usando a sequence na prática

TRUNCATE TABLE vendas;
TRUNCATE TABLE clientes;
TRUNCATE TABLE produtos;

-- Preenche a tabela CLIENTES

INSERT INTO clientes(id_cliente, nome_cliente, sexo, email, data_nascimento, cpf) VALUES
    (clientes_seq.NEXTVAL,  'André Martins',   'M', 'andre.m@gmail.com', '12/02/1989', '839.283.190-00');
INSERT INTO clientes(id_cliente, nome_cliente, sexo, email, data_nascimento, cpf) VALUES
    (clientes_seq.NEXTVAL,  'Bárbara Campos',  'F', 'barb_campos@hotmail.com', '07/05/1992', '351.391.410-02');
INSERT INTO clientes(id_cliente, nome_cliente, sexo, email, data_nascimento, cpf) VALUES
    (clientes_seq.NEXTVAL,  'Carol Freitas',   'F', 'carol@gmail.com', '23/04/1985', '139.274.921-12');
INSERT INTO clientes(id_cliente, nome_cliente, sexo, email, data_nascimento, cpf) VALUES
	(clientes_seq.NEXTVAL,  'Diego Cardoso', 'M', 'dcardoso@gmail.com', '11/10/1994', '192.371.081-17');
INSERT INTO clientes(id_cliente, nome_cliente, sexo, email, data_nascimento, cpf) VALUES
	(clientes_seq.NEXTVAL,  'Eduardo Pereira', 'M', 'edupe@yahoo.com.br', '09/11/1988', '193.174.192-82');
INSERT INTO clientes(id_cliente, nome_cliente, sexo, email, data_nascimento, cpf) VALUES
	(clientes_seq.NEXTVAL,  'Fabiana Silva', 'F', 'fabiisilva@gmail.com', '02/09/1989', '231.298.471-98');
INSERT INTO clientes(id_cliente, nome_cliente, sexo, email, data_nascimento, cpf) VALUES
	(clientes_seq.NEXTVAL,  'Gustavo Barbosa', 'M', 'guto.barbosa@hotmail.com', '27/06/1993', '240.174.171-76');
INSERT INTO clientes(id_cliente, nome_cliente, sexo, email, data_nascimento, cpf) VALUES
	(clientes_seq.NEXTVAL,  'Helen Viana', 'F', 'helenvianaa@gmail.com', '11/02/1990', '193.129.183-01');
INSERT INTO clientes(id_cliente, nome_cliente, sexo, email, data_nascimento, cpf) VALUES
	(clientes_seq.NEXTVAL,  'Irene Castro', 'F', 'castroirene@yahoo.com.br', '21/08/1989', '184.148.102-29');
INSERT INTO clientes(id_cliente, nome_cliente, sexo, email, data_nascimento, cpf) VALUES
	(clientes_seq.NEXTVAL, 'Juliana Pires', 'F', 'jupires@gmail.com', '13/01/1991', '416.209.192-47');

-- Preenche a tabela PRODUTOS

INSERT INTO produtos(id_produto, nome_produto, marca, categoria, preco_unit, custo_unit, estoque) VALUES
	(produtos_seq.NEXTVAL,  'iPhone 11',   'Apple', 'Celular', 3500, 2200, 100);
INSERT INTO produtos(id_produto, nome_produto, marca, categoria, preco_unit, custo_unit, estoque) VALUES
    (produtos_seq.NEXTVAL,  'iPhone 12',   'Apple', 'Celular', 4100, 3000, 100);
INSERT INTO produtos(id_produto, nome_produto, marca, categoria, preco_unit, custo_unit, estoque) VALUES
    (produtos_seq.NEXTVAL,  'Moto G60',   'Motorola', 'Celular', 1600, 800, 100);
INSERT INTO produtos(id_produto, nome_produto, marca, categoria, preco_unit, custo_unit, estoque) VALUES
    (produtos_seq.NEXTVAL,  'Samsung S22',   'Samsung', 'Celular', 5000, 2800, 100);
INSERT INTO produtos(id_produto, nome_produto, marca, categoria, preco_unit, custo_unit, estoque) VALUES
    (produtos_seq.NEXTVAL,  'Aspire 5',   'Acer', 'Notebook', 3300, 1800, 100);
INSERT INTO produtos(id_produto, nome_produto, marca, categoria, preco_unit, custo_unit, estoque) VALUES
    (produtos_seq.NEXTVAL,  'Inspiron 15 3000',   'Dell', 'Notebook', 2800, 1100, 100);
INSERT INTO produtos(id_produto, nome_produto, marca, categoria, preco_unit, custo_unit, estoque) VALUES
    (produtos_seq.NEXTVAL,  'Smart TV 4K',   'LG', 'Televisão', 1800, 700, 100);
INSERT INTO produtos(id_produto, nome_produto, marca, categoria, preco_unit, custo_unit, estoque) VALUES
    (produtos_seq.NEXTVAL,  'Smart TV Crystal UHD 4K', 'Samsung', 'Televisão', 3000, 1200, 100);

-- Preenche a tabela VENDAS

INSERT INTO vendas(id_venda, id_cliente, id_produto, quantidade) VALUES
	(vendas_seq.NEXTVAL,   5, 1, 2);
INSERT INTO vendas(id_venda, data_venda, id_cliente, id_produto, quantidade) VALUES
    (vendas_seq.NEXTVAL,  '10/01/2022',   2, 3, 1);
INSERT INTO vendas(id_venda, data_venda, id_cliente, id_produto, quantidade) VALUES
    (vendas_seq.NEXTVAL,  '13/01/2022',   1, 7, 1);
INSERT INTO vendas(id_venda, data_venda, id_cliente, id_produto, quantidade) VALUES
    (vendas_seq.NEXTVAL,  '02/02/2022',   7, 1, 1);
INSERT INTO vendas(id_venda, data_venda, id_cliente, id_produto, quantidade) VALUES
    (vendas_seq.NEXTVAL,  '17/02/2022',   4, 1, 3);
INSERT INTO vendas(id_venda, data_venda, id_cliente, id_produto, quantidade) VALUES
    (vendas_seq.NEXTVAL,  '21/02/2022',   6, 5, 3);
INSERT INTO vendas(id_venda, data_venda, id_cliente, id_produto, quantidade) VALUES
    (vendas_seq.NEXTVAL,  '05/03/2022',   7, 5, 1);
INSERT INTO vendas(id_venda, data_venda, id_cliente, id_produto, quantidade) VALUES
    (vendas_seq.NEXTVAL,  '07/03/2022',   10, 2, 1);
INSERT INTO vendas(id_venda, data_venda, id_cliente, id_produto, quantidade) VALUES
    (vendas_seq.NEXTVAL,  '09/03/2022',   9, 1, 1);
INSERT INTO vendas(id_venda, data_venda, id_cliente, id_produto, quantidade) VALUES
    (vendas_seq.NEXTVAL,  '12/03/2022',   4, 3, 3);


SELECT * FROM clientes;
SELECT * FROM produtos;
SELECT * FROM vendas;

INSERT INTO vendas(id_venda, data_venda, id_cliente, id_produto, quantidade) VALUES
    (vendas_seq.NEXTVAL,  '13/03/2022',   2, 1, 1);


COMMIT;


-- VI. Alterando Sequences

ALTER SEQUENCE vendas_seq
INCREMENT BY 1
NOMAXVALUE
NOCYCLE
NOCACHE;

-- VII. Cuidados ao criar sequences

-- 1. Se tivermos um ROLLBACK, as transações são desfeitas, mas o NEXTVAL não volta atrás
-- 2. Não utilize uma mesma sequência em mais de uma tabela



-- VIII. ÍNDICES

-- O que é?
-- Um índice se trata de um recurso do Banco de Dados que possibilita que uma consulta
-- seja retornada com uma maior rapidez, otimizando a busca dos dados no BD.

SELECT * FROM produtos
WHERE marca = 'Apple';


CREATE INDEX prod_marca_ix
ON produtos(marca);

DROP INDEX prod_marca_ix;

