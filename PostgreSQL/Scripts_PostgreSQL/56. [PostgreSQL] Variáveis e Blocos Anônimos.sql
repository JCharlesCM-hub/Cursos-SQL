/*  
56. [PostgreSQL] Variáveis e Blocos Anônimos
1. Variáveis, Datatypes e Blocos Anônimos
2. Blocos Anônimos - Exemplos
Feedback do módulo
*/
/*
Em PostgreSQL, variáveis são espaços de memória nomeados utilizados para armazenar dados dentro de um bloco de código, como funções ou blocos anônimos. Tipos de dados (datatypes) definem o tipo de valor que uma variável pode conter (inteiro, texto, etc.). Blocos anônimos são trechos de código que podem ser executados sem a necessidade de serem definidos como uma função ou procedimento, permitindo a execução de código procedural dentro do PostgreSQL. 

Variáveis:
	* São usadas para armazenar valores temporários durante a execução de um bloco de código PL/pgSQL.
	* Devem ser declaradas antes de serem usadas, especificando seu nome e tipo de dado.
	* Podem ter um valor inicial definido ou receber um valor posteriormente.
	* O escopo de uma variável é limitado ao bloco em que ela é declarada. 

Tipos de Dados:
	* Definem o tipo de dado que uma variável pode armazenar, como números inteiros (INTEGER), textos (VARCHAR), datas (DATE), etc.
	* Permitem que o PostgreSQL valide os valores atribuídos às variáveis, garantindo a integridade dos dados.
	* Exemplos comuns incluem INTEGER, VARCHAR, BOOLEAN, DATE, TIMESTAMP, e muitos outros. 

Blocos Anônimos:
	* São trechos de código PL/pgSQL que podem ser executados diretamente, sem a necessidade de estarem associados a uma função ou procedimento.
	* Geralmente usados para realizar tarefas pontuais ou testes.
	* Possuem uma seção de declaração (opcional) onde as variáveis são declaradas, e uma seção de corpo onde o código é executado.

Sintaxe básica: 
*/
    <<nome_do_bloco>>
    DECLARE
        -- Declaração de variáveis
    BEGIN
        -- Código a ser executado
    END;
/*
O ponto e vírgula (;) é obrigatório ao final de cada instrução dentro do bloco
*/

-- INÍCIO MÓDULO
-- Variáveis e Blocos Anônimos 

-- Aula 1 - Variáveis, Datatypes e Blocos Anônimos
-- Variáveis são pedaços de memória onde armazenamos alguma informação. Uma variável está sempre associada a um tipo de dado em particular.

-- Os tipos mais comuns de dados são:

-- 1. Numéricos: int e decimal
-- 2. Textos: varchar(n)
-- 3. Datas: date

-- Bloco Anônimo (Introdução)

-- No PostgreSQL, é possível criar os chamados Blocos Anônimos, blocos de códigos que são a base para Functions e Procedures.
-- Abaixo, temos a estrutura de um bloco anônimo.

<<label>>
declare
    declaracao;
begin
    corpo do código;
    
end label;

-- Cada bloco possui duas sessões: declaração e corpo.
-- A sessão de declaração é opcional e é onde declaramos todas as variáveis usadas no corpo do código.
-- A sessão do corpo é obrigatória e é onde criamos os nossos códigos.
-- Em ambas as sessões é obrigatório o uso do ponto e vírgula ao final de cada instrução.

-- Abaixo, temos um exemplo de um bloco anônimo:
do $$
declare
    nome varchar(100);
    salario decimal;
    data_contratacao date;
begin
    nome := 'André';
    salario := 3500;
    data_contratacao := '25-10-2018';
    raise notice 'O funcionário % foi contratado em % e recebe um salário de R$ %.', nome, data_contratacao, salario;
end $$;

-- Aula 2 - Blocos Anônimos - Exemplos
-- Exemplo 1: Criando uma calculadora simples de valor vendido. Utilize as variáveis 'quantidade', 'preco', 'valor_vendido' e 'vendedor' para isso.
do $$
declare
    quantidade int := 50;
    preco decimal := 100;
    valor_vendido int; 
    vendedor varchar(100) := 'Bruna';
    
begin
    valor_vendido := quantidade * preco;
    
    raise notice 'O vendedor % vendeu o total de R$ %.', vendedor, valor_vendido;

end $$;

-- Exemplo 2: Quantos produtos têm o preço acima da média de preços?
do $$
declare
    media_preco decimal;
    qtd_produtos_acima_media int;

begin
    media_preco = (select avg(unit_price) from products);
    qtd_produtos_acima_media = (select count(*) from products where unit_price >= media_preco);
    
    raise notice 'A quantidade de produtos com preço acima da média é de: % produtos.', qtd_produtos_acima_media;
    
end $$;

