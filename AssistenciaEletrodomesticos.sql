/*Emerson Bottega da Silva & João Galescky - 1°TADS - BDI */

create database assistencia;
use assistencia;

create table profissional (
	idProfissional int not null auto_increment,
	nomeProfissional varchar(100) not null,
    enderecoProfissional varchar(100) not null,
    emailProfissional varchar(100) not null,
	primary key(idProfissional)
);

create table cliente (
	idCliente int not null auto_increment,
	nomeCliente varchar(100) not null,
    enderecoCliente varchar(100) not null,
    emailCliente varchar(100) not null,
	primary key(idCliente)
);

create table telefoneprofissional (
	idTelefone_profissional int(4) not null auto_increment,
    dddTelefone_profissional varchar(2) not null,
    numeroTelefone_profissional varchar(9) not null,
    idProf int(4) not null,
    constraint Assistencia_Profissional foreign key(idProf) references profissional(idProfissional),
    primary key(idTelefone_profissional)
);

create table telefonecliente (
	idTelefone_cliente int(4) not null auto_increment,
    dddTelefone_cliente varchar(2) not null,
    numeroTelefone_cliente varchar(9) not null,
    idClient int(4) not null,
    constraint Assistencia_Cliente foreign key(idClient) references cliente(idCliente),
    primary key(idTelefone_cliente)
);

create table eletrodomestico (
	idEletrodomestico int not null auto_increment,
	marca_eletrodomestico varchar(50) not null,
	voltagem_eletrodomestico varchar(10) not null,
	modelo_eletrodomestico varchar(50) not null,
    idEletro int(4) not null,
    constraint Assistencia_Eletrodomestico foreign key(idEletro) references cliente(idCliente),
    primary key(idEletrodomestico)
);

create table servicos (
	idServico int not null auto_increment,
    garantia_servico date not null,
    entrada_servico date not null,
    saida_servico date not null,
    idServ int not null,
	constraint Assistencia_Servico foreign key(idServ) references eletrodomestico(idEletrodomestico),
    idProfissional_Servico int not null,
    constraint Assistencia_ServicoProfissional foreign key(idProfissional_Servico) references profissional(idProfissional),
    primary key(idServico)
);

create table notafiscal (
	idNotafiscal int not null auto_increment,
    valor_notafiscal float(10),
    data_geracao date not null,
    idNota int not null,
	constraint Assistencia_Notafiscal foreign key(idNota) references servicos(idServico),
	constraint Assistencia_Notafiscal_cliente foreign key(idNota) references cliente(idCliente),
    primary key(idNotafiscal)
);