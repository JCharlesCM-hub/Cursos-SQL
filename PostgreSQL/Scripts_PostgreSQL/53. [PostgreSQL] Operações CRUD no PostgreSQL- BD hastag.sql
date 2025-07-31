-- ++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- CRIAR TABELAS NO BD hashtag
	-- Clique com o btn esquerdo no BD hashtag para abrir.
	-- Clique com o btn esquerdp em "Query Tool" para abrir uma query no BD hashtag.
	-- Agora essa query está dentro do BD hashtag.
-- Sabendo os principais tipos de dados, a criação das nossas tabelas seguirá a estrutura abaixo:

CREATE TABLE alunos(
    ID_Aluno INT,
    Nome_Aluno VARCHAR(100),
    Email VARCHAR(100)
);
-- Atualizar BD hashtag, clicar com btn direito em BD hashtag / REFRESH 

CREATE TABLE cursos(
    ID_Curso INT,
    Nome_Curso VARCHAR(100),
    Preco_Curso NUMERIC(10, 2)
);
-- Atualizar BD hashtag, clicar com btn direito em BD hashtag / REFRESH 

CREATE TABLE matriculas(
    ID_Matricula INT,
    ID_Aluno INT,
    ID_Curso INT,
    Data_Cadastro DATE
);
-- Atualizar BD hashtag, clicar com btn direito em BD hashtag / REFRESH 

SELECT * FROM alunos;
SELECT * FROM cursos;
SELECT * FROM matriculas;

-- MAS... ainda podemos incluir CONSTRAINTS, ou seja, restrições na criação das tabelas.
DROP TABLE alunos;
DROP TABLE cursos;
DROP TABLE matriculas;
-- Atualizar BD hashtag, clicar com btn direito em BD hashtag / REFRESH 

-- # 3. Restrições (Constraints) são regras aplicadas nas colunas de uma tabela
    -- Ex. 1: Podemos especificar que uma coluna não pode ter valores NULL;
    -- Ex. 2: Podemos especificar que uma coluna deverá ser uma chave primária ou chave estrangeira
-- São usadas para limitar os tipos de dados que são inseridos.

-- # Principais:

-- # I. NOT NULL:
-- A Constraint NOT NULL faz com que uma coluna não aceite valores NULL. Ela identifica que nenhum valor foi definido.
-- A Constraint NOT NULL obriga um campo a sempre possuir um valor.
-- Dessa forma, uma coluna com restrição NOT NULL não aceita valores vazios.
        -- Nome_Cliente VARCHAR(100) NOT NULL

-- # II. PRIMARY KEY (Chave Primária):
-- A PRIMARY KEY identifica de forma única cada registro em uma tabela do banco de dados.
-- Chaves primárias devem conter valores únicos.
-- Uma coluna de chave primária não pode conter valores NULL.
-- Cada tabela deve conter 1 e apenas 1 chave primária.

-- # III. FOREIGN KEY (Chave Estrangeira):
-- Uma FOREING KEY em uma tabela é um campo que aponta para uma chave primária em outra tabela.

-- # CREATE TABLE:
-- # 4. Criando as tabelas no banco de dados:

CREATE TABLE alunos(
    ID_Aluno INT,
    Nome_Aluno VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    PRIMARY KEY(ID_Aluno)
);
-- Atualizar BD hashtag, clicar com btn direito em BD hashtag / REFRESH 
CREATE TABLE cursos(
    ID_Curso INT,
    Nome_Curso VARCHAR(100) NOT NULL,
    Preco_Curso NUMERIC(10, 2) NOT NULL,
    PRIMARY KEY(ID_Curso)
);
-- Atualizar BD hashtag, clicar com btn direito em BD hashtag / REFRESH 
CREATE TABLE matriculas(
    ID_Matricula INT,
    ID_Aluno INT NOT NULL,
    ID_Curso INT NOT NULL,
    Data_Cadastro DATE NOT NULL,
    PRIMARY KEY(ID_Matricula),
    FOREIGN KEY(ID_Aluno) REFERENCES alunos(ID_Aluno),
    FOREIGN KEY(ID_Curso) REFERENCES cursos(ID_Curso)
);
-- Atualizar BD hashtag, clicar com btn direito em BD hashtag / REFRESH 

-- # INSERT INTO

-- 5. Inserindo dados nas tabelas.
INSERT INTO alunos(ID_Aluno, Nome_Aluno, Email)
VALUES
    (1, 'Ana'   ,   		'ana123@gmail.com'         ),
    (2, 'Bruno' ,   		'bruno_vargas@outlook.com' ),
    (3, 'Carla' ,   		'carlinha1999@gmail.com'   ),
    (4, 'Diego' ,   		'diicastroneves@gmail.com' ),
	(5, 'Charmilton' ,   	'Charmilton@gmail.com'     ),
	(6, 'Maria Fernandes',  'maria19@gmail.com'        ),
	(7, 'Analia' ,   		'analia@gmail.com'         ),
	(8, 'Antonio Oliveira', 'antonio@gmail.com'        );
    
SELECT * FROM alunos;

INSERT INTO cursos(ID_Curso, Nome_Curso, Preco_Curso)
VALUES
    (1, 'Excel'     , 100),
    (2, 'VBA'       , 200),
    (3, 'PowerBI'   , 150), 
    (4, 'Full Stak' , 450), 
    (5, 'Python'    , 1150);	
	
SELECT * FROM cursos;

INSERT INTO matriculas(ID_Matricula, ID_Aluno, ID_Curso, Data_Cadastro)
VALUES
    (1, 1, 1, '2021/03/11'  ),
    (2, 1, 2, '2021/06/21'  ),
    (3, 2, 3, '2021/01/08'  ),
    (4, 3, 1, '2021/04/03'  ),
    (5, 4, 1, '2021/05/10'  ),
    (6, 4, 3, '2021/05/10'  ),
    (7, 5, 1, '2021/03/11'  ),
    (8, 5, 2, '2021/06/21'  ),
    (9, 6, 3, '2021/01/08'  ),
    (10, 7, 1, '2021/04/03' ),
    (11, 8, 1, '2021/05/10' ),
    (12, 8, 3, '2021/05/10' );
	
SELECT * FROM matriculas;

-- # UPDATE:
-- 6. Atualizando dados de uma tabela com o UPDATE:
SELECT * FROM alunos;
SELECT * FROM cursos;
SELECT * FROM matriculas;

UPDATE cursos
SET Preco_Curso = 300
WHERE ID_Curso = 1;

SELECT * FROM cursos;

-- # DELETE:
-- 7. Deletando registros de uma tabela:
SELECT * FROM matriculas;
SELECT * FROM alunos;
SELECT * FROM cursos;

DELETE FROM matriculas
WHERE ID_Matricula = 6;

SELECT * FROM matriculas; 

-- # TRUNCATE
-- 8. Deletando todos os registros da tabela de uma vez, mas a tabela continua existindo:
SELECT * FROM matriculas; 

TRUNCATE TABLE matriculas; -- Não apaga a tabela só os dados

SELECT * FROM matriculas; 

-- # DROP
-- 9. Deletando tabelas do banco de dados
-- Atenção: Cuidado ao excluir uma tabela que tenha restrições de PRIMARY KEY!!!
DROP TABLE alunos CASCADE;
DROP TABLE cursos CASCADE;
DROP TABLE matriculas;

