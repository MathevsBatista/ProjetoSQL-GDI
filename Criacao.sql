CREATE TABLE Banco (cnpj VARCHAR2(14), nome VARCHAR2(60),
    CONSTRAINT Banco_pkey PRIMARY KEY(cnpj));

CREATE TABLE Telefone_Banco (cnpj_b VARCHAR2(14), numero VARCHAR2(13),
    CONSTRAINT Telefone_Banco_pkey PRIMARY KEY(cnpj_b, numero),
    CONSTRAINT Telefone_Banco_fkey FOREIGN KEY(cnpj_b) REFERENCES Banco(cnpj) ON DELETE CASCADE);

CREATE TABLE Endereco_Banco (cnpj_b VARCHAR2(14), estado VARCHAR2(30), cidade VARCHAR2(30), bairro VARCHAR2(30), rua VARCHAR2(30), numero VARCHAR2(6),
    cep VARCHAR2(9), complemento VARCHAR2(30),
    CONSTRAINT Endereco_Banco_pkey PRIMARY KEY(cnpj_b),
    CONSTRAINT Endereco_Banco_fkey FOREIGN KEY(cnpj_b) REFERENCES Banco(cnpj) ON DELETE CASCADE);


CREATE TABLE Hospital (cnpj VARCHAR2(14), nome VARCHAR2(60),
    CONSTRAINT Hospital_pkey PRIMARY KEY(cnpj));

CREATE TABLE Telefone_Hospital (cnpj_h VARCHAR2(14), numero VARCHAR2(13),
    CONSTRAINT Telefone_Hospital_pkey PRIMARY KEY(cnpj_h, numero),
    CONSTRAINT Telefone_Hospital_fkey FOREIGN KEY(cnpj_h) REFERENCES Hospital(cnpj) ON DELETE CASCADE);

CREATE TABLE Endereco_Hospital (cnpj_h VARCHAR2(14), estado VARCHAR2(30), cidade VARCHAR2(30), bairro VARCHAR2(30), rua VARCHAR2(30), numero VARCHAR2(6),
    cep VARCHAR2(9), complemento VARCHAR2(30),
    CONSTRAINT Endereco_Hospital_pkey PRIMARY KEY(cnpj_h),
    CONSTRAINT Endereco_Hospital_fkey FOREIGN KEY(cnpj_h) REFERENCES Hospital(cnpj) ON DELETE CASCADE);


CREATE TABLE Pessoa (cpf VARCHAR2(11), nome VARCHAR2(60), email VARCHAR2(30), peso NUMBER(3), data_nasc DATE, sexo CHAR,
    CONSTRAINT Pessoa_pkey PRIMARY KEY(cpf));
ALTER TABLE Pessoa ADD CONSTRAINT check_sexo CHECK (sexo IN ('M', 'F'));
CREATE INDEX pessoa_nome ON Pessoa(nome);

CREATE TABLE Telefone_Pessoa (cpf_p VARCHAR2(11), numero VARCHAR2(13),
    CONSTRAINT Telefone_Pessoa_pkey PRIMARY KEY(cpf_p, numero),
    CONSTRAINT Telefone_Pessoa_fkey FOREIGN KEY(cpf_p) REFERENCES Pessoa(cpf) ON DELETE CASCADE);

CREATE TABLE Endereco_Pessoa (cpf_p VARCHAR2(11), estado VARCHAR2(30), cidade VARCHAR2(30), bairro VARCHAR2(30), rua VARCHAR2(30), numero VARCHAR2(6),
    cep VARCHAR2(9), complemento VARCHAR2(30),
    CONSTRAINT Endereco_Pessoa_pkey PRIMARY KEY(cpf_p),
    CONSTRAINT Endereco_Pessoa_fkey FOREIGN KEY(cpf_p) REFERENCES Pessoa(cpf) ON DELETE CASCADE);

CREATE TABLE Doador(cpf_p VARCHAR2(11), tipo_sang VARCHAR2(3),
    CONSTRAINT Doador_pkey PRIMARY KEY(cpf_p),
    CONSTRAINT Doador_fkey FOREIGN KEY(cpf_p) REFERENCES Pessoa(cpf) ON DELETE CASCADE);
ALTER TABLE Doador ADD CONSTRAINT tipo_sang CHECK (tipo_sang IN ('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'));

CREATE TABLE Contatos_de_Apoio (cpf_p VARCHAR2(11), nome VARCHAR2(60), telefone VARCHAR2(13),
    CONSTRAINT Contatos_de_Apoio_pkey PRIMARY KEY(cpf_p, telefone),
    CONSTRAINT Contatos_de_Apoio_fkey FOREIGN KEY(cpf_p) REFERENCES Pessoa(cpf) ON DELETE CASCADE);

CREATE TABLE Enfermeiro (cpf_p VARCHAR2(11), cnpj_b VARCHAR2(14), cpf_lider VARCHAR2(11), conta_bancaria VARCHAR2(10),
    CONSTRAINT Enfermeiro_pkey PRIMARY KEY(cpf_p),
    CONSTRAINT Enfermeiro_fkey FOREIGN KEY(cpf_p) REFERENCES Pessoa(cpf) ON DELETE CASCADE,
    CONSTRAINT Enfermeiro_banco_fkey FOREIGN KEY(cnpj_b) REFERENCES Banco(cnpj) ON DELETE CASCADE,
    CONSTRAINT Enfermeiro_lider_fkey FOREIGN KEY(cpf_lider) REFERENCES Pessoa(cpf) ON DELETE CASCADE);

CREATE SEQUENCE Campanha_id INCREMENT BY 1 START WITH 1;
CREATE TABLE Campanha (id NUMBER(5), nome VARCHAR2(60),
    CONSTRAINT Campanha_pkey PRIMARY KEY(id));

CREATE TABLE Enfermeiro_Doador (cpf_e VARCHAR2(11), cpf_d VARCHAR2(11), data_coleta DATE, id_campanha NUMBER(5), solicitado CHAR,
    CONSTRAINT Enfermeiro_Doador_pkey PRIMARY KEY(cpf_e, cpf_d, data_coleta),
    CONSTRAINT Enfermeiro_Doador_fkey FOREIGN KEY(id_campanha) REFERENCES Campanha(id) ON DELETE CASCADE,
    CONSTRAINT Enfermeiro_cpf_fkey FOREIGN KEY(cpf_e) REFERENCES Pessoa(cpf) ON DELETE CASCADE,
    CONSTRAINT Doador_cpf_fkey FOREIGN KEY(cpf_d) REFERENCES Pessoa(cpf) ON DELETE CASCADE);

CREATE TABLE Solicita (cnpj_b VARCHAR2(14), cnpj_h VARCHAR2(14), cpf_e VARCHAR2(11), cpf_d VARCHAR2(11), data_coleta DATE, data_solicitacao DATE,
    CONSTRAINT Solicita_pkey PRIMARY KEY(cnpj_b, cnpj_h, cpf_e, cpf_d, data_coleta),
    CONSTRAINT Solicita_Banco_fkey FOREIGN KEY(cnpj_b) REFERENCES Banco(cnpj) ON DELETE CASCADE,
    CONSTRAINT Solicita_Hospital_fkey FOREIGN KEY(cnpj_h) REFERENCES Hospital(cnpj) ON DELETE CASCADE,
    CONSTRAINT Solicita_Enfermeiro_Doador_fkey FOREIGN KEY(cpf_e, cpf_d, data_coleta) REFERENCES Enfermeiro_Doador(cpf_e, cpf_d, data_coleta) ON DELETE CASCADE);