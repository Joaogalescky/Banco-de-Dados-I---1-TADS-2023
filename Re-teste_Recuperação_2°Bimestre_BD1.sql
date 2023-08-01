create database teste;
use teste;

-- criação de tabelas
create table cliente(
id_cliente int not null auto_increment,
nome varchar (100) not null,
telefone varchar(20) not null,
primary key (id_cliente)
);

create table produto (
id_produto int not null auto_increment,
nome varchar (100) not null,
quantidade_estoque int (25) not null,
primary key (id_produto)
);

create table venda (
id_venda int not null auto_increment,
cliente_id int not null,
produto_id int not null,
quantidade int not null,
data_venda date not null,
foreign key (cliente_id) references cliente(id_cliente),
foreign key (produto_id) references produto(id_produto),
primary key (id_venda)
);

-- inserção de dados
insert into cliente (nome, telefone) values
("Fulano", "(XX) XXXXX-XXXX");

insert into produto (nome, quantidade_estoque) values
("Produto A", 50),
("Produto B", 15),
("Produto C", 25);

insert into venda (cliente_id, produto_id, quantidade, data_venda) values 
(1, 1, 2, "2023-07-30"),
(1, 2, 4, "2023-07-28"),
(1, 3, 7, "2023-08-01");

-- consultas
-- 1. Listar nome e telefone dos clientes
select nome, telefone from cliente;
-- Ou, select * from cliente;

-- 2. Listar o nome do produto e quantidade em estoque, mostrando primeiro os produtos com maior quantidade em estoque
select nome, quantidade_estoque from produto order by quantidade_estoque desc;

-- 3. Listar o nome dos produtos que o cliente "Fulano" comprou
select p.nome from produto p
inner join venda v on p.id_produto = v.produto_id
inner join cliente c on v.cliente_id = c.id_cliente
where c.nome = "Fulano";

drop database teste;