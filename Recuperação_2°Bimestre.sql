create database loja;
use loja;

create table cliente(
id_cliente int (4) not null auto_increment,
cpf varchar (15) not null,
nome varchar (100) not null,
endereco varchar (150) not null,
primary key(id_cliente)
);

insert into cliente(cpf, nome, endereco) values ("14578975431", "Pedro Silva", "Rua das Bandeiras 759");

create table telefone(
id_telefone int (4) not null auto_increment,
ddd_celular varchar (2) not null,
n_celular varchar (9) not null,
id_clientela int (4) not null,
constraint cliente_telefone foreign key (id_clientela) references cliente (id_cliente),
primary key (id_telefone)
);

insert into telefone(id_clientela, ddd_celular, n_celular) values("0001", "45", "999456732");

create table produto(
id_produto int (4) not null auto_increment,
categoria varchar (30) not null,
nome_produto varchar (45) not null,
preco_produto float (2) not null,
quantidade_produto int (3) null,
primary key (id_produto)
);

insert into produto(categoria, nome_produto, preco_produto, quantidade_produto) values ("padaria", "pão", 10.50, 15);
insert into produto(categoria, nome_produto, preco_produto, quantidade_produto) values ("açougue", "linguiça", 12.00, 20);
insert into produto(categoria, nome_produto, preco_produto, quantidade_produto) values ("limpeza", "detergente", 3.50, 10);

 create table venda(
id_venda int (4) not null auto_increment,
data_venda date not null,
id_compra_cliente int (4) not null,
id_compra_produto int (4) not null,
constraint FK_cliente_compra foreign key (id_compra_cliente) references cliente(id_cliente),
constraint FK_produto_compra foreign key (id_compra_produto) references produto(id_produto),
primary key (id_venda)
);

insert into venda(data_venda, id_compra_cliente, id_compra_produto) values ("2023-07-28", 1, 2);
insert into venda(data_venda, id_compra_cliente, id_compra_produto) values ("2023-07-27", 1, 3);
insert into venda(data_venda, id_compra_cliente, id_compra_produto) values ("2023-07-29", 1, 1);

select categoria, nome_produto, preco_produto, quantidade_produto from produto order by quantidade_produto DESC;
