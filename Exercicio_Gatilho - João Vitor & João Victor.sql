-- João Vitor Campõe Galescky && João Victor Schmidt Leite

create database Aula_Exercicio_Gatilho;
use Aula_Exercicio_Gatilho;

create table USUARIO(
	id_Usuario int not null auto_increment,
    Nome_usuario varchar (100) not null,
    Telefone varchar (12) not null,
    primary key (id_Usuario)
);

insert into USUARIO(Nome_usuario, Telefone) values
('João Pedro', '45984563215');

select * from USUARIO;

create table AUTOR(
	id_Autor int not null auto_increment,
    Nome varchar (40) not null,
    Sobrenome varchar (40) not null,
    Nacionalidade varchar (40) null,
    Estilo varchar (40) null,
    primary key (id_Autor)
);

insert into AUTOR(Nome, Sobrenome, Nacionalidade, Estilo) values
('Machado', 'de Assis', 'brasileira', 'romance'),
('Karl', 'Marx', 'alemã', 'filósofia'),
('Max', 'Weber', 'alemã', 'sociologia'),
('Adam', 'Smith', 'escocesa', 'filósofia'),
('Émile', 'Durkheim', 'francesa', 'sociologia');

select * from AUTOR;

create table LIVROS(
	id_Livro int not null auto_increment,
    Titulo varchar (100) not null,
    Estilo varchar (50) not null,
    Ano int not null,
    Disponibilidade varchar (25) not null,
    Autor_id int not null,
	primary key (id_Livro),
	constraint FK_Autor foreign key (Autor_id) references AUTOR(id_Autor)
);

insert into LIVROS(Titulo, Ano, Estilo, Autor_id, Disponibilidade) values
('Dom Casmurro', 1899, 'romance', 1, 'disponivel'),
('Memórias Póstulas de Brás Cubas', 1881, 'romance', 1, 'disponivel'),
('O Capital', 1887, 'filósofia', 2, 'disponivel'),
('Uma Contribuição para a Crítica da Economia Política', 1850, 'filósofia', 2, 'disponivel'),
('A Ética Protestante', 1904, 'filósofia', 3, 'disponivel'),
('O Político e o Cientista', 1919, 'filósofia', 3, 'disponivel'),
('A riqueza das nações', 1776, 'filósofia', 4, 'disponivel'),
('A mão invisível', 1759, 'filósofia', 4, 'disponivel'),
('Da Divisão do Trabalho Social', 1893, 'sociologia', 5, 'disponivel'),
('As Regras do Método Sociológico', 1895, 'sociologia', 5, 'disponivel');

select * from LIVROS;

create table EMPRESTIMOS(
	id_Emprestimo int not null auto_increment,
    Data_emprestimo date not null,
    Data_devolucao date null,
    Usuario_id int not null,
    Livro_id int not null,
    primary key (id_Emprestimo),
    constraint FK_Usuario_Emprestimo foreign key (Usuario_id) references USUARIO (id_Usuario),
    constraint FK_Livro_Emprestimo foreign key (Livro_id) references LIVROS (id_Livro)
);

-- Gatilho (Trigger) status "emprestado"
DELIMITER $ 
create trigger TGR_Emprestimo_Atualizar_Status_Emprestado after insert
on EMPRESTIMOS
for each row
begin
	update LIVROS set Disponibilidade = 'emprestado'
    where id_Livro = NEW.Livro_id;
    -- NEW.idLivro está referenciando o livro que está sendo emprestado
end$
DELIMITER ;

-- Gatilho (Trigger) status "disponivel"
DELIMITER $
create trigger TGR_Emprestimo_Atualizar_Status_Disponivel after update
on EMPRESTIMOS
for each row
begin
	if NEW.Data_devolucao is not null then
    -- Se a Data_devolucao não estiver vazio, atualize o campo Disponibilidade da tabela LIVROS para 'disponivel'
    -- onde id_Livro (LIVROS) = Livro_id (EMPRESTIMO)
		update LIVROS set Disponibilidade = 'disponivel'
		where id_Livro = NEW.Livro_id;
    end if;
end$
DELIMITER ;

-- Inserção de empréstimo
insert into EMPRESTIMOS (Data_emprestimo, Usuario_id, Livro_id) values
('2023-08-25', 1, 2);

select * from EMPRESTIMOS;

-- Atualização da data de devolução
update EMPRESTIMOS set Data_devolucao = '2023-09-01'
where Usuario_id = 1 and Livro_id = 2;

select * from LIVROS;