#=== Operações CRUD ===#

# Introdução 
-- Operações CRUD são operações que conseguimos fazer em um Banco de Dados. Essa sigla significa o seguinte:

-- C reate: Permite criar Bancos de Dados, Tabelas ou Exibições (Views)

-- R ead: Permite ler os dados do banco de dados. Basicamente foi o que mais fizemos no Curso, através do SELECT. 

-- U pdate: Permite atualizar os dados do banco de dados, tabelas ou views.

-- D elete: Permite deletar de um banco de dados, dados, tabelas ou views. 

-- No módulo anterior, vimos como criar Views (exibições) com os operadores CRUD. Essas exibições não são entendidas exatamente como tabelas do banco de dados. Agora, o que vamos fazer é aprender como criar tabelas propriamente ditas.



### CRUD EM BANCO DE DADOS

# 1. CREATE DATABASE: Criando um banco de dados

-- Para criar um banco de dados, usamos o seguinte comando:

-- CREATE DATABASE nome_bd;

-- CREATE DATABASE IF NOT EXISTS nome_bd;

-- Obs.: O IF NOT EXISTS não é obrigatório. Sua função é evitar o erro que pode acontecer se você já tiver criado um banco de dados com o mesmo nome. 
-- Exemplo:

CREATE DATABASE db_Exemplo;

CREATE DATABASE IF NOT EXISTS db_Exemplo;


# 2. SHOW DATABASES: Verificando um banco de dados

-- É possível verificar os bancos de dados existentes utilizando o comando SHOW:

SHOW DATABASES;


# 3. USE: Usando um BD específico

-- O comando USE define um banco de dados específico como sendo o padrão do sistema.

USE db_Exemplo;

-- Caso você queira saber qual é o banco de dados selecionado no momento, você pode usar o comando:

SELECT DATABASE();


# 4. DROP: Excluindo um banco de dados

-- Para excluir um banco de dados, usamos o seguinte comando:

DROP DATABASE db_Exemplo;
DROP DATABASE IF EXISTS db_Exemplo;




### CRUD EM TABELAS

-- Crie o banco de dados db_Exemplo e defina-o como padrão:

CREATE DATABASE IF NOT EXISTS db_Exemplo;
USE db_Exemplo;
--

# Tipos de Dados no MySQL
-- Quando criamos uma nova tabela, precisamos especificar quais são as colunas que esssa tabela deve conter.
-- Cada uma dessas colunas vai armazenar um tipo de dados específico.
-- Os principais tipos de dados são listados abaixo:

-- INT:
-- Um inteiro médio. O intervalo assinado é de -2147483648 a 2147483647.

-- DECIMAL(M, D):
-- O número total de dígitos é especificado em M. O número de dígitos após o ponto decimal é especificado no parâmetro D. O número máximo para M é 65. O número máximo para D é 30. O valor padrão para M é 10. O valor padrão para D é 0. 

-- 1500.59 -- DECIMAL(6, 2)
 
-- VARCHAR(N):
-- Uma string de comprimento VARIÁVEL (pode conter letras, números e caracteres especiais). O parâmetro N especifica o comprimento máximo da coluna em caracteres - pode ser de 0 a 65535. 

-- DATE:
-- Uma data no formato: YYYY-MM-DD. O intervalor compatível é de '1000-01-01' a '9999-12-31'.

-- DATETIME:
-- Uma combinação de data e hora. Formato: YYYY-MM-DD HH:MM:SS. O intervalo compatível é de '1000-01-01 00:00:00' a '9999-12-31 23:59:59'.


-- Agora que sabemos os principais tipos de dados, podemos criar nossas tabelas. 

CREATE TABLE IF NOT EXISTS dAlunos(
	ID_Aluno INT,
    Nome_Aluno VARCHAR(100),
    Email VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS dCursos(
	ID_Curso INT,
    Nome_Curso VARCHAR(100),
    Preco_Curso DECIMAL(10, 2)
);

CREATE TABLE IF NOT EXISTS fMatriculas(
	ID_Matricula INT,
	ID_Aluno INT,
    ID_Curso INT,
    Data_Cadastro DATE
);


SHOW TABLES;

DROP TABLE dAlunos;

SELECT * FROM dAlunos;
SELECT * FROM dCursos;
SELECT * FROM fMatriculas;




# CONSTRAINTS

# 4. Adicionando constraints nas colunas das tabelas criadas.

-- Restrições (Constraints) são regras aplicadas nas colunas de uma tabela.
	-- Ex1: Podemos especificar que uma coluna não pode ter valores NULL;
    -- Ex2: Podemos especificar que uma coluna deverá ser uma chave primária ou chave estrangeira;
-- São usadas para limitar os tipso de dados que são inseridos. 

# Principais:

# I. NOT NULL:
-- A constraint NOT NULL faz com que uma coluna não aceite valores NULL. Um valor NULL é diferente de zero ou vazio, ele identifica que nenhum valor foi definido. 
-- A constraint NOT NULL obriga um campo a sempre possuir um valor. 
-- Dessa forma, não é possível inserir um registro ou atualizar sem entrar com um valor neste campo. 

		-- Nome_Cliente VARCHAR(100) NOT NULL

# II. UNIQUE
-- A restrição UNIQUE identifica de forma única cada registro em uma tabela de um banco de dados.
-- As constraints UNIQUE e PRIMARY KEY garantem a unicidade em uma coluna ou conjunto de colunas.
-- Uma constraint PRIMARY KEY automaticamente possui uma restrição UNIQUE definida.
-- Você pode ter várias constraints UNIQUE em uma tabela, mas apenas uma Chave Primária por tabela.

# III. DEFAULT
-- Essa restrição insere um valor padrão na coluna.
-- O valor padrão será adicionado a todos os novos registros caso nenhum outro valor seja especificado. 

# IV. PRIMARY KEY (Chave Primária)
-- A PRIMARY KEY identifica de forma única cada registro em uma tabela do banco de dados.
-- Chaves primárias devem conter valores únicos.
-- Uma coluna de chave primária não pode conter valores NULL. 
-- Cada tabela deve conter 1 e apenas 1 chave primária.

# V. FOREIGN KEY (Chave Estrangeira)
-- Uma FOREIGN KEY em uma tabela é um campo que aponta para uma chave primária em outra tabela. 

DROP TABLE IF EXISTS dAlunos;
DROP TABLE IF EXISTS dCursos;
DROP TABLE IF EXISTS fMatriculas;


CREATE TABLE IF NOT EXISTS dAlunos(
	ID_Aluno INT,
    Nome_Aluno VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    PRIMARY KEY(ID_Aluno)
);

CREATE TABLE IF NOT EXISTS dCursos(
	ID_Curso INT,
    Nome_Curso VARCHAR(100) NOT NULL,
    Preco_Curso DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY(ID_Curso)
);

CREATE TABLE IF NOT EXISTS fMatriculas(
	ID_Matricula INT,
	ID_Aluno INT NOT NULL,
    ID_Curso INT NOT NULL,
    Data_Cadastro DATE NOT NULL,
    PRIMARY KEY(ID_Matricula),
    FOREIGN KEY(ID_Aluno) REFERENCES dAlunos(ID_Aluno),
    FOREIGN KEY(ID_Curso) REFERENCES dCursos(ID_Curso)
);



# INSERT INTO

# 5. Inserindo dados nas tabelas. 

INSERT INTO dAlunos(ID_Aluno, Nome_Aluno, Email)
VALUES
	(1, 'Ana'	, 'ana123@gmail.com'			),
    (2, 'Bruno'	, 'bruno_vargas@outlook.com'	),
    (3, 'carla'	, 'carlinha1999@gmail.com'		),
    (4, 'Diego'	, 'diicastroneves@gmail.com'	);
    
SELECT * FROM dAlunos;


INSERT INTO dCursos(ID_Curso, Nome_Curso, Preco_Curso)
VALUES
	(1, 'Excel'		, 100),
    (2, 'VBA'		, 200),
    (3, 'Power BI'	, 150);
    
SELECT * FROM dCursos;


INSERT INTO fMatriculas(ID_Matricula, ID_Aluno, ID_Curso, Data_Cadastro)
VALUES
	(1, 1, 1, '2021-03-11'),
    (2, 1, 2, '2021-06-21'),
    (3, 2, 3, '2021-01-08'),
    (4, 3, 1, '2021-04-03'),
    (5, 4, 1, '2021-05-10'),
    (6, 4, 3, '2021-05-10');
    
SELECT * FROM fMatriculas;



# 6. Atualizando dados de uma tabela com o UPDATE
SELECT * FROM dAlunos;
SELECT * FROM dCursos;
SELECT * FROM fMatriculas;

UPDATE dCursos
SET Preco_Curso = 300
WHERE ID_Curso = 1;



# 7. Deletando registros de uma tabela

SELECT * FROM fMatriculas;
SELECT * FROM dAlunos;
SELECT * FROM dCursos;

DELETE FROM fMatriculas
WHERE ID_Matricula = 6;




# TRUNCATE TABLE x DROP TABLE

-- TRUNCATE TABLE: Deleta todos os registros da tabela de uma vez, mas a tabela continua existindo.

-- DROP TABLE: Deleta todos os registrso da tabela, inclusive a própria tabela. 

SELECT * FROM fMatriculas;

TRUNCATE TABLE fMatriculas;
DROP TABLE fMatriculas;
