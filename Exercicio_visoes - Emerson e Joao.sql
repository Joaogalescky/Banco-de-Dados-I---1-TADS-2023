-- Made by Emerson Bottega da Silva & João Vitor Campõe Galescky

create database Exercicio_visoes;
use Exercicio_visoes;

create table cliente(
	id_cliente int not null auto_increment,
    nome_sobrenome varchar (100) not null,
    endereco varchar (100) null,
    telefone int (11) null,
    email varchar (30) not null,
    primary key (id_cliente)
);

insert into cliente (nome_sobrenome, endereco, telefone, email) values
("Pedro da Silva", "Rua Panáma", 45957413257, "pedro_silva@gmail.com"),
("Matheus dos Santos", "Rua Ipanema", 45988756432, "matheus_santos@hotmail.com"),
("Marcos Pereira", "Rua Roxa", 45966845743, "marcos.pereira@ymail.com"); 

create table equipamento(
	id_equipamento int not null auto_increment,
    equipamento varchar (50) not null,
    quantidade int (4) not null,
    --
    --
    primary key (id_equipamento)
);

-- insert into

create table manutencao(
	id_manutencao int not null auto_increment,
	status_situacao varchar (50) not null
	--
	--
);

-- insert into

