/*
MOD-21-SEQUENCES
*/
-- V. SEQUENCES

-- O que �?
-- Uma sequ�ncia (Sequence) � um objeto que utilizamos para cria��o de n�meros 
-- sequenciais autom�ticos. S�o usados especialmente para gerar valores sequenciais
-- �nicos para as chaves prim�rias das tabelas.

-- Dessa forma, n�o precisamos ficar preenchendo a sequ�ncia de ids manualmente (como fizemos
-- at� ent�o), podemos gerar automaticamente por meio de uma sequence.

/* Sintaxe
*
CREATE SEQUENCE nome_sequencia
AS tipo
START WITH n
INCREMENT BY n
MAXVALUE n | NO MAXVALUE
MINVALUE n | NO MINVALUE
CYCLE | NO CYCLE;       -- quando atinge o valor m�ximo, pode ou n�o voltar do come�o

*/

-- Crie uma sequ�ncia para o id_cliente

CREATE SEQUENCE clientes_seq
AS INT
START WITH 1
INCREMENT BY 1
MAXVALUE 9999999
NO CYCLE

-- Pr�ximo valor da sequ�ncia(Executar varias vezes e mostra a prox sequencia)
SELECT NEXT VALUE FOR clientes_seq

-- Excluir uma sequence
DROP SEQUENCE clientes_seq

-- ********************************************************
-- Usando a sequence na pr�tica

-- Crie uma sequ�ncia para o id_projeto
CREATE SEQUENCE projetos_seq
AS INT
START WITH 1
INCREMENT BY 1
NO MAXVALUE
NO CYCLE

CREATE TABLE dProjeto(
	id_projeto INT,
	nome_projeto VARCHAR(100) NOT NULL,
	CONSTRAINT dareas_id_area_pk PRIMARY KEY(id_projeto)
)

SELECT * FROM dProjeto

INSERT INTO dProjeto(id_projeto, nome_projeto) VALUES
	(NEXT VALUE FOR projetos_seq, 'Planejamento Estrat�gico'),
	(NEXT VALUE FOR projetos_seq, 'Desenvolvimento de App'),
	(NEXT VALUE FOR projetos_seq, 'Plano de Neg�cios'),
	(NEXT VALUE FOR projetos_seq, 'Visualiza��o 3D')

SELECT * FROM dProjeto

INSERT INTO dProjeto(id_projeto, nome_projeto) VALUES
	(NEXT VALUE FOR projetos_seq, 'Mapeamento de Processos')

SELECT * FROM dProjeto

