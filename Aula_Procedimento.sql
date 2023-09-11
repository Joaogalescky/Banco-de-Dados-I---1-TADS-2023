create database Aula_Procedimento;
use Aula_Procedimento;

create table Funcionario(
	id_funcionario int not null auto_increment,
	nome varchar (50) not null,
    salario int not null,
    primary key(id_funcionario)
);

insert into Funcionario(nome, salario) values
("Joao Paulo", 1000),
("Daniel Silva", 1000),
("Axel Manoel", 3200),
("Slash Madureira", 4358);

select * from Funcionario;

-- Procedimento
DELIMITER $
CREATE PROCEDURE aumenta_salario(idf int) -- idf = nome da variavel
BEGIN
	UPDATE Funcionario SET salario = salario + 300
	WHERE Funcionario.id_funcionario = idf;
END $
DELIMITER ;

-- Chamando procedimento
CALL aumenta_salario(3);
CALL aumenta_salario(2);

-- Procedimento ENTRADA
DELIMITER $
CREATE PROCEDURE selecionar_funcionario(IN quantidade int) -- IN = define que o parametro é de entrada
BEGIN
	SELECT * FROM Funcionario
    LIMIT quantidade;
END $
DELIMITER ;

-- Chamando procedimento ENTRADA
CALL selecionar_funcionario(3);

-- Procedimento SAIDA
DELIMITER $
CREATE PROCEDURE verificar_quantidade_funcionarios(OUT quantidade int) -- OUT = define que o parametro é de saida
BEGIN
	SELECT COUNT(*) INTO quantidade FROM Funcionario;
END $
DELIMITER ;

-- Chamando procedimento SAIDA
CALL verificar_quantidade_funcionarios(@total); -- (@total) = passagem de uma variável
SELECT @total;