create database aulaview_14_08_2023;
use aulaview_14_08_2023;

create table AUTOR(
	id_autor int not null auto_increment,
    nome varchar (40) not null,
    sobrenome varchar (40) not null,
    nacionalidade varchar (40) null,
    estilo varchar (40) null,
    primary key (id_autor)
);

insert into AUTOR(nome, sobrenome, nacionalidade, estilo) values
("Machado", "de Assis", "brasileira", "romance"),
("Karl", "Marx", "alemã", "filósofia"),
("Max", "Weber", "alemã", "sociologia"),
("Adam", "Smith", "escocesa", "filósofia"),
("Émile", "Durkheim", "francesa", "sociologia"),
("Shankant", "Navathe", "estadunidense", "banco de dados"),
("Immanuel", "Kant", "alemã", "filósofia"),
("Jean-Jacques", "Rousseau", "francesa", "filósofia"),
("Friedrich", "Nietzsche", "alemã", "filósofia"),
("Blaise", "Pascal", "francesa", "matemática"),
("René", "Descartes", "francesa", "filósofia"),
("Arquimedes", "de Siracusa", "grego", "matemática"),
("Galileu", "Galilei", "italiano", "astrônomo"),
("Isaac", "Newton", "inglês", "físico"),
("Pierre", "de Fermat", "francesa", "matemática"),
("Baruch", "Espinoza", "holandesa", "filósofia"),
("Ferney", "Voltaire", "francesa", "filósofia"),
("John", "Locke", "inglês", "filósofia"),
("Thomas", "Hobbes", "inglês", "filósofia");

select * from AUTOR;

create table LIVROS(
id_livro int not null auto_increment,
titulo varchar (100) not null,
ano int (4) not null,
edicao int (3) null,
isbn varchar (40) null,
estilo varchar (40) null,
id_autor int not null,
primary key (id_livro),
constraint fk_autor foreign key (id_autor) references Autor(id_autor)
);

insert into LIVROS(titulo, ano, estilo, id_autor) values
("Dom Casmurro", 1899, "romance", 1),
("Memórias Póstulas de Brás Cubas", 1881, "romance", 1),
("O Capital", 1887, "filósofia", 2),
("Uma Contribuição para a Crítica da Economia Política", 1850, "filósofia", 2),
("A Ética Protestante", 1904, "filósofia", 3),
("O Político e o Cientista", 1919, "filósofia", 3),
("A riqueza das nações", 1776, "filósofia", 4),
("A mão invisível", 1759, "filósofia", 4); 

select * from LIVROS;

create view vw_LivrosAutores
as select LIVROS.titulo as Livro, AUTOR.nome as Autor
from LIVROS inner join AUTOR
on LIVROS.id_autor = AUTOR.id_autor;

select * from vw_LivrosAutores;

create view vw_LivrosAlemaes
as select LIVROS.titulo as Livro
from LIVROS inner join AUTOR
on LIVROS.id_autor = AUTOR.id_autor
and AUTOR.nacionalidade = "alemã";

select * from vw_LivrosAlemaes;

select Livro, Autor
from vw_LivrosAutores
order by Livro;