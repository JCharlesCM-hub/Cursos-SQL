/* Administração de Banco de Dados e Segurança

-- I. GRANT e REVOKE

-- Você pode conceder permissões (GRANT) ou retirar permissões (REVOKE) a uma série de objetos dentro de um banco de dados.

-- 1. GRANT privilégios sobre uma tabela

Você pode conceder aos usuários privilégios a tabelas. Esses privilégios podem ser uma combinação de SELECT, INSERT, 
UPDATE, DELETE, ALTER, REFERENCES, INDEX, ALL.

Sintaxe:

GRANT privilegios ON objeto TO usario;

REVOKE privilegios ON objeto FROM usario;


1) Onde os privilégios podem ser:

    SELECT                  - Possibilidade de selecionar tabelas.
    INSERT                  - Possibilidade de inserir dados em tabelas.
    UPDATE                  - Possibilidade de atualizar tabelas.
    DELETE                  - Possibilidade de excluir tabelas.
    REFERENCES              - Possibilidade de criar constraints que fazem referência a uma tabela.
    ALTER                   - Possibilidade de utilizar comandos do tipo ALTER TABLE.
    INDEX                   - Possibilidade de criar índices em uma tabela.
    ALL                     - Todos os privilégios de uma tabela.
    EXECUTE                 - Possibilidade de executar uma function ou procedure.
    CREATE SESSION          - Possibilidade de se conectar ao banco de dados.
    CREATE TABLE            - Possibilidade de criar uma tabela
    CREATE VIEW             - Possibilidade de criar uma view
    CREATE ANY TRIGGER      - Possibilidade de criar uma trigger
    CREATE ANY PROCEDURE    - Possibilidade de criar uma procedure
    CREATE ANY FUNCTION     - Possibilidade de criar uma function
    CREATE SEQUENCE         - Possibilidade de criar uma sequence
    
2) Objeto se trata do nome do objeto do banco de dados ao qual estão sendo dadas as permissões.

3) Usuário é o nome do usuário ao qual serão dados os privilégios.

*/







-- II. Usuários

-- Um usuário se trata de uma conta de banco de dados que permite uma pessoa fazer um login no sistema.

-- 1. Criando um usuário

CREATE USER teste
    IDENTIFIED BY 123;
    

-- 2. Alterando a senha de um usuário

ALTER USER teste
    IDENTIFIED BY 456;
    
-- 3. Excluindo usuário

DROP USER teste;
    







 
-- III. Concedendo permissão para criar nova sessão.

/*
    SELECT                  - Possibilidade de selecionar tabelas.
    INSERT                  - Possibilidade de inserir dados em tabelas.
    UPDATE                  - Possibilidade de atualizar tabelas.
    DELETE                  - Possibilidade de excluir tabelas.
    REFERENCES              - Possibilidade de criar constraints que fazem referência a uma tabela.
    ALTER                   - Possibilidade de utilizar comandos do tipo ALTER TABLE.
    INDEX                   - Possibilidade de criar índices em uma tabela.
    ALL                     - Todos os privilégios de uma tabela.
    EXECUTE                 - Possibilidade de executar uma function ou procedure.
    CREATE SESSION          - Possibilidade de se conectar ao banco de dados.
    CREATE TABLE            - Possibilidade de criar uma tabela
    CREATE VIEW             - Possibilidade de criar uma view
    CREATE ANY TRIGGER      - Possibilidade de criar uma trigger
    CREATE ANY PROCEDURE    - Possibilidade de criar uma procedure
    CREATE ANY FUNCTION     - Possibilidade de criar uma function
    CREATE SEQUENCE         - Possibilidade de criar uma sequence

*/

GRANT CREATE SESSION TO teste;

CREATE TABLE clientes(id INT, nome VARCHAR2(100));

GRANT CREATE TABLE TO teste;



