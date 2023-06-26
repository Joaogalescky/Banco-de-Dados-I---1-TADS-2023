/*Emerson Bottega da Silva & João Galescky - 1° TADS - BDI*/
create database
assistencia_tecnica;
use assistencia_tecnica;
create table pecas (
idPecas int(6) not null
auto_increment,
quantidade_pecas int(5) not null,
descricao_peca varchar(200) not
null,
valor_peca float(2) not null,
primary key (idPecas)
);
create table tecnico
(
idTecnico int(6) not null auto_increment,
nome_tecnico varchar(100) not null,
email_tecnico varchar(50) not null,
dddtecnico varchar(2) not null,
numero_tecnico
varchar(9) not null,
primary key (idTecnico)
);
create table peca_cedida (
idPeca_cedida
int(6) not null auto_increment,
data_retirada date not null,
primary key
(idPeca_cedida),
idPeca_utilizada int(6) not null,
constraint peca_utilizada foreign key
(idPeca_utilizada) references pecas (idPecas),
idTecnico_retirada int(6) not
null,
constraint tecnico_retirou foreign key (idTecnico_retirada) references tecnico
(idTecnico)
);
create table peca_retornada ( /*Tabela criada para retorno da
peça*/
idPeca_retorno int(6) not null auto_increment,
data_retornada date null,
idPeca_servico int(6) null, /*Número do servico caso utilizado*/
primary key
(idPeca_retornada),
idPeca_devolvida int(6) null, /*Número da peça devolvida*/
constraint peca_devolvida foreign key (idPeca_devolvida) references pecas (idPecas),
idTecnico_devolucao int(6) null, /*Número de devolução da peça pelo técnino*/
constraint tecnico_devolveu_foreing foreign key (idTecnico_devolucao) references tecnico
(idTecnino)
);