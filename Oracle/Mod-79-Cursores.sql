-- Cursores

/*
-- O que é um Cursor?

Um cursor é um ponteiro que aponta para o resultado de uma query. Com ele, podemos acessar 
-- os registros (linhas) de uma tabela.


|  ID_CLIENTE   |   NOME_CLIENTE   |        CPF        |
--------------------------------------------------------
|      1        |       André      |   123.456.789-10  |     
--------------------------------------------------------
|      2        |       Bruna      |   321.654.987-01  |
--------------------------------------------------------
|      3        |       Carla      |   455.136.621-89  |           <---------- PONTEIRO
--------------------------------------------------------
|      4        |       Diego      |   135.112.987-88  |
--------------------------------------------------------
|      5        |       Erika      |   461.778.132-32  |
--------------------------------------------------------
|      6        |       Fabio      |   289.123.456-31  |
--------------------------------------------------------




-- Tipos de Cursores

Os cursores podem ser de dois tipos:

-- 1. Ímplícito
Sempre que o Oracle executa um INSERT, UPDATE, DELETE ou SELECT INTO, ele automaticamente cria um cursor implícito.


-- 2. Explícito
Um cursor explícito se trata de um SELECT declarado explicitamente na seção DECLARE de um bloco de código.

Para esse tipo de cursor, precisamos controlar sua abertura (OPEN), seu acesso (FETCH) e seu fechamento (CLOSE).



-- Sintaxe de um cursor

-- 1. Declarar o cursor

CURSOR nome_cursor IS SELECT;                   -- sem parâmetros

CURSOR nome_cursor(parametros) IS SELECT;       -- com parâmetros

-- 2. Abrir o cursor

OPEN nome_cursor;

-- 3. Acessar linhas do cursor

FETCH nome_cursor
INTO lista_de_variaveis;


-- 4. Fechar o cursor

CLOSE nome_cursor;

*/







-- Exemplo. Acessa os registros da tabela EMPLOYEES utilizando um LOOP básico.

SET SERVEROUTPUT ON;

DECLARE
    CURSOR cursor_employees IS
    SELECT * FROM employees;
    
    employees_record cursor_employees%rowtype;
    
BEGIN
    OPEN cursor_employees;
    
    LOOP
        FETCH cursor_employees
        INTO employees_record;
    EXIT WHEN cursor_employees%notfound;
    
    dbms_output.put_line(employees_record.employee_id || ' - ' ||
                         employees_record.first_name || ' - ' ||
                         employees_record.last_name || ' - ' ||
                         employees_record.email || ' - ' ||
                         employees_record.phone_number || ' - ' ||
                         employees_record.job_id || ' - ' ||
                         employees_record.salary);
                         
    END LOOP;

    CLOSE cursor_employees;
    
END;

























-- Exemplo. Acessa os registros da tabela EMPLOYEES utilizando um WHILE LOOP.


SET SERVEROUTPUT ON;

DECLARE

    CURSOR cs_employees IS
    SELECT * FROM employees;
    
    employees_record cs_employees%rowtype;

BEGIN

    OPEN  cs_employees;
    
    FETCH cs_employees
    INTO employees_record;
     
    WHILE cs_employees%found LOOP
        
        
        
    dbms_output.put_line(employees_record.employee_id || ' - ' ||
                         employees_record.first_name || ' - ' ||
                         employees_record.last_name || ' - ' ||
                         employees_record.email || ' - ' ||
                         employees_record.phone_number || ' - ' ||
                         employees_record.hire_date || ' - ' ||
                         employees_record.job_id || ' - ' ||
                         employees_record.salary);
    
    FETCH cs_employees
    INTO employees_record;
                   
    END LOOP;
    
    CLOSE cs_employees;
    
END;   









-- Exemplo. Acessa os registros da tabela EMPLOYEES utilizando um FOR LOOP.

SET SERVEROUTPUT ON;

DECLARE

    CURSOR cs_employees IS
    SELECT * FROM employees;

BEGIN

    FOR employees_record IN cs_employees LOOP    
        
    dbms_output.put_line(employees_record.employee_id || ' - ' ||
                         employees_record.first_name || ' - ' ||
                         employees_record.last_name || ' - ' ||
                         employees_record.email || ' - ' ||
                         employees_record.phone_number || ' - ' ||
                         employees_record.hire_date || ' - ' ||
                         employees_record.job_id || ' - ' ||
                         employees_record.salary);                     
    END LOOP; 
END;   








-- Exemplo. Cursor com parâmetros que acessa os registros da tabela EMPLOYEES utilizando um FOR LOOP.


SET SERVEROUTPUT ON;

DECLARE

    CURSOR cs_employees(vjob_id VARCHAR2) IS
    SELECT * FROM employees
    WHERE job_id = vjob_id;

BEGIN
    FOR employees_record IN cs_employees('ST_MAN') LOOP       
    dbms_output.put_line(employees_record.employee_id || ' - ' ||
                         employees_record.first_name || ' - ' ||
                         employees_record.last_name || ' - ' ||
                         employees_record.email || ' - ' ||
                         employees_record.phone_number || ' - ' ||
                         employees_record.hire_date || ' - ' ||
                         employees_record.job_id || ' - ' ||
                         employees_record.salary);                      
    END LOOP; 
END;  










