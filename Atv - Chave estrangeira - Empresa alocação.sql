/*Emerson Bottega da Silva & João Galescky - 1° TADS - BDI*/
create database
empresa_alocacao;
use empresa_alocacao;
create table funcionario (
idFuncionario int(6) not
null auto_increment,
nome_funcionario varchar(100) not null,
email_funcionario varchar(50)
not null,
endereco_funcionario varchar(100) not null,
cargo_funcionario varchar(50) not
null,
primary key (idFuncionario)
);
create table setor (
idSetor int(6) not null
auto_increment,
nome_setor varchar(50) not null,
idAlocacao int(4) not null,
constraint funcionario_alocado foreign key (idAlocacao) references funcionario
(idFuncionario),
primary key (idSetor)
);