-- Banco de Dados I
-- Aula sobre gatilho

create database aula_gatilhos;
use aula_gatilhos;

create table Produtos(
	Referencia int not null,
    Descricao varchar(50) not null,
    Estoque int not null default 0,
    primary key (Referencia)
);

insert into Produtos (Referencia, Descricao, Estoque) values
(1, "Feijão", 10),
(2, "Arroz", 5),
(3, "Farinha", 15);

select * from Produtos;

create table ItensVenda(
	Venda int not null,
    Produto int not null,
    Quantidade int not null,
    primary key (Venda),
    constraint FK_Venda_Produto foreign	key (Produto) references Produtos(Referencia)
);

-- Delimitador - inicio
-- criando gatilho
DELIMITER $ 
create trigger TGR_Itens_Venda_Insert after insert
on ItensVenda
for each row -- para cada linha
begin
	update Produtos set Estoque = Estoque - NEW.Quantidade
    -- atualize a tabela Produtos onde defina que Estoque = Estoque - NOVA.Quantidade (da tabela venda)
    where Referencia = NEW.Produto; 
    -- onde Referencia = NOVO.Produto
end$
DELIMITER ; 
-- Delimitador - fim

Insert into ItensVenda(Venda, Produto, Quantidade) values
(1,1,3);

select * from Produtos;

DELIMITER $
create trigger TGR_Itens_Venda_Delete after delete
on ItensVenda
for each row 
begin
	update Produtos set Estoque = Estoque + OLD.Quantidade
    where Referencia = OLD.Produto;
end$
DELIMITER ;

SET SQL_SAFE_UPDATES=0;
delete from ItensVenda where Venda = 1 and Produto = 1;

select * from Produtos;