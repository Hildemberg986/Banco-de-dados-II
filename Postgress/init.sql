-- Removendo tabelas existentes
DROP TABLE IF EXISTS atividade CASCADE;
DROP TABLE IF EXISTS projeto CASCADE;
DROP TABLE IF EXISTS departamento CASCADE;
DROP TABLE IF EXISTS funcionario CASCADE;

-- Criando as tabelas
CREATE TABLE funcionario (
    codigo SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    sexo CHAR(1),
    dtNasc DATE,
    salario DECIMAL(10,2),
    codSupervisor INT NULL,
    codDepto INT NULL,
    CONSTRAINT fk_func_supervisor FOREIGN KEY (codSupervisor) REFERENCES funcionario(codigo) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE departamento (
    codigo SERIAL PRIMARY KEY,
    sigla VARCHAR(10) UNIQUE NOT NULL,
    descricao VARCHAR(50),
    codGerente INT NULL,
    CONSTRAINT fk_dep_gerente FOREIGN KEY (codGerente) REFERENCES funcionario(codigo) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE projeto (
    codigo SERIAL PRIMARY KEY,
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
    codigo SERIAL PRIMARY KEY,
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
('DXT', NULL, NULL),
('DMA', 'Dep Matemática', NULL),
('DFTE', 'Dep Física', NULL),
('DQU', 'Dep Química', NULL),
('DBI', 'Dep Biologia', NULL),
('DAD', 'Dep Administração', NULL),
('DEC', 'Dep Economia', NULL),
('DCC', 'Dep Ciências Contábeis', NULL),
('DEN', 'Dep Engenharia', NULL),
('DAR', 'Dep Arquitetura', NULL),
('DLE', 'Dep Letras', NULL),
('DFI', 'Dep Filosofia', NULL),
('DPS', 'Dep Psicologia', NULL),
('DDS', 'Dep Direito', NULL),
('DED', 'Dep Educação', NULL),
('DSS', 'Dep Serviço Social', NULL);

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
('Ricardo', 'M', '1985-03-15', 3200.00, 5, 2),
('Fernanda', 'F', '1990-11-25', 2800.00, 2, 2),
('Lucas', 'M', '1995-07-30', 2200.00, 6, 4),
('Patrícia', 'F', '1988-06-17', 3100.00, 3, 3),
('Anderson', 'M', '1992-04-21', 2700.00, 7, 5),
('Camila', 'F', '1997-08-09', 2500.00, 8, 6),
('Juliano', 'M', '1993-02-14', 2950.00, 4, 7),
('Elaine', 'F', '1981-12-05', 4500.00, 9, 8),
('Gustavo', 'M', '1989-09-22', 3800.00, 10, 9),
('Rafaela', 'F', '1996-03-11', 2600.00, 11, 10),
('Marcelo', 'M', '1987-05-19', 3300.00, 12, 11),
('Beatriz', 'F', '1991-07-24', 2900.00, 13, 12),
('Otávio', 'M', '1983-10-13', 4100.00, 14, 13),
('Priscila', 'F', '1998-12-29', 2350.00, 15, 14),
('Renato', 'M', '1994-09-03', 2750.00, 16, 15),
('Tatiane', 'F', '1986-08-15', 3600.00, 17, 16),
('Henrique', 'M', '1984-06-02', 3400.00, 18, 17),
('Simone', 'F', '1999-01-18', 2450.00, 19, 18),
('Roberto', 'M', '1979-11-07', 5000.00, NULL, 19),
('Viviane', 'F', '2000-05-23', 2100.00, 1, 1),
('Tresberta', 'F', '1992-09-01', 3000.00, 4, 3);

-- Adicionando TODOS os projetos primeiro (originais + novos)
INSERT INTO projeto (nome, descricao, codDepto, codResponsavel, dataInicio, dataFim) VALUES
-- Projetos originais
('APF', 'Analisador de Ponto de Função', 2, 2, '2018-02-26', '2019-06-30'),
('Monitoria', 'Projeto de Monitoria 2019.1', 1, 6, '2019-02-26', '2019-12-30'),
('BD', 'Projeto de Banco de Dados', 3, 5, '2018-02-26', '2018-06-30'),
('ES', 'Projeto de Engenharia de Software', 1, 1, '2018-02-26', '2018-06-30'),
-- Projetos adicionais para 2020
('IA', 'Projeto de Inteligência Artificial', 2, 5, '2020-03-15', '2020-12-15'),
('Redes', 'Projeto de Redes de Computadores', 2, 2, '2020-04-01', '2020-11-30'),
('Geografia Urbana', 'Estudo sobre Geografia Urbana', 3, 9, '2020-05-10', '2020-10-20'),
-- Projetos adicionais para 2021
('Cloud', 'Migração para Cloud Computing', 2, 2, '2021-02-01', '2021-10-31'),
('História Digital', 'Projeto de História Digital', 1, 1, '2021-03-15', '2021-09-30'),
('Matemática Aplicada', 'Aplicações de Matemática em Engenharia', 5, 14, '2021-04-10', '2021-12-15'),
-- Projetos adicionais para 2022
('IoT', 'Internet das Coisas Aplicada', 2, 5, '2022-01-15', '2022-08-31'),
('Educação Remota', 'Projeto de Educação Remota', 18, 19, '2022-03-01', '2022-11-30'),
('Biologia Molecular', 'Pesquisa em Biologia Molecular', 8, 17, '2022-04-15', '2022-12-15');

-- Agora adicionando TODAS as atividades (originais + novas)
INSERT INTO atividade (descricao, codProjeto, dataInicio, dataFim) VALUES
-- Atividades originais
('APF - Atividade 1', 1, '2018-02-26', '2018-06-30'),
('APF - Atividade 2', 1, '2018-06-26', '2018-07-30'),
('APF - Atividade 3', 1, '2018-08-26', '2018-09-30'),
('Monitoria - Atividade 1', 2, '2018-06-26', '2018-07-30'),
('BD - Atividade 1', 3, '2018-06-26', '2018-07-30'),
('BD - Atividade 2', 3, '2018-08-26', '2018-09-30'),
('ES - Atividade 1', 4, '2018-09-30', '2018-10-30'),
-- Atividades adicionais para 2020
('IA - Modelagem', 5, '2020-03-15', '2020-05-15'),
('IA - Treinamento', 5, '2020-05-16', '2020-08-15'),
('IA - Implementação', 5, '2020-08-16', '2020-12-15'),
('Redes - Configuração', 6, '2020-04-01', '2020-06-30'),
('Redes - Testes', 6, '2020-07-01', '2020-09-30'),
('Redes - Implantação', 6, '2020-10-01', '2020-11-30'),
('Geografia - Pesquisa', 7, '2020-05-10', '2020-07-10'),
('Geografia - Análise', 7, '2020-07-11', '2020-09-11'),
('Geografia - Publicação', 7, '2020-09-12', '2020-10-20'),
-- Atividades adicionais para 2021
('Cloud - Planejamento', 8, '2021-02-01', '2021-03-15'),
('Cloud - Migração', 8, '2021-03-16', '2021-07-31'),
('Cloud - Otimização', 8, '2021-08-01', '2021-10-31'),
('História - Coleta de Dados', 9, '2021-03-15', '2021-05-15'),
('História - Digitalização', 9, '2021-05-16', '2021-07-31'),
('História - Catalogação', 9, '2021-08-01', '2021-09-30'),
('Matemática - Modelagem', 10, '2021-04-10', '2021-06-30'),
('Matemática - Simulação', 10, '2021-07-01', '2021-09-30'),
('Matemática - Validação', 10, '2021-10-01', '2021-12-15'),
-- Atividades adicionais para 2022
('IoT - Prototipagem', 11, '2022-01-15', '2022-03-31'),
('IoT - Desenvolvimento', 11, '2022-04-01', '2022-06-30'),
('IoT - Testes', 11, '2022-07-01', '2022-08-31'),
('Educação - Plataforma', 12, '2022-03-01', '2022-05-31'),
('Educação - Conteúdo', 12, '2022-06-01', '2022-08-31'),
('Educação - Capacitação', 12, '2022-09-01', '2022-11-30'),
('Biologia - Coleta', 13, '2022-04-15', '2022-06-30'),
('Biologia - Análise', 13, '2022-07-01', '2022-09-30'),
('Biologia - Publicação', 13, '2022-10-01', '2022-12-15');
