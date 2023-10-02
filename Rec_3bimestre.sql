/*Atividade de recuperação do terceiro bimestre

Considere um sistema para uma clínica médica. Crie tabelas que representem pacientes, médicos e consultas.
- Implemente uma visão que apresente o nome dos pacientes e médicos que os atendem;
- Implemente um procedimento que informa o paciente, médico e horário para agendar uma consulta;
Individual.
*/

create database recuperacao_3bimestre;
use recuperacao_3bimestre;

create table paciente(
id_paciente int not null auto_increment,
nome varchar (50) not null,
telefone int (12) not null,
endereco varchar (150) not null,
primary key (id_paciente)
);

create table medico(
id_medico int not null auto_increment,
nome varchar(50) not null,
telefone int (12) not null,
endereco varchar(150) not null,
primary key (id_medico)
);

create table consultas(
consulta_id int not null auto_increment,
paciente_id int not null,
medico_id int not null,
horario_agenda time not null,
constraint FK_paciente foreign key (paciente_id) references paciente(id_paciente),
constraint FK_medico foreign key (medico_id) references medico(id_medico),
primary key (consulta_id)
);
