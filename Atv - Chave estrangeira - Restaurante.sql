/*Emerson Bottega da Silva & João Galescky - 1° TADS - BDI*/
create database
restaurante;
use restaurante;
create table entregadores (
idEntregadores int(6) not null
auto_increment,
nome_entregador varchar(100) not null,
email_entregador varchar(50) not
null,
dddTelefone varchar(2) not null,
numero_Telefone varchar(9) not null,
primary
key (idEntregadores)
);
create table pedido (
idPedido int(6) not null auto_increment,
descricao_pedido varchar(200) not null,
valor_pedido float(2) not null,
primary key
(idPedido)
);
create table frete (
idFrete int(6) not null auto_increment,
valor_frete
float(2) not null,
primary key (idFrete),
idEntregadorPedido int(4) not null,
idPedidoEfetuado int(4) not null,
constraint entregador_pedido foreign key
(idEntregadorPedido) references entregadores (idEntregadores),
constraint pedido_efetuado
foreign key (idPedidoEfetuado) references pedido (idPedido)
);