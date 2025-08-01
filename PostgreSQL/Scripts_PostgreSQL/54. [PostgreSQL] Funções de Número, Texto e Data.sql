/*
54. [PostgreSQL] Funções de Número, Texto e Data
1. Funções de Número - Ceiling, Floor, Round, Trunc
2. Funções de Texto - Upper, Lower, Length, Initcap, Replace, Substring e Strpos
3. Funções de Data - Current_Date, Age, Date_Part
Feedback do módulo
*/

/*
Em PostgreSQL, as funções CEILING, FLOOR, ROUND e TRUNC são usadas para manipular números e arredondá-los. CEILING retorna o menor inteiro maior ou igual ao número dado. FLOOR retorna o maior inteiro menor ou igual ao número dado. ROUND arredonda para o inteiro mais próximo ou para um número específico de casas decimais. TRUNC remove a parte decimal do número, truncando-o para um número inteiro ou para um número específico de casas decimais. 
Funções de Arredondamento:
CEILING(number):
	* Arredonda o número para cima, para o inteiro mais próximo maior ou igual ao número original. Por exemplo, CEILING(4.2) retornará 5. 
FLOOR(number):
	* Arredonda o número para baixo, para o inteiro mais próximo menor ou igual ao número original. Por exemplo, FLOOR(4.7) retornará 4. 
ROUND(number, precision):
	* Arredonda o número para o inteiro mais próximo ou para o número especificado de casas decimais. O parâmetro precision (opcional) indica quantas casas decimais manter após o arredondamento. Se precision for omitido, arredonda para o inteiro mais próximo. Por exemplo, ROUND(4.678, 2) retornará 4.68, enquanto ROUND(4.2) retornará 4. 
TRUNC(number, precision):
	* Trunca o número para o número especificado de casas decimais, removendo a parte decimal. O parâmetro precision (opcional) indica quantas casas decimais manter após o truncamento. Se precision for omitido, remove a parte decimal. Por exemplo, TRUNC(4.678, 2) retornará 4.67, enquanto TRUNC(4.678) retornará 4. 
Exemplos:
*/
SELECT CEILING(4.2); -- Retorna 5
SELECT FLOOR(4.7);  -- Retorna 4
SELECT ROUND(4.678, 2); -- Retorna 4.68
SELECT ROUND(4.2);  -- Retorna 5
SELECT TRUNC(4.678, 2); -- Retorna 4.67
SELECT TRUNC(4.678); -- Retorna 4
/*
Observações:
	* As funções CEILING e FLOOR sempre retornam um inteiro, independentemente do número de casas decimais do argumento. 
	* A função ROUND arredonda para cima ou para baixo, com base no valor da casa decimal mais significativa ignorada. 
	* A função TRUNC remove a parte decimal sem arredondar, sempre truncando o número para o número especificado de casas decimais ou para um inteiro. 
	* A função TRUNC pode ser usada com um parâmetro de precisão negativo, onde nesse caso, ela define para 0 os dígitos à direita da vírgula decimal e substitui os dígitos à esquerda da vírgula decimal, com base no número de casas decimais especificado (positivo), Neon Postgres. 
*/
-- INÍCIO MÓDULO
-- Funções de Número, Texto e Data
-- Aula 1 - Funções de Número

-- Ceiling, Floor, Round, Trunc
select * from products;

select 
    avg(unit_price),
    ceiling(avg(unit_price)), 
    floor(avg(unit_price)), 
    round(cast(avg(unit_price) as numeric), 3), 
    trunc(cast(avg(unit_price) as numeric), 3) 
from products;
-- Aula 2 - Funções de Texto
-- Upper, Lower, Length, Initcap
/*
Em PostgreSQL, as funções UPPER, LOWER, LENGTH e INITCAP são usadas para manipulação de strings. UPPER converte uma string para maiúsculas, LOWER para minúsculas, LENGTH retorna o comprimento da string e INITCAP converte a primeira letra de cada palavra para maiúscula e o restante para minúscula. 
Exemplos:
UPPER(string): Converte a string para maiúsculas. 
*/
    SELECT UPPER('hello world');
    -- Resultado: HELLO WORLD
/*
LOWER(string): Converte a string para minúsculas. 
*/
    SELECT LOWER('HELLO WORLD');
    -- Resultado: hello world
/*
LENGTH(string): Retorna o número de caracteres na string. 
*/
    SELECT LENGTH('hello'); 
	-- Resultado: 5
/*
INITCAP(string): Converte a primeira letra de cada palavra para maiúscula e o restante para minúscula. 
*/
	SELECT INITCAP('hello world'); 
	-- Resultado: Hello World
/*
Observações:
	* As funções UPPER e LOWER são sensíveis à localidade, ou seja, o comportamento pode variar dependendo da configuração de localidade do banco de dados. 
	* A função INITCAP considera palavras como sequências de caracteres delimitadas por espaços ou outros caracteres não alfanuméricos. 
	* Essas funções são frequentemente usadas para formatação de texto, comparação de strings (especialmente quando ignorando maiúsculas/minúsculas) e preparação de dados para exibição. 
*/
select * from employees;

select 
    first_name,
    upper(first_name),
    lower(first_name),
    length(first_name),
    initcap('sql impressionador')
from employees;

-- Replace
/*
Em PostgreSQL, a função REPLACE é usada para substituir todas as ocorrências de uma substring em uma string por outra substring. A sintaxe básica é REPLACE(string, substring_antiga, nova_substring). Essa função é útil para limpeza de dados, formatação de texto e outras tarefas de manipulação de strings. 
Sintaxe:
*/ 
	REPLACE(string, substring_antiga, nova_substring)
/*
Parâmetros:
	string: A string onde a substituição será realizada.
	substring_antiga: A substring que será substituída.
	nova_substring: A substring que substituirá a antiga. 
Exemplos:
Substituindo texto:
*/
	SELECT REPLACE('Olá, mundo!', 'mundo', 'PostgreSQL');
	-- Resultado: 'Olá, PostgreSQL!'
/*
Substituindo múltiplos caracteres:
*/
	SELECT REPLACE('banana', 'na', 'ta');
	-- Resultado: 'batata'
/*
Substituindo em uma tabela:
*/
	UPDATE sua_tabela
	SET coluna_texto = REPLACE(coluna_texto, 'texto_antigo', 'texto_novo')
	WHERE condição;
/*	
A função REPLACE é case-sensitive, ou seja, diferencia maiúsculas de minúsculas. Se você precisar de uma substituição que não diferencia maiúsculas de minúsculas, pode ser necessário usar outras abordagens, como combinar funções de conversão de caixa com a função REPLACE ou utilizar expressões regulares. 
*/
select * from customers;

select
    contact_name,
    contact_title,
    replace(contact_title, 'Owner', 'CEO') -- Substitui 'Owner' por 'CEO'
from customers;

select
    contact_name,
    contact_title,
    replace(contact_title, 'Owner', 'CEO') AS Substitui_Owner_Por_CEO -- Substitui 'Owner' por 'CEO'
from customers;

-- Substring e Strpos
/*
Em PostgreSQL, a função substring extrai uma parte de uma string, enquanto strpos (ou position) retorna a posição de uma substring dentro de outra. 
Função SUBSTRING()
	A função substring() permite extrair uma parte de uma string, especificando a posição inicial e o comprimento da substring desejada. 
*/
	substring(string, start_position, length)
/*
	string: A string da qual você deseja extrair a substring.
	start_position: A posição inicial da substring (o primeiro caractere é a posição 1).
	length: O número de caracteres a serem extraídos. Se omitido, a função extrai até o final da string a partir da posição inicial. 
Exemplos:
*/
	SELECT substring('Olá, mundo!', 1, 5); -- Resultado: 'Olá, '
	SELECT substring('Olá, mundo!', 7);     -- Resultado: 'mundo!'
	SELECT substring('PostgreSQL', 1, 4);   -- Resultado: 'Post'
/*
Função STRPOS() (ou POSITION())
	* A função strpos() (ou position()) retorna a posição inicial de uma substring dentro de uma string. 
*/
	strpos(string, substring)
	-- ou
	position(substring in string)
/*
string: A string na qual você deseja procurar. 
substring: A substring que você está procurando. 
Exemplos:
*/
	SELECT strpos('Olá, mundo!', 'mundo');  -- Resultado: 7
	SELECT position('mundo' in 'Olá, mundo!'); -- Resultado: 7
	SELECT strpos('PostgreSQL', 'Post');    -- Resultado: 1
	SELECT strpos('PostgreSQL', 'Java');     -- Resultado: 0 (não encontrado)
/*
Diferenças e similaridades entre as funções
	substring() extrai uma parte da string, enquanto strpos() (ou position()) localiza a posição de uma substring. 
	substring() requer um início e um comprimento (ou apenas um início) para extrair a substring. strpos() (ou position()) requer apenas a substring a ser procurada e a string onde procurar. 
	strpos() (ou position()) retorna 0 se a substring não for encontrada. 
	substring() pode retornar uma string vazia ou NULL se a posição inicial for inválida ou o comprimento exceder o tamanho da string.
	Observação: Em alguns casos, você pode precisar usar a função regexp_substr para extrair substrings com base em expressões regulares. 
*/

select
    'ABC-9999',
    left('ABC-9999', 3),
    right('ABC-9999', 4);
    
select
    'ABC-9999',
    substring('ABC-9999', 1, strpos('ABC-9999', '-') -1),
    substring('ABC-9999', strpos('ABC-9999', '-') +1, 100),
    strpos('ABC-9999', '-');
 
-- Aula 3 - Funções de Data 
-- Current_Date, Age, Date_Part
-- ++++++++++++++++++++++++++++++++++++++++++++++
/*
Em PostgreSQL, as funções CURRENT_DATE, AGE e DATE_PART são usadas para manipular e extrair informações de datas e horários. CURRENT_DATE retorna a data atual, AGE calcula a diferença entre duas datas como um intervalo, e DATE_PART extrai uma parte específica de uma data ou horário. 
1. CURRENT_DATE: 
	* Retorna a data atual no fuso horário da sessão do banco de dados.
	* É uma função simples que não requer argumentos e retorna um valor do tipo DATE.
	Exemplo: SELECT CURRENT_DATE;
2. AGE: 
	* Calcula a diferença entre duas datas ou horários e retorna um intervalo.
	* Sintaxe: AGE(data_fim, data_inicio) ou AGE(data) (onde a data atual é usada como data_fim).
	Exemplo: SELECT AGE('2024-07-31', '2000-01-01'); (retorna um intervalo de 24 anos, 6 meses e 30 dias).
3. DATE_PART:
	* Extrai uma parte específica de um valor de data ou horário. 
	* Sintaxe: DATE_PART('campo', data_ou_horario). 
			 campo especifica qual parte extrair (ex: 'year', 'month', 'day', 'hour', 'minute', etc.). 
	* Exemplo: SELECT DATE_PART('year', '2024-07-31 10:30:00'); (retorna 2024). 
	* Outros valores permitidos para campo: 'century', 'decade', 'millisecond', 'microsecond', 'dow', 'doy', 'epoch', 'isodow', 'isoyear', 'timezone', 'timezone_hour', 'timezone_minute'. 
Exemplo prático usando as três funções:
*/
	SELECT
	    CURRENT_DATE AS data_nasc,
	    AGE(birth_date) AS idade,
	    DATE_PART('year', birth_date) AS ano,
	    DATE_PART('month', birth_date) AS mes,
	    DATE_PART('day', birth_date) AS dia
		FROM employees;
/*
Este exemplo mostra como usar as três funções em uma única consulta para obter a data atual, a idade calculada a partir de duas datas, e o ano, mês e dia de uma data específica. 
*/
select * from employees;

select 
    first_name,
    birth_date,
    current_date,
    age(birth_date),
    date_part('day', birth_date),
    date_part('month', birth_date),
    date_part('year', birth_date)
from employees;
