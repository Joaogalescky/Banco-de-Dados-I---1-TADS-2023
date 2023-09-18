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

create database Trabalho_3°Bimestre;
use Trabalho_3°Bimestre;

create table Partida(
	id_partida int not null auto_increment,
    jogador_id int not null,
    nome_jogo varchar (100) not null,
    fornecedor_jogo varchar (50) not null,
    hora_inicio time not null,
    hora_fim time not null,
    num_jogadores int not null,
    primary key (id_partida)
);

create table Jogador(
	id_jogador int not null auto_increment,
    nome_jogador varchar(50) not null,
    nivel_jogador int not null,
    primary key (id_jogador)
);

create table JogandoPartida(
	jogador_id int not null,
	partida_id int not null,
    horario_inicio time not null,
    horario_fim time null,
	constraint FK_Partida foreign key (partida_id) references Partida(id_partida),
    constraint FK_Jogador foreign key (jogador_id) references Jogador(id_jogador)
);

-- VIEW -- a)
create view VW_Jogador_Partida
as select Jogador.nome_jogador as Jogador, Partida.id_partida as Partida_Jogada
from Jogador inner join Partida
on Jogador.id_jogador = Partida.jogador_id;

select * from VW_Jogador_Partida

-- PROCEDURE -- b)
DELIMITER $
create procedure inserir_jogador (idj int)
BEGIN
	UPDATE Partida SET num_jogadores = num_jogadores + 1
    WHERE Partida.id_partida = idj;
END $
DELIMITER ;

-- TRIGGER -- c)
DELIMITER $
create trigger TGR_atualizar_jogadores after insert on JogandoPartida
for each row
BEGIN
	UPDATE Partida SET num_jogadores = num_jogadores
    WHERE id_partida = NEW.partida_id;
END $
DELIMITER ;

-- STORED PROCEDURE -- d)
/*STORED PROCEDURE: Explicação
	É um objeto de BD que contém um conjunto de comandos SQL que podem ser chamados e executados como uma única unidade lógica.
    "Encapsular" a lógica de atualização em uma unidade reutilizável no BD.
*/
DELIMITER $
create procedure finalizar_participação_jogador (
IN p_jogador_id int, -- Declara um parâmetro de entrada
IN p_partida_id int,
IN p_hora_saida time)
-- Utiliza-se esses parâmetros para atualizar a tabela JogandoPartida
BEGIN
	UPDATE JogandoPartida SET horario_fim = p_hora_saida
    WHERE jogador_id = p_jogador_id AND partida_id = p_partida_id;
END $
DELIMITER ;

-- TRIGGER -- e)
DELIMITER $
create trigger TGR_atualizar_jogadores_final_partida after update on JogandoPartida
for each row
BEGIN
	UPDATE Partida SET num_jogadores = num_jogadores - 1
    WHERE id_partida = NEW.partida_id;
END $
DELIMITER ;

-- insert
insert into Partida (nome_jogo, fornecedor_jogo, hora_inicio, hora_fim, num_jogadores, jogador_id) values
('Corinthians vs Bota Fogo', 'Adidas', '12:30:00', '14:00:00', 0, 1),
('Flamengo vs Internacional', 'Nike', '10:00:00', '11:20:00', 0, 2);

insert into Jogador (nome_jogador, nivel_jogador) values
('Jô', 11),
('Matheus', 9);

-- Inserir um jogador (com ID 1) em uma partida (com ID 1) com horário de entrada e saída
INSERT INTO JogandoPartida (partida_id, jogador_id, horario_inicio)
VALUES (1, 1, '12:30:00');

-- Inserir outro jogador (com ID 2) em outra partida (com ID 2) com horário de entrada e saída
INSERT INTO JogandoPartida (partida_id, jogador_id, horario_inicio)
VALUES (2, 2, '10:00:00');

-- select
select * from Partida;

select * from Jogador;

select * from JogandoPartida;

-- Chamando procedimento b)
CALL inserir_jogador(1);
CALL inserir_jogador(2);

-- Chamando procedimento d)
CALL finalizar_participação_jogador(1, 1, '13:30:00');
CALL finalizar_participação_jogador(2, 2, '11:45:00');
