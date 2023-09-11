-- João Vitor Campõe Galescky && João Victor Schmidt Leite

/* Instruções
Considere as seguintes tabelas e seus atributos:

Partida(id_partida,nome_jogo,fornecedor_jogo,hora_inicio,hora_fim,num_jogadores)

Jogador(id_jogador,nome_jogador,nivel_jogador)

JogandoPartida(id_jogador,id_partida,hora_entrada,hora_saida)

Crie estas tabelas e:

a)    Uma visão que mostre o nome do jogador e o jogo que ele participou;
b)    Um procedimento (store procedure) para INSERIR um jogador em uma partida;
c)    Um gatilho (trigger) para atualizar o número de jogadores ao inserir um jogador em uma partida;
d)    Um procedimento para FINALIZAR a participação de um jogador em uma partida;
e)    Um gatilho (trigger) para atualizar o número de jogadores ao finalizar a participação de um jogador em uma partida.
*/

create database Trabalho_3°Bimestre;
use Trabalho_3°Bimestre;

create table Partida(
	id_partida int not null auto_increment,
    nome_jogo varchar (50) not null,
    fornecedor_jogo varchar (50) not null,
    hora_inicio time not null,
    hora_fim time not null,
    num_jogadores int not null,
    jogador_id int not null,
    primary key (id_partida)
);

create table Jogador(
	id_jogador int not null auto_increment,
    nome_jogador varchar(50) not null,
    nivel_jogador int not null,
    primary key (id_jogador)
);

create table JogandoPartida(
	constraint FK_Partida foreign key (partida_id) references Partida(id_partida),
    constraint FK_Jogador foreign key (jogador_id) references Jogador(id_jogador),
	constraint FK_Hora_Inicio foreign key (horario_inicio) references Partida(hora_inicio),
	constraint FK_Hora_Fim foreign key (horario_fim) references Partida(hora_fim)
);

-- VIEW -- a)
create view VW_Jogador_Partida
as select Jogador.nome_jogador as Jogador, Partida.id_partida as Partida_Jogada
from Jogador inner join Partida
on Jogador.id_jogador = Partida.jogador_id

-- PROCEDURE -- b)
DELIMITER $
create procedure inserir_jogador (idj int)
BEGIN
	UPDATE Partida SET num_jogadores = num_jogadores + 1
    WHERE Partida.id_partida = idj;
END $
DELIMITER ;

-- Chamando procedure b)
CALL inserir_jogador(1);

-- TRIGGER -- c)
DELIMITER $
create trigger TGR_atualizar_jogadores after insert
on Partida
for each row
BEGIN
	update Partida set num_jogadores
    where id.Partida = 
END $
DELIMITER ;

-- PROCEDURE -- d)

-- TRIGGER -- e)

