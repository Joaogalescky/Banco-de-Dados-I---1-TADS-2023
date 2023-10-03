/*Atividade de recuperação do terceiro bimestre

Considere um sistema para uma clínica médica. Crie tabelas que representem pacientes, médicos e consultas.
- Implemente uma visão que apresente o nome dos pacientes e médicos que os atendem;
- Implemente um procedimento que informa o paciente, médico e horário para agendar uma consulta;
Individual.
*/

CREATE DATABASE recuperacao_3bimestre;
USE recuperacao_3bimestre;

CREATE TABLE Paciente(
id_paciente int not null auto_increment,
nome varchar (50) not null,
telefone varchar (12) not null,
endereco varchar (150) not null,
primary key (id_paciente)
);

CREATE TABLE Medico(
id_medico int not null auto_increment,
nome varchar(50) not null,
telefone varchar (12) not null,
primary key (id_medico)
);

CREATE TABLE Consultas(
consulta_id int not null auto_increment,
paciente_id int not null,
paciente_nome varchar (50) not null,
medico_id int not null,
medico_nome varchar (50) not null,
horario_agenda time not null,
constraint FK_paciente foreign key (paciente_id) references Paciente(id_paciente),
constraint FK_medico foreign key (medico_id) references Medico(id_medico),
primary key (consulta_id)
);

-- VIEW
CREATE VIEW VW_Consulta_do_paciente AS SELECT
Paciente.id_paciente AS ID_Paciente,
Paciente.nome AS paciente,
Medico.id_medico AS ID_Medico,
Medico.nome AS medico
FROM Paciente INNER JOIN Medico INNER JOIN  Consultas ON Paciente.id_paciente = Consultas.paciente_id
AND Consultas.medico_id = Medico.id_medico;

SET SQL_SAFE_UPDATES = 0

-- PROCEDURE
DELIMITER $
CREATE PROCEDURE Inserir_consultas (
IN i_id_paciente int,
IN i_nome_paciente varchar (50),
IN i_id_medico int,
IN i_nome_medico varchar (50),
IN i_horario_agendado time)
BEGIN
	INSERT INTO Consultas (paciente_id, paciente_nome, medico_id, medico_nome, horario_agenda) VALUES
    (i_id_paciente, i_nome_paciente, i_id_medico, i_nome_medico, i_horario_agendado);
END $
DELIMITER ;

-- INSERT
INSERT INTO Paciente (nome, telefone, endereco) VALUES 
('Maria', 45987564323, 'Rua Vitoria 645'),
('Pedro', 45988745632, 'Rua da Madeira 223');

INSERT INTO Medico (nome, telefone) VALUES
('Henrique Hermes', 45978654321),
('Paulo Alfreu', 45988654314);

-- SELECT
SELECT * FROM Paciente;
SELECT * FROM Medico;
-- CALL
CALL Inserir_consultas (1, 'Maria', 1, 'Henrique Hermes', '15:00:00');

-- VIEW
SELECT * FROM VW_Consulta_do_paciente;
