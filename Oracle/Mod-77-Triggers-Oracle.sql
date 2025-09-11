/* Triggers DML

-- Um Trigger é um gatilho que será disparado automaticamente quando acontecer um evento.

-- Um Trigger DML é disparado quando um comando INSERT, UPDATE ou DELETE é executado sobre uma tabela ou view.

-- Na hora de criar uma trigger, podemos definir alguns elementos:

-- a) Tempo de execução:
        -- BEFORE (antes)   
        -- AFTER (depois)
        
-- b) Evento:
        -- INSERT
        -- UPDATE [OF coluna]
        -- DELETE
        
-- c) Tipo:
        -- STATEMENT        (nível de comando - default)
        -- FOR EACH ROW     (nível de linha)
        
        
-- d) Corpo:
    -- Bloco de Comandos
*/
    
-- BEFORE INSERT
    
-- Exemplo 1: Crie uma Trigger que seja disparada sempre antes que um comando INSERT for feito na tabela PRODUTOS:
-- Caso o dia em que o INSERT esteja sendo feito seja SÁBADO ou DOMINGO e o horário não seja o comercial (entre 9 e 18),
-- então o INSERT deverá ser abortado


CREATE OR REPLACE TRIGGER TG_PRODUTOS_BEFORE_INSERT
BEFORE INSERT
ON produtos
BEGIN
    IF (TRIM(TO_CHAR(SYSDATE, 'DAY')) IN ('SÁBADO', 'DOMINGO') AND
        TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) NOT BETWEEN 9 AND 18)
    THEN
        RAISE_APPLICATION_ERROR(-20001, 'O cadastro de produtos deve ser feito de seg. à sex., entre 9 e 18h.');
    END IF;
END;


BEGIN
INSERT INTO produtos(id_produto, nome_produto, marca, categoria, preco_unit, custo_unit, estoque)
VALUES (produtos_seq.NEXTVAL, 'iPhone 40', 'Apple', 'Celular', 15000, 3000, 100);
COMMIT;
END;


-- BEFORE INSERT, UPDATE ou DELETE
    
-- Exemplo 2: Crie uma Trigger que seja disparada sempre que um comando INSERT for feito na tabela PRODUTOS.
-- Caso o dia em que o INSERT esteja sendo feito seja SÁBADO ou DOMINGO e o horário não seja o comercial (entre 9 e 18),
-- então o INSERT deverá ser abortado


CREATE OR REPLACE TRIGGER TG_PRODUTOS_BEFORE_INSERT_UPDATE_DELETE
BEFORE INSERT OR UPDATE OR DELETE
ON produtos
BEGIN
    IF (TRIM(TO_CHAR(SYSDATE, 'DAY')) IN ('SÁBADO', 'DOMINGO') AND
        TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) NOT BETWEEN 9 AND 18)
    THEN
        CASE
            WHEN INSERTING THEN
                RAISE_APPLICATION_ERROR(-20001, 'O cadastro de produtos deve ser feito de seg. à sex., entre 9 e 18h.');
            WHEN UPDATING THEN
                RAISE_APPLICATION_ERROR(-20001, 'A atualização de produtos deve ser feito de seg. à sex., entre 9 e 18h.');
        ELSE
                RAISE_APPLICATION_ERROR(-20001, 'A exclusão de produtos deve ser feito de seg. à sex., entre 9 e 18h.');
        END CASE;
    END IF;
END;


BEGIN
INSERT INTO produtos(id_produto, nome_produto, marca, categoria, preco_unit, custo_unit, estoque)
VALUES (produtos_seq.NEXTVAL, 'iPhone 40', 'Apple', 'Celular', 15000, 3000, 100);
COMMIT;
END;



-- Habilitando ou Desabilitando uma Trigger

ALTER TRIGGER TG_PRODUTOS_BEFORE_INSERT_UPDATE_DELETE DISABLE;

ALTER TRIGGER TG_PRODUTOS_BEFORE_INSERT_UPDATE_DELETE ENABLE;


-- Habilitando ou Desabilitando TODAS as Triggers de uma tabela

ALTER TABLE produtos DISABLE ALL TRIGGERS;

ALTER TABLE produtos ENABLE ALL TRIGGERS;


-- Excluindo uma Trigger

DROP TRIGGER TG_PRODUTOS_BEFORE_INSERT_UPDATE_DELETE;
        