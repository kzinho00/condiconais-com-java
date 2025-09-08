-- DROP SCHEMA IF EXISTS clinica_vet;

CREATE SCHEMA IF NOT EXISTS clinica_vet;
USE clinica_vet;

-------------------
-- TABLE: tutor  --
-------------------

CREATE TABLE IF NOT EXISTS tutor (
  id INT PRIMARY KEY AUTO_INCREMENT,
  cpf VARCHAR(11) NOT NULL UNIQUE,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(200) UNIQUE,
  fone VARCHAR(25) NOT NULL
);

INSERT IGNORE INTO tutor (cpf, nome, email, fone) VALUES
('12345678901', 'João da Silva', 'joao@gmail.com', '11999999999'),
('02217124411', 'Paulo Henrique', 'ph@gmail.com', '11555555555');

----------------------------
-- TABLE: tutor_endereco  --
----------------------------

CREATE TABLE IF NOT EXISTS tutor_endereco (
  id_tutor INT NOT NULL,
  cep VARCHAR(12) NOT NULL,
  rua VARCHAR(100) NOT NULL,
  numero INT NOT NULL,
  complemento VARCHAR(50),
  cidade VARCHAR(50) NOT NULL,
  uf VARCHAR(2) NOT NULL,
  FOREIGN KEY (id_tutor) REFERENCES tutor(id)
);

INSERT INTO tutor_endereco (id_tutor, cep, rua, numero, complemento, cidade, uf) VALUES
(1, '01000-000', 'Rua A', 123, 'tantofaz', 'São Paulo', 'SP'),
(2, '02000-002', 'Rua B', 321, 'tantofez', 'Rio de Janeiro', 'RJ');

-------------------
-- TABLE: animal --
-------------------

CREATE TABLE IF NOT EXISTS animal (
  id INT PRIMARY KEY AUTO_INCREMENT,
  id_tutor INT,
  nome VARCHAR(100) NOT NULL,
  peso DECIMAL(5,2),
  cor VARCHAR(100),
  sexo ENUM('M', 'F'),
  data_nasc DATE,
  raca VARCHAR(100),
  especie VARCHAR(100),
  FOREIGN KEY (id_tutor) REFERENCES tutor(id)
);

INSERT INTO animal (id_tutor, nome, peso, cor, sexo, data_nasc, raca, especie) VALUES
(1, 'Rex', 20.5, 'Preto', 'M', '2018-01-10', 'Labrador', 'Cachorro'),
(2, 'Mimi', 4.2, 'branco', 'F', '2020-06-15', 'Persa', 'Gato');

--------------------------
-- TABELA VETERINARIO --
--------------------------

CREATE TABLE IF NOT EXISTS Veterinario (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL UNIQUE,
  crmv VARCHAR(100) NOT NULL UNIQUE,
  email VARCHAR(200) UNIQUE,
  fone VARCHAR(25) NOT NULL,
  especialidade VARCHAR(100) NOT NULL
);

INSERT INTO Veterinario (nome, crmv, email, fone, especialidade) VALUES
('Dra. Ana Souza', 'crmv12345', 'ana@vet.com', '1133334444', 'Clínico Geral'),
('Dr. Carlos Lima', 'CRMV54321', 'carlos@vet.com', '1177776666', 'Dermatologia');

----------------------------------
-- TABELA VETERINARIO_ENDEREÇO --
----------------------------------

CREATE TABLE IF NOT EXISTS Veterinario_endereco (
  id INT PRIMARY KEY AUTO_INCREMENT,
  id_vet INT,
  cep VARCHAR(12) NOT NULL,
  rua VARCHAR(100) NOT NULL,
  numero INT NOT NULL,
  complemento VARCHAR(50),
  cidade VARCHAR(50) NOT NULL,
  uf VARCHAR(2) NOT NULL,
  FOREIGN KEY(id_vet) REFERENCES Veterinario(id)
);

INSERT INTO Veterinario_endereco (id_vet, cep, rua, numero, complemento, cidade, uf) VALUES
(1, '03000-000', 'Rua Vet1', 789, 'sala 5', 'Santos', 'SP'),
(2, '04000-000', 'Rua Vet2', 321, NULL, 'Ribeirão Preto', 'SP');

----------------------
-- TABELA CONSULTA --
----------------------

CREATE TABLE IF NOT EXISTS Consulta (
  id INT PRIMARY KEY AUTO_INCREMENT,
  id_vet INT,
  id_animal INT,
  dt DATE,
  horario TIME,
  FOREIGN KEY (id_vet) REFERENCES Veterinario(id),
  FOREIGN KEY (id_animal) REFERENCES Animal(id)
);

INSERT INTO Consulta (id_vet, id_animal, dt, horario) VALUES
(1, 1, '2024-05-01', '10:30:00'),
(2, 2, '2024-05-02', '14:00:00');

----------------------
-- TABELA exame --
----------------------

CREATE TABLE IF NOT EXISTS exame (
  id_veterinario INT,
  id_consulta INT,
  id_exame INT PRIMARY KEY AUTO_INCREMENT,
  id_animal INT,
  tipo_exame ENUM('sangue', 'raio-x', 'urina', 'ultrassom', 'eletrocardiograma', 'outro') DEFAULT NULL,
  resultado TEXT,
  data_exame DATE,
  FOREIGN KEY (id_consulta) REFERENCES consulta(id),
  FOREIGN KEY (id_animal) REFERENCES animal(id),
  FOREIGN KEY (id_veterinario) REFERENCES veterinario(id)
  );
  
  INSERT INTO exame (id_animal, tipo_exame, resultado, data_exame) VALUES
  (1, 'sangue', 'pendente', '2025-07-29' );
------------------------------
-- EXIBINDO DADOS INSERIDOS--
------------------------------

SELECT 'exame' AS tabela;
SELECT * FROM exame;

SELECT 'tutor' AS tabela;
SELECT * FROM tutor;

SELECT 'tutor_endereco' AS tabela;
SELECT * FROM tutor_endereco;

SELECT 'animal' AS tabela;
SELECT * FROM animal;

SELECT 'Veterinario' AS tabela;
SELECT * FROM Veterinario;

SELECT 'Veterinario_endereco' AS tabela;
SELECT * FROM Veterinario_endereco;

SELECT 'Consulta' AS tabela;
SELECT * FROM Consulta;




