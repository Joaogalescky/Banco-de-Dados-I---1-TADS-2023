-- By João Vitor Campõe Galescky
CREATE DATABASE Exercicio_Funcoes;
USE Exercicio_Funcoes;

-- Secção CREATE Start
CREATE TABLE Produto(
id_produto int not null auto_increment,
nome_produto varchar(40) not null,
preco_produto float (2) not null,
primary key (id_produto)
);

CREATE TABLE Pedido(
id_pedido int(3) not null,
nome_cliente varchar(40) not null,
telefone_cliente varchar(20) not null,
produto_id int not null,
primary key (id_pedido)
);
-- Secção CREATE End

-- Secção INSERT Start
INSERT INTO Produto(nome_produto, preco_produto) VALUES
('feijão', 6.99),
('arroz', 5.39),
('macarrão', 3.49),
('açucar', 11.49);

INSERT INTO Pedido(id_pedido, nome_cliente, telefone_cliente, produto_id) VALUES
(301, 'João', '45-33445566', 3),
(409, 'Maria', '45-32214567', 1),
(665, 'Fabio', '45-33114564', 7);

-- Secção SELECT Start
SELECT * FROM Produto;
SELECT * FROM Pedido;

SELECT * FROM Produto,Pedido
WHERE Produto.id_produto = Pedido.produto_id;

SELECT * FROM Produto JOIN Pedido ON
Produto.id_produto = Pedido.produto_id;

SELECT* FROM Produto LEFT JOIN Pedido ON
Produto.id_produto = Pedido.produto_id;

SELECT * FROM Produto RIGHT JOIN Pedido ON
Produto.id_produto = Pedido.produto_id;

SELECT * FROM Produto LEFT JOIN Pedido ON
Produto.id_produto = Pedido.produto_id
UNION
SELECT * FROM Produto RIGHT JOIN Pedido ON
Produto.id_produto = Pedido.produto_id;
-- Secção SELECT End