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
d)    Um procedimento para FINALIZAR a participação de um jogador em uma partida;
e)    Um gatilho (trigger) para atualizar o número de jogadores ao finalizar a participação de um jogador em uma partida.
*/

create database Trabalho_3°Bimestre;
use Trabalho_3°Bimestre;

create table Partida(
	id_partida int not null auto_increment,
    nome_jogo varchar (100) not null,
    fornecedor_jogo varchar (50) not null,
    hora_inicio time not null,
    hora_fim time not null,
    num_jogadores int not null,
    jogador_id int not null,
    primary key (id_partida)
);

insert into Partida (nome_jogo, fornecedor_jogo, hora_inicio, hora_fim, num_jogadores, jogador_id) values
('Corinthians vs Bota Fogo', 'Adidas', '12:30:00', '14:00:00', 1, 1);

select * from Partida;

create table Jogador(
	id_jogador int not null auto_increment,
    nome_jogador varchar(50) not null,
    nivel_jogador int not null,
    primary key (id_jogador)
);

insert into Jogador (nome_jogador, nivel_jogador) values
('Jô', 11);

select * from Jogador;

create table JogandoPartida(
	partida_id int not null,
    jogador_id int not null,
    horario_inicio time not null,
    horario_fim time not null,
	constraint FK_Partida foreign key (partida_id) references Partida(id_partida),
    constraint FK_Jogador foreign key (jogador_id) references Jogador(id_jogador)
);

insert into JogandoPartida(partida_id, jogador_id, horario_inicio, horario_fim) values
(1, 1, '12:30:00', '14:00:00');

select * from JogandoPartida;

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

-- Chamando procedimento b)
CALL inserir_jogador(1);

-- TRIGGER -- c)
DELIMITER $
create trigger TGR_atualizar_jogadores after insert on JogandoPartida
for each row
BEGIN
	UPDATE Partida SET num_jogadores = num_jogadores + 1
    WHERE id.partida = NEW.partida_id;
    -- Atualize a tabale partida no campo num_jogadores, onde num_jogadores recebe a si mesmo + 1
    -- Onde id.partida da tabela Partida = Nova inserção da partida_id da tabela JogandoPartida
END $
DELIMITER ;

-- STORED PROCEDURE -- d)
/*STORED PROCEDURE: Explicação
	É um objeto de BD que contém um conjunto de comandos SQL que podem ser chamados e executados como uma única unidade lógica.
    "Encapsular" a lógica de atualização em uma unidade reutilizável no BD.
*/
DELIMITER $
create procedure finalizar_participação_jogador (
IN p_id_jogador int, -- Declara um parâmetro de entrada
IN p_id_partida int,
IN p_hora_saida time)
-- Utiliza-se esses parâmetros para atualizar a tabela JogandoPartida
BEGIN
	UPDATE JogandoPartida SET horario_fim = p_hora_saida
    WHERE jogador_id = p_id_jogador AND partida_id = p_id_partida;
END $
DELIMITER ;

-- Chamando procedimento d)
CALL finalizar_participação_jogador(1, 1, '14:30:00');

-- TRIGGER -- e)
DELIMITER $
create trigger TGR_atualizar_jogadores_final_partida after update on JogandoPartida
for each row
BEGIN
	DECLARE num_jogadores_na_partida int;
    -- num_jogadores_na_partida variavel para armazenar o número de jogadores na partida após a atualização
    SELECT COUNT(*) INTO num_jogadores_na_partida
    FROM JogandoPartida
    WHERE partida_id = NEW.partida_id;
    
    UPDATE Partida SET num_jogadores = num_jogadores_na_partida
    WHERE id_partida = NEW.partida_id;
END $
DELIMITER ;