-- INSERINDO HOSPITAL
INSERT INTO Hospital(cnpj, nome) VALUES ('91707521000139', 'Hospital Santa Joana');
INSERT INTO Telefone_Hospital(cnpj_h, numero) VALUES ('91707521000139', '5581997660093');
INSERT INTO Endereco_Hospital(cnpj_h, estado, cidade, bairro, rua, numero, cep) VALUES ('91707521000139', 'Pernambuco', 'Recife', 'Boa Viagem', 'Avenida Jonatas de Vasconcelos', '350', '54400389');

INSERT INTO Hospital(cnpj, nome) VALUES ('67798588000141', 'Hospital Real Português');
INSERT INTO Telefone_Hospital(cnpj_h, numero) VALUES ('67798588000141', '5581967645093');
INSERT INTO Endereco_Hospital(cnpj_h, estado, cidade, bairro, rua, numero, cep) VALUES ('67798588000141', 'Pernambuco', 'Recife', 'Boa Viagem', 'Avenida Boa Viagem', '3000', '55240389');

INSERT INTO Hospital(cnpj, nome) VALUES ('86652947000100', 'Hospital da Restauração');
INSERT INTO Telefone_Hospital(cnpj_h, numero) VALUES ('86652947000100', '5581954690093');
INSERT INTO Endereco_Hospital(cnpj_h, estado, cidade, bairro, rua, numero, cep) VALUES ('86652947000100', 'Pernambuco', 'Recife', 'Caxangá', 'Avenida Caxangá', '2000', '64506909');


-- INSERINDO BANCO
INSERT INTO Banco(cnpj, nome) VALUES ('70346672000139', 'IMIP');
INSERT INTO Telefone_Banco(cnpj_b, numero) VALUES ('70346672000139', '5581228143142');
INSERT INTO Endereco_Banco(cnpj_b, estado, cidade, bairro, rua, numero, cep) VALUES ('70346672000139', 'Pernambuco', 'Recife', 'Parnamirim', 'Rua das Jaguatiricas', '550', '55158072');

INSERT INTO Banco(cnpj, nome) VALUES ('63180391000193', 'HEMATO');
INSERT INTO Telefone_Banco(cnpj_b, numero) VALUES ('63180391000193', '5581967645093');
INSERT INTO Endereco_Banco(cnpj_b, estado, cidade, bairro, rua, numero, cep, complemento) VALUES ('63180391000193', 'Pernambuco', 'Recife', 'Boa Vista', 'Rua Dom Bosco', '723', '55157270', 'Bloco C');

INSERT INTO Banco(cnpj, nome) VALUES ('72989879000157', 'HEMOPE');
INSERT INTO Telefone_Banco(cnpj_b, numero) VALUES ('72989879000157', '5581954690093');
INSERT INTO Endereco_Banco(cnpj_b, estado, cidade, bairro, rua, numero, cep) VALUES ('72989879000157', 'Pernambuco', 'Recife', 'Graças', 'Rua Joaquim Nabuco', '171', '55152610');

-- INSERINDO PESSOA
INSERT INTO Pessoa(cpf, nome, email, peso, data_nasc, sexo) VALUES ('13384332458', 'José Bezerra de Melo Neto', 'jbmn2@cin.ufpe.br', 72, TO_DATE('2000/05/16', 'yyyy/mm/dd'), 'M');
INSERT INTO Telefone_Pessoa(cpf_p, numero) VALUES ('13384332458', '5581997660099');
INSERT INTO Endereco_Pessoa(cpf_p, estado, cidade, bairro, rua, numero, cep) VALUES ('13384332458', 'Pernambuco', 'Recife', 'Boa Viagem', 'Avenida Boa Viagem', '100', '55150911');

INSERT INTO Pessoa(cpf, nome, email, peso, data_nasc, sexo) VALUES ('13022560419', 'Maria Augusta Mota Borba', 'guta@cin.ufpe.br', 64, TO_DATE('1999/06/15', 'yyyy/mm/dd'), 'F');
INSERT INTO Telefone_Pessoa(cpf_p, numero) VALUES ('13022560419', '5581997666543');
INSERT INTO Endereco_Pessoa(cpf_p, estado, cidade, bairro, rua, numero, cep) VALUES ('13022560419', 'Pernambuco', 'Recife', 'Boa Viagem', 'Avenida Boa Viagem', '101', '55150911');

INSERT INTO Pessoa(cpf, nome, email, peso, data_nasc, sexo) VALUES ('11554314488', 'Victor Edmond Freire Gaudiot', 'gaudiot@cin.ufpe.br', 72, TO_DATE('1999/01/13', 'yyyy/mm/dd'), 'M');
INSERT INTO Telefone_Pessoa(cpf_p, numero) VALUES ('11554314488', '5581989666523');
INSERT INTO Endereco_Pessoa(cpf_p, estado, cidade, bairro, rua, numero, cep) VALUES ('11554314488', 'Pernambuco', 'Recife', 'Boa Viagem', 'Avenida Boa Viagem', '102', '55150911');

INSERT INTO Pessoa(cpf, nome, email, peso, data_nasc, sexo) VALUES ('11894086430', 'Matheus Isidoro Gomes Batista', 'isidoro@cin.ufpe.br', 66, TO_DATE('1999/04/10', 'yyyy/mm/dd'), 'M');
INSERT INTO Telefone_Pessoa(cpf_p, numero) VALUES ('11894086430', '5581949856523');
INSERT INTO Endereco_Pessoa(cpf_p, estado, cidade, bairro, rua, numero, cep) VALUES ('11894086430', 'Pernambuco', 'Recife', 'Boa Viagem', 'Avenida Boa Viagem', '103', '55150911');

INSERT INTO Pessoa(cpf, nome, email, peso, data_nasc, sexo) VALUES ('11019884444', 'Maria Clara Dionísio Amaral Gois', 'clara@cin.ufpe.br', 60, TO_DATE('2000/09/13', 'yyyy/mm/dd'), 'F');
INSERT INTO Telefone_Pessoa(cpf_p, numero) VALUES ('11019884444', '5581949856523');
INSERT INTO Endereco_Pessoa(cpf_p, estado, cidade, bairro, rua, numero, cep) VALUES ('11019884444', 'Pernambuco', 'Recife', 'Boa Viagem', 'Avenida Boa Viagem', '104', '55150911');

-- INSERINDO DOADOR
INSERT INTO Doador(cpf_p, tipo_sang) VALUES('13384332458', 'A+');
INSERT INTO Contatos_de_Apoio(cpf_p, nome, telefone) VALUES ('13384332458', 'Irlane da Silva Oliveira', '5581991638394');

INSERT INTO Doador(cpf_p, tipo_sang) VALUES('13022560419', 'O+');
INSERT INTO Contatos_de_Apoio(cpf_p, nome, telefone) VALUES ('13022560419', 'José Bezerra de Melo Neto', '5581997660099');

INSERT INTO Doador(cpf_p, tipo_sang) VALUES('11554314488', 'O+');
INSERT INTO Contatos_de_Apoio(cpf_p, nome, telefone) VALUES ('11554314488', 'Gildo Vigor', '5581998765432');

-- INSERINDO ENFERMEIROS
INSERT INTO Enfermeiro (cpf_p, cnpj_b, conta_bancaria) VALUES ('11894086430', '70346672000139', '1234598-09');
INSERT INTO Enfermeiro (cpf_p, cnpj_b, cpf_lider, conta_bancaria) VALUES ('11019884444', '70346672000139', '11894086430','9875788-09');

-- INSERINDO CAMPANHA
INSERT INTO Campanha(id, nome) VALUES (Campanha_id.NEXTVAL, 'Campanha dos Legais');
INSERT INTO Campanha(id, nome) VALUES (Campanha_id.NEXTVAL, 'Campanha dos Não Legais');

-- INSERINDO ENFERMEIRO-DOADOR
INSERT INTO Enfermeiro_Doador (cpf_e, cpf_d, data_coleta, id_campanha, solicitado) VALUES ('11019884444', '13384332458', TO_DATE('2020/03/23', 'yyyy/mm/dd'), 1, 'N');
INSERT INTO Enfermeiro_Doador (cpf_e, cpf_d, data_coleta, id_campanha, solicitado) VALUES ('11019884444', '11554314488', TO_DATE('2020/03/23', 'yyyy/mm/dd'), 2, 'N');
INSERT INTO Enfermeiro_Doador (cpf_e, cpf_d, data_coleta, solicitado) VALUES ('11894086430', '13022560419', TO_DATE('2020/03/23', 'yyyy/mm/dd'), 'N');

-- INSERINDO SOLICITA
INSERT INTO Solicita(cnpj_b, cnpj_h, cpf_e, cpf_d, data_coleta, data_solicitacao) VALUES ('70346672000139', '67798588000141', '11019884444', '13384332458', TO_DATE('2020/03/23', 'yyyy/mm/dd'), TO_DATE('2020/03/25', 'yyyy/mm/dd'));
INSERT INTO Solicita(cnpj_b, cnpj_h, cpf_e, cpf_d, data_coleta, data_solicitacao) VALUES ('70346672000139', '86652947000100', '11019884444', '11554314488', TO_DATE('2020/03/23', 'yyyy/mm/dd'), TO_DATE('2020/03/26', 'yyyy/mm/dd'));