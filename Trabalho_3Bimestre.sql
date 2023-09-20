-- João Vitor Campõe Galescky && João Victor Schmidt Leite

/* Instruções
Considere as seguintes tabelas e seus atributos:

Partida(id_partida,nome_jogo,fornecedor_jogo,hora_inicio,hora_fim,num_jogadores)

Jogador(id_jogador,nome_jogador,nivel_jogador)

JogandoPartida(id_jogador,id_partida,hora_entrada,hora_saida)

Crie estas tabelas e:

a)    Uma visão que mostre o nome do jogador e o jogo que ele participou; --> CERTO
b)    Um procedimento (store procedure) para INSERIR um jogador em uma partida; --> CERTO 
c)    Um gatilho (trigger) para atualizar o número de jogadores ao inserir um jogador em uma partida;
d)    Um procedimento para FINALIZAR a participação de um jogador em uma partida; --> CERTO
e)    Um gatilho (trigger) para atualizar o número de jogadores ao finalizar a participação de um jogador em uma partida. --> CERTO
*/

CREATE DATABASE Trabalho_3°Bimestre;
USE Trabalho_3°Bimestre;

CREATE TABLE Partida(
	id_partida int not null auto_increment,
    nome_jogo varchar (100) not null,
    fornecedor_jogo varchar (50) not null,
    hora_inicio time not null,
    hora_fim time not null,
    num_jogadores int not null,
    primary key (id_partida)
);

CREATE TABLE Jogador(
	id_jogador int not null auto_increment,
    nome_jogador varchar(50) not null,
    nivel_jogador int not null,
    primary key (id_jogador)
);

CREATE TABLE JogandoPartida(
	jogador_id int not null,
	partida_id int not null,
    horario_inicio time null,
    horario_fim time null,
	constraint FK_Partida foreign key (partida_id) references Partida(id_partida),
    constraint FK_Jogador foreign key (jogador_id) references Jogador(id_jogador)
);

CREATE VIEW VW_Jogador_Partida AS SELECT
Jogador.nome_jogador AS Jogador,
Partida.id_partida AS ID_Partida,
Partida.nome_jogo AS Partida,
Partida.hora_inicio AS Horario_de_inicio,
Partida.hora_fim AS Horario_de_terminio
FROM Jogador INNER JOIN JogandoPartida ON Jogador.id_jogador = JogandoPartida.jogador_id
INNER JOIN Partida ON JogandoPartida.partida_id = Partida.id_partida

-- PROCEDURE -- b)
DELIMITER $
CREATE PROCEDURE inserir_jogador (
-- Declara um parâmetro de entrada
-- Utiliza-se esses parâmetros para atualizar a tabela JogandoPartida
IN i_jogador_id int,
IN i_partida_id int,
IN i_hora_entrada time)
BEGIN
	IF NOT EXISTS (
		SELECT * FROM JogandoPartida
        WHERE jogador_id = i_jogador_id AND partida_id = i_partida_id
    ) THEN
		INSERT INTO JogandoPartida (jogador_id, partida_id, horario_inicio) VALUES
		(i_jogador_id, i_partida_id, i_hora_entrada);
    END IF;
END $
DELIMITER ;

-- TRIGGER -- c)
DELIMITER $
CREATE TRIGGER TGR_atualizar_jogadores AFTER INSERT ON JogandoPartida
FOR EACH ROW
BEGIN
	UPDATE Partida SET num_jogadores = num_jogadores + 1
    WHERE id_partida = NEW.partida_id;
END $
DELIMITER ;

-- STORED PROCEDURE -- d)
/*STORED PROCEDURE: Explicação
	É um objeto de BD que contém um conjunto de comandos SQL que podem ser chamados e executados como uma única unidade lógica.
    "Encapsular" a lógica de atualização em uma unidade reutilizável no BD.
*/
DELIMITER $
CREATE PROCEDURE finalizar_participação_jogador (
IN p_jogador_id int,
IN p_partida_id int,
IN p_hora_saida time)
BEGIN
-- Verificar se o jogador esta participando da partida
    IF EXISTS (
        SELECT * FROM JogandoPartida
        WHERE jogador_id = p_jogador_id AND partida_id = p_partida_id
    ) THEN
        -- Atualiza o horário de saída do jogador na partida
        UPDATE JogandoPartida
        SET horario_fim = p_hora_saida
        WHERE jogador_id = p_jogador_id AND partida_id = p_partida_id;
        -- Atualiza o número de jogadores na partida
    END IF;
END $
DELIMITER ;

-- TRIGGER -- e)
DELIMITER $
CREATE TRIGGER TGR_atualizar_jogadores_final_partida AFTER UPDATE ON JogandoPartida
FOR EACH ROW
BEGIN
	UPDATE Partida SET num_jogadores = num_jogadores - 1
    WHERE id_partida = NEW.partida_id;
END $
DELIMITER ;

-- insert
INSERT INTO Partida (nome_jogo, fornecedor_jogo, hora_inicio, hora_fim, num_jogadores) values
('Corinthians vs Bota Fogo', 'Adidas', '12:30:00', '14:00:00', 0),
('Flamengo vs Internacional', 'Nike', '10:00:00', '11:20:00', 0);

INSERT INTO Jogador (nome_jogador, nivel_jogador) values
('Jô', 11),
('Matheus', 9),
('Pedro', 10),
('Guilherme', 5);

-- select
SELECT * FROM VW_Jogador_Partida;

SELECT * FROM Partida;

SELECT * FROM Jogador;

SELECT * FROM JogandoPartida;

-- Chamando procedimento b) - inserir jogadores
CALL inserir_jogador(1, 1, '13:30:00');
CALL inserir_jogador(2, 1, '13:00:00');
CALL inserir_jogador(3, 2, '10:00:00');
CALL inserir_jogador(4, 2, '10:50:00');

-- Chamando procedimento d) - finalizar a participação dos jogadores
CALL finalizar_participação_jogador(1, 1, '14:00:00');
CALL finalizar_participação_jogador(2, 1, '13:45:00');
CALL finalizar_participação_jogador(3, 2, '11:00:00');
CALL finalizar_participação_jogador(4, 2, '11:20:00');
