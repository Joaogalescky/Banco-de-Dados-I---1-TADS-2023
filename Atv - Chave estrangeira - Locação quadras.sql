/*Emerson Bottega da Silva & João Galescky - 1° TADS - BDI*/
create database
locacao_quadras;
use locacao_quadras;
create table quadra (
idQuadra int(6) not null
auto_increment,
descricao_quadra varchar (200) not null,
preco_aluguel float(2) not null,
primary key (idQuadra)
);
create table clientes (
idCliente int(6) not null
auto_increment,
nome_cliente varchar(100) not null,
email_cliente varchar(50) not null,
dddcliente varchar(2) not null,
numero_cliente varchar(9) not null,
primary key
(idCliente)
);
create table reserva (
idReserva int (6) not null auto_increment,
data_reservada date not null,
horario_reservado time not null,
horario_entrada time
not null,
horario_saida time not null,
preço_total float(2) not null,
primary key
(idReserva),
idQuadra_reserva int(6) not null,
constraint quadra_reserva foreign key
(idQuadra_reserva) references quadra (idQuadra),
idCliente_reserva int(6) not
null,
constraint cliente_reserva foreign key (idCliente_reserva) references clientes
(idCliente)
);