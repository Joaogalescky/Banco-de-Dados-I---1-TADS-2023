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
("João Pedro", "45984563215");

select * from USUARIO;

create table AUTOR(
	id_Autor int not null auto_increment,
    Nome varchar (40) not null,
    Sobrenome varchar (40) not null,
    Nacionalidade varchar (40) null,
    Estilo varchar (40) null,
    primary key (id_autor)
);

insert into AUTOR(Nome, Sobrenome, Nacionalidade, Estilo) values
("Machado", "de Assis", "brasileira", "romance"),
("Karl", "Marx", "alemã", "filósofia"),
("Max", "Weber", "alemã", "sociologia"),
("Adam", "Smith", "escocesa", "filósofia"),
("Émile", "Durkheim", "francesa", "sociologia");

select * from AUTOR;

create table LIVROS(
	id_Livro int not null auto_increment,
    Titulo varchar (100) not null,
    Estilo varchar (50) not null,
    Ano int (4) not null,
    Disponibilidade varchar (25) not null,
    id_Autor int not null,
	primary key (id_Livro),
	constraint FK_Autor foreign key (id_Autor) references AUTOR(id_Autor)
);

insert into LIVROS(Titulo, Ano, Estilo, id_Autor, Disponibilidade) values
("Dom Casmurro", 1899, "romance", 1, "disponivel"),
("Memórias Póstulas de Brás Cubas", 1881, "romance", 1, "disponivel"),
("O Capital", 1887, "filósofia", 2, "disponivel"),
("Uma Contribuição para a Crítica da Economia Política", 1850, "filósofia", 2, "disponivel"),
("A Ética Protestante", 1904, "filósofia", 3, "disponivel"),
("O Político e o Cientista", 1919, "filósofia", 3, "disponivel"),
("A riqueza das nações", 1776, "filósofia", 4, "disponivel"),
("A mão invisível", 1759, "filósofia", 4, "disponivel"),
("Da Divisão do Trabalho Social", 1893, "sociologia", 5, "disponivel"),
("As Regras do Método Sociológico", 1895, "sociologia", 5, "disponivel");

select * from LIVROS;

create table EMPRESTIMOS(
	id_Emprestimo int not null auto_increment,
    Data_emprestimo date not null,
    Data_devolucao date null,
    idUsuario int not null,
    idLivro int not null,
    primary key (id_Emprestimo),
    constraint FK_Usuario_Emprestimo foreign key (idUsuario) references USUARIO (id_Usuario),
    constraint FK_Livro_Emprestimo foreign key (idLivro) references LIVROS (id_Livro)
);

insert into EMPRESTIMOS (Data_emprestimo, idUsuario, idLivro) values
(2023-08-25, 1, 2);

select * from EMPRESTIMOS;

-- Gatilho (Trigger) status "emprestado"
DELIMITER $ 
create trigger TGR_Emprestimo_Emprestado after insert
on EMPRESTIMOS
for each row
begin
	update LIVROS set Disponibilidade = "emprestado"
    where id_Livro = NEW.EMPRESTIMOS; 
end$
DELIMITER ;

-- Gatilho (Trigger) status "disponibilidade"
DELIMITER $
create trigger TGR_Emprestimo_Disponivel after insert
on EMPRESTIMOS
for each row
begin
	update LIVROS set Disponibilidade = "disponivel"
    where Data_devolucao = NEW.EMPRESTIMOS;
    -- Ideia --> Alterar de "emprestado" para "disponivel" quando for detectado o preenchimento da Data_devolucao
end$
DELIMITER ;

