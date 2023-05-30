create database aulaBD;
use aulaBD;
create table AlunosBD(
idAluno integer,
nomeAluno varchar(100),
emailAluno varchar(100),
turmaAluno varchar(10)
);

insert into AlunosBD(idAluno,nomeAluno,emailAluno,turmaAluno)
values (1,"Fulano de Ciclano", "fulano.ciclano@teste.edu.br", "1ATADS");

select * from AlunosBD;

insert into AlunosBD(idAluno,nomeAluno,emailAluno,turmaAluno)
values (2,"Beltrano de Ciclano", "beltrano.ciclano@teste.edu.br", "2ATADS");

select * from AlunosBD;

SET SQL_SAFE_UPDATES = 0;

update AlunosBD
set emailAluno="beltrano.ciclano@teste.com.br"
where idAluno=2;

select * from AlunosBD;

delete from AlunosBD
where idAluno=1;

select * from AlunosBD;