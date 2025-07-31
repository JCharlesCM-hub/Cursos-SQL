# Funções de Texto no MySQL

# 1. LENGTH: Retorna a quantidade de caracteres de um texto.ALTER

-- Exemplo 1. Descubra a quantidade de caracteres do texto 'SQL Impressionador'.

SET @varCurso = 'SQL Impressionador';

SELECT LENGTH(@varCurso);


-- Exemplo 2. Descubra a quantidade de caracteres de cada nome na tabela clientes.ALTER

SELECT * FROM clientes;

SELECT
	Nome AS 'Nome',
    LENGTH(Nome) AS 'Núm. Caract.'
FROM clientes;




# 2. CONCAT e CONCAT_WS: Utilizados para concatenar textos. A segunda opçãp permite especificar de 1 vez um separador que será utilizado entre cada texto.ALTER

-- Exemplo 1. Crie 2 variáveis: @varNome e @varSobrenome, e declare um nome e um sobrenome, respectivamente. Utilize as funções CONCAT e CONCAT_WS para criar uma 3ª variável que retorne o nome completo.ALTER

SET @varNome = 'Marcus';
SET @varSobrenome = 'Cavalcanti';
SET @varUltimoNome = 'Jesus';

SET @varNomeCompleto = CONCAT(@varNome, ' ', @varSobrenome, ' ', @varUltimoNome);
SET @varNomeCompleto2 = CONCAT_WS(' ', @varNome, @varSobrenome, @varUltimoNome);


SELECT @varNomeCompleto;
SELECT @varNomeCompleto2;


-- Exemplo 2. Utilize as funções CONCAT e CONCAT_WS na tabela de clientes para criar uma coluna de nome completo.

SELECT * FROM clientes;

SELECT
	ID_Cliente,
    Nome,
    Sobrenome,
    CONCAT_WS(' ', Nome, Sobrenome) AS 'Nome Completo',
    Email
FROM clientes;

SELECT
	ID_Cliente,
    Nome,
    Sobrenome,
    CONCAT(Nome, ' ', Sobrenome) AS 'Nome Completo',
    Email
FROM clientes;




# LCASE e UCASE: Deixam um texto em minúscula e maiúscula, respectivamente.

-- Exemplo 1. Utilize as funções LCASE e UCASE com as variáveis abaixo.

SET @nome = 'Fernando';
SET @sobrenome =  'Martins';

SELECT
	LCASE(@nome),
    UCASE(@sobrenome);
    
    
-- Exemplo 2. Utilize as funções LCASE e UCASE nas colunas de nome completo abaixo.

SELECT
    LCASE(CONCAT(Nome, ' ', Sobrenome)) AS 'Nome Completo (Concat)',
    UCASE(CONCAT_WS(' ', Nome, Sobrenome)) AS 'Nome Completo (Concat_ws)'
FROM clientes;

SELECT
    CONCAT(
        SUBSTRING(Nome, 1, 1),
        LOWER(SUBSTRING(Nome, 2))
    ) AS desired_name
FROM table_name;


# LEFT e RIGHT: Permitem extrair uma parte de um texto, mais à esquerda, ou mais à direita.

-- Exemplo 1. Separe o texto abaixo em 2 partes: 'SQL' e "Hashtag'.

SET @var = 'SQL Hashtag';

SELECT
	LEFT(@var, 3) AS 'Left',
    RIGHT(@var, 7) AS 'Right';
    
    
-- Exemplo 2. Separe os códigos da coluna Num_Serie (tabela 'produtos') em 2 partes.

SELECT * FROM produtos;

SELECT
	LEFT(Num_Serie, 6) AS 'Cod 1',
    RIGHT(Num_Serie, 6) AS 'Cod 2'
FROM produtos;




# REPLACE: Substitui um texto por outro texto.ALTER

-- Exemplo 1. No texto abaixo, substitua 'HIMYM' por 'Friends'. 

SET @texto = 'HIMYM é a melhor série de comédia.';

SET @textonovo = REPLACE(@texto, 'HIMYM', 'Friends');

SELECT @textonovo;


-- Exemplo 2. Substitua o texto 'S' por 'Solteiro'. Em seguida, substitua 'C' por 'Casado'.

SELECT * FROM clientes;

SELECT
	Nome,
    Estado_Civil,
    REPLACE(REPLACE(Estado_Civil, 'S', 'Solteiro'), 'C', 'Casado')
FROM clientes;




# INSTR e MID: A INSTR retorna a posição de um determinado caractere e a função MID extrai textos de forma personalizada (de acordo com uma posição inicial).

-- Exemplo 1: Utilize o e-mail abaixo para fazer as seguintes ações:
-- a) Retornar a posição do caractere '@';
-- b) Retornar o id do e-mail. 

SET @email = 'marcus_cavalcanti@gmail.com';

-- Solução a)
SET @varPosArroba = INSTR(@email, '@');

SELECT @varPosArroba;

-- Solução b)
SET @varIdEmail = MID(@email, 1, @varPosArroba - 1);

SELECT @varIdEmail;


-- Exemplo 2. Utilize as funções INSTR e MID para retornar o ID de todos os e-mails da tabela de clientes.ALTER

SELECT Email, INSTR(Email, '@') FROM clientes;

SELECT
	Email,
    MID(Email, 1, INSTR(Email, '@') - 1)
FROM clientes;




# Funções de Data no MySQL

# 1. DAY(): Retorna o dia de uma data
# 2. MONTH(): Retorna o mês de uma data
# 3. YEAR(): Retorna o ano de uma data

SELECT * FROM clientes;

SELECT
	Nome, 
    Data_Nascimento,
    DAY(Data_Nascimento) AS 'Dia',
    MONTH(Data_Nascimento) AS 'Mês',
    YEAR(Data_Nascimento) AS 'Ano'
FROM clientes;



# Funções de data e hora no MySQL

# 1. NOW(): Retorna a data e hora atuais
# 2. CURDATE(): Retorna a data atual
# 3. CURTIME(): Retorna a hora atual

SELECT 
	NOW(),
    CURDATE(),
    CURTIME();
    


    
# Funções de cálculos com Data: DATEDIFF, DATE_ADD, DATE_SUB
 
# 1. DATEDIFF: Retorna a diferença entre duas datas
 
-- Calcular o tempo de entrega (em dias) de um projeto. 
 
SET @varDataInicio = '2021-04-10';
SET @varDataFim = '2021-07-15';
 
SELECT DATEDIFF(@varDataFim, @varDataInicio);


# 2. DATE_ADD: Adiciona uma quantidade de dias/meses/anos a uma determinada data

-- Um projeto deve ser entregue 10 dias após a data de início. Qual é a data final de entrega?

SET @varDataInicio = '2021-04-10';

SELECT DATE_ADD(@varDataInicio, INTERVAL 10 DAY);


# 3. DATE_SUB: Subtrai uma quantidade de dias/meses/anos a uma determinada data

-- Um projeto finalizou no dia '2021-09-21' e teve 10 dias de duração. Qual foi a data de início?

SET @varDataFim = '2021-09-21';

SELECT DATE_SUB(@varDataFim, INTERVAL 10 DAY);
