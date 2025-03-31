-- Removendo tabelas existentes
DROP TABLE IF EXISTS atividade CASCADE;
DROP TABLE IF EXISTS projeto CASCADE;
DROP TABLE IF EXISTS departamento CASCADE;
DROP TABLE IF EXISTS funcionario CASCADE;

-- Criando as tabelas
CREATE TABLE funcionario (
    codigo INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    sexo CHAR(1),
    dtNasc DATE,
    salario DECIMAL(10,2),
    codSupervisor INT NULL,
    codDepto INT NULL,
    CONSTRAINT fk_func_supervisor FOREIGN KEY (codSupervisor) REFERENCES funcionario(codigo) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE departamento (
    codigo INT AUTO_INCREMENT PRIMARY KEY,
    sigla VARCHAR(10) UNIQUE NOT NULL,
    descricao VARCHAR(50),
    codGerente INT NULL,
    CONSTRAINT fk_dep_gerente FOREIGN KEY (codGerente) REFERENCES funcionario(codigo) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE projeto (
    codigo INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) UNIQUE NOT NULL,
    descricao VARCHAR(250),
    codResponsavel INT NULL,
    codDepto INT NULL,
    dataInicio DATE, 
    dataFim DATE,
    CONSTRAINT fk_proj_resp FOREIGN KEY (codResponsavel) REFERENCES funcionario(codigo) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_proj_depto FOREIGN KEY (codDepto) REFERENCES departamento(codigo) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE atividade (
    codigo INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(250),
    codProjeto INT NULL,
    dataInicio DATE, 
    dataFim DATE,
    CONSTRAINT fk_atividade_proj FOREIGN KEY (codProjeto) REFERENCES projeto(codigo) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Ajustando a FK do funcionário para o departamento
ALTER TABLE funcionario 
ADD CONSTRAINT fk_func_depto FOREIGN KEY (codDepto) REFERENCES departamento(codigo) ON DELETE SET NULL ON UPDATE CASCADE;

-- Povoamento inicial
INSERT INTO departamento (sigla, descricao, codGerente) VALUES
('DHC', 'Dep História', NULL),
('DCT', 'Dep Computação', NULL),
('DGC', 'Dep Geografia', NULL),
('DXT', NULL, NULL);

-- Adicionando Gerentes
INSERT INTO funcionario (nome, sexo, dtNasc, salario, codSupervisor, codDepto) VALUES
('Ana', 'F', '1988-05-07', 2500.00, NULL, 1),
('Taciano', 'M', '1980-01-25', 2500.00, NULL, 2);

UPDATE departamento SET codGerente = 1 WHERE sigla = 'DHC';
UPDATE departamento SET codGerente = 2 WHERE sigla = 'DCT';

-- Adicionando Funcionários
INSERT INTO funcionario (nome, sexo, dtNasc, salario, codSupervisor, codDepto) VALUES
('Maria', 'F', '1981-07-01', 2500.00, 1, 1),
('Josefa', 'F', '1986-09-17', 2500.00, 1, 1),
('Carlos', 'M', '1985-11-21', 2500.00, 1, 1),
('Humberto', 'M', '1970-05-07', 1500.00, 2, 2),
('José', 'M', '1979-07-12', 3500.00, 2, 2),
('Xuxa', 'F', '1970-03-28', 13500.00, NULL, NULL),
('Sasha', 'F', '1970-03-28', 1500.00, 3, 1),
('Victor', 'M', '1970-03-28', 500.00, 4, 1),
('Doisberto', 'M', '1980-07-14', 2500.00, 3, 3),
('Tresberta', 'F', '1992-09-01', 3000.00, 4, 3);

-- Adicionando Projetos
INSERT INTO projeto (nome, descricao, codDepto, codResponsavel, dataInicio, dataFim) VALUES
('APF', 'Analisador de Ponto de Função', 2, 2, '2018-02-26', '2019-06-30'),
('Monitoria', 'Projeto de Monitoria 2019.1', 1, 6, '2019-02-26', '2019-12-30'),
('BD', 'Projeto de Banco de Dados', 3, 5, '2018-02-26', '2018-06-30'),
('ES', 'Projeto de Engenharia de Software', 1, 1, '2018-02-26', '2018-06-30');

-- Adicionando Atividades
INSERT INTO atividade (descricao, codProjeto, dataInicio, dataFim) VALUES
('APF - Atividade 1', 1, '2018-02-26', '2018-06-30'),
('APF - Atividade 2', 1, '2018-06-26', '2018-07-30'),
('APF - Atividade 3', 1, '2018-08-26', '2018-09-30'),
('Monitoria - Atividade 1', 2, '2018-06-26', '2018-07-30'),
('BD - Atividade 1', 3, '2018-06-26', '2018-07-30'),
('BD - Atividade 2', 3, '2018-08-26', '2018-09-30'),
('ES - Atividade 1', 4, '2018-09-30', '2018-10-30');
