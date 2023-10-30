CREATE DATABASE IF NOT EXISTS aula30102023_Joins;
USE aula30102023_Joins;

-- Secção CREATE Start
CREATE TABLE turma(
	id_turma int not null,
    disciplina varchar(20) not null
);

CREATE TABLE professor(
	nome varchar(50) not null,
    disciplina varchar(30) not null
);
-- Secção CREATE End

-- Secção INSERT Start
INSERT INTO turma (id_turma, disciplina) VALUES
(1, 'matemática'),
(1, 'português'),
(2, 'matemática'),
(2, 'física'),
(3, 'português'),
(4, 'biologia');

INSERT INTO professor (nome, disciplina) VALUES
('João Pedro', 'matemática'),
('Ana Maria', 'química'),
('Carlos Alberto', 'biologia'),
('Guilherme Augusto', 'português');
-- Secção INSERT End

-- Secção de SELECT's Start
SELECT * FROM turma;
SELECT * FROM professor;

SELECT * FROM
turma, professor
WHERE turma.disciplina = professor.disciplina;

SELECT * FROM
turma JOIN professor ON
turma.disciplina = professor.disciplina;

SELECT * FROM
turma LEFT JOIN professor ON
turma.disciplina = professor.disciplina;

SELECT * FROM
turma RIGHT JOIN professor ON
turma.disciplina = professor.disciplina;


SELECT * FROM
turma LEFT JOIN professor ON
turma.disciplina = professor.disciplina
UNION
SELECT * FROM
turma RIGHT JOIN professor ON
turma.disciplina = professor.disciplina;