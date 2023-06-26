create database AulaConsultas;
use AulaConsultas;

create table contatos(
	id int not null auto_increment,
    nome varchar(20) not null,
	sobrenome varchar(30) not null,
    ddd int(2) not null,
    telefone varchar(9) not null,
    data_nasc date null,
    email varchar(30),
    ano_conheceu int(4) not null,
    primary key(id)
);

insert into contatos(nome, sobrenome, ddd, telefone, data_nasc, email, ano_conheceu) values
("João", "Silva", 45, "992387564", "1948-12-02", "joao.silva@contatos.com", 2007),
("João", "Machado", 43, "988776655", "1995-02-12", "joao.machado@contatos.com", 2015),
("Pedro", "Barroso", 43, "999834564", "1969-01-05", "pedro.barroso@contatos.com", 2018),
("Guilherme", "Matos", 41, "998687564", "1975-05-02", "guilherme.matos@contatos.com", 2000),
("Gustavo", "Bento", 40, "999677564", "2000-03-10", "gustavo.bento@contatos.com", 2004),
("Joana", "Dark", 41, "999887532", "1989-08-15", "joana.dark@contatos.com", 1997),
("Amanda", "Scytor", 44, "999885464", "1999-07-21", "amanda.snytor@contatos.com", 1994),
("Frederico", "Kusky", 47, "992387564", "2002-05-30", "frederico.kusky@contatos.com", 1995),
("João", "Hilger", 48, "999887543", "1976-10-23", "joaa.hilger@contatos.com", 2014),
("Emerson", "Santos", 45, "999887551", "2000-08-22", "emerson.santos@contatos.com", 2010);

select * from contatos;

# Neste comando, você seleciona oque deseja visualizar, onde, e por meio do que.
select id, nome, sobrenome, email
from contatos
where sobrenome = "Matos";

select nome, sobrenome, ano_conheceu
from contatos
where ano_conheceu < 2015;

# Neste comando, você seleciona oque deseja visualizar de uma tabela sem informações repetidas
# DISTINCT não repete os mesmos dados
select DISTINCT ddd
from contatos;

# ORDER By ordena o resultado de forma crescente, DESC é para mostrar do mais alto ao menor (Z-A)
select nome, sobrenome
from contatos
order by nome DESC;

# LIMIT: limita o conjunto de resultados
select * from contatos
limit 0, 5;

-- EXTRAÇÃO DE DADOS A PARTIR DE DATAS
select nome, sobrenome, data_nasc, DAYNAME(data_nasc) from contatos;
select nome, sobrenome, data_nasc, DAYOFMONTH(data_nasc) from contatos;
select nome, sobrenome, data_nasc, DAYOFYEAR(data_nasc) from contatos;

-- LIKE vai selecionar os dados que começam com a 1° letra que deseja se colocar "_" antes, vai pesquisar a 2°letra, assim subsequentemente
select nome, sobrenome from contatos
where nome LIKE 'J%';
select nome, sobrenome from contatos
where nome LIKE '__a%';

select nome, sobrenome, email from contatos
where email LIKE '%teste.com';
-- para frente o '%' ele olha do meio para a direita. Se estiver antes do '%' ele olha do meio para a esquerda

-- LEFT e RIGHT
select LEFT(nome, 6) from contatos;
select RIGHT(nome, 4) from contatos;
-- Este comando limita a quantidade de caracteres que deve aparecer da direção selecionada, LEFT ou RIGHT

-- TIMESTAMPDIFF
select nome, sobrenome, data_nasc, TIMESTAMPDIFF (year data_nasc, NOW()) from contatos;
-- Este comando calcula os anos de uma data

select timestampdiff(YEAR, "2003-08-21", "2080-12-21");
-- Este comando calcula os anos a partir de uma data escolhida