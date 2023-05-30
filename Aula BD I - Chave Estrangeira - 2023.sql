create database biblioteca;

use biblioteca;
 
create table autor(
   idAutor int not null auto_increment,
    nomeAutor varchar(100) not null,
    paisOrigem varchar(100) not null,
    primary key(idAutor)
);

create table usuario(
   idUsuario int not null auto_increment,
    nomeUsuario varchar(100) not null,
    cpf varchar(11) not null,
    email varchar(100) not null,
    primary key(idUsuario)
);

create table livro(
   idLivro int not null auto_increment,
    tituloLivro varchar(100) not null,
    anoLivro int(4) not null,
    numPaginas int not null,
    idAut int not null,
    primary key(idLivro),
    constraint FK_Autor foreign key(idAut) references autor(idAutor)
);

create table emprestimo(
   idEmprestimo int not null auto_increment,
    dataEmprestimo date not null,
    dataDevolucao date not null,
    idLivro int not null,
    idUsuario int not null,
    primary key(idEmprestimo),
    constraint FK_livro foreign key(idLivro) references livro(idLivro),
    constraint FK_usuario foreign key(idUsuario) references usuario(idUsuario)
);

insert into autor(nomeAutor, paisOrigem)
values("Machado de Assis", "Brasil");

select * from autor;

insert into livro(tituloLivro, anoLivro, numPaginas, idAut)
values ("Dom Casmurro", 1940, 500, 1);

insert into livro(tituloLivro, anoLivro, numPaginas, idAut)
values ("O Alienista", 1945, 507, 1);

select * from livro;

insert into usuario(nomeUsuario,cpf,email)
values("João da Silva", "12345678901","joao.silva@contatos.com.br");

insert into emprestimo(dataEmprestimo,dataDevolucao,idLivro,idUsuario)
values ("2023-05-29","2023-06-09",1,1);

select * from emprestimo;