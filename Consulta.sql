-- UPDATE
UPDATE Pessoa SET SEXO='F' WHERE CPF='11019884444';

-- DELETE
DELETE FROM Banco WHERE CNPJ='72989879000157';

-- SELECT-FROM-WHERE | BETWEEN | IS​ ​NULL​ ​​ ​ou​ ​​ ​IS​ ​NOT​ ​NULL
SELECT * FROM Endereco_Banco WHERE Complemento IS NULL;
SELECT * FROM Pessoa WHERE Peso BETWEEN 60 AND 80;

-- SELECT-FROM-WHERE | LIKE
SELECT * FROM Pessoa WHERE Nome LIKE 'Maria%';

-- SELECT-FROM-WHERE | INNER-JOIN
SELECT Cnpj, nome, Cidade, Rua, Numero FROM Banco B INNER JOIN Endereco_Banco EB ON B.CNPJ=EB.CNPJ_B;

-- SELECT-FROM-WHERE | MAX | SUBCONSULTA​ ​COM​ ​OPERADOR
SELECT * FROM Pessoa WHERE Peso=(SELECT MAX(Peso) FROM Pessoa);

-- SELECT-FROM-WHERE | MIN | SUBCONSULTA​ ​COM​ ​OPERADOR
SELECT * FROM Pessoa WHERE Peso=(SELECT MIN(Peso) FROM Pessoa);

-- SELECT-FROM-WHERE | AVG | SUBCONSULTA​ ​COM​ ​OPERADOR
SELECT * FROM Pessoa WHERE Peso=(SELECT AVG(Peso) FROM Pessoa);

-- SELECT-FROM-WHERE | COUNT
SELECT COUNT(*) FROM Pessoa WHERE Sexo='F';

-- SELECT-FROM-WHERE | GROUP BY
SELECT Sexo, COUNT(*) FROM Pessoa GROUP BY Sexo;

-- SELECT-FROM-WHERE | GROUP BY | HAVING
SELECT Peso, COUNT(*) FROM Pessoa GROUP BY Peso HAVING Peso>70;

-- SELECT-FROM-WHERE | GROUP BY | ORDER BY
SELECT * FROM Enfermeiro_Doador ORDER BY data_coleta ASC;

-- SELECT-FROM-WHERE | LEFT​ ​ou​ ​RIGHT​ ​ou​ ​FULL​ ​OUTER​ ​JOIN
SELECT ED.Cpf_e, ED.Cpf_d, S.Cnpj_b, S.Cnpj_h, ED.Data_coleta, S.Data_solicitacao FROM Enfermeiro_Doador ED LEFT OUTER JOIN Solicita S ON ED.cpf_e=S.cpf_e AND ED.cpf_d=S.cpf_d;

-- SELECT-FROM-WHERE | SUBCONSULTA​ ​COM​ ​IN
SELECT * FROM Enfermeiro_Doador WHERE id_campanha IN (1,2);

-- SELECT-FROM-WHERE | SUBCONSULTA​ ​COM​ ​​ANY
SELECT * FROM Pessoa WHERE Sexo='M' AND Peso>SOME(SELECT Peso FROM Pessoa WHERE Sexo='F');

-- SELECT-FROM-WHERE | SUBCONSULTA​ ​COM​ ALL
SELECT * FROM Pessoa WHERE Sexo='M' AND Peso>ALL(SELECT Peso FROM Pessoa WHERE Sexo='F');

-- SELECT-FROM-WHERE | UNION​ ​ou​ ​INTERSECT​ ​ou​ ​MINUS
SELECT Cpf_p FROM Enfermeiro UNION (SELECT Cpf_p FROM Doador);

-- SELECT-FROM-WHERE | CREATE​ ​VIEW
CREATE VIEW Doacoes_Solicitacoes AS SELECT ED.Cpf_e, ED.Cpf_d, S.Cnpj_b, S.Cnpj_h, ED.Data_coleta, S.Data_solicitacao FROM Enfermeiro_Doador ED LEFT OUTER JOIN Solicita S ON ED.cpf_e=S.cpf_e AND ED.cpf_d=S.cpf_d;

-- GRANT​ ​/​ ​REVOKE
GRANT SELECT ON Pessoa TO PUBLIC;
REVOKE SELECT ON Pessoa TO PUBLIC;

-- CREATE​ ​PROCEDURE | %TYPE | EXCEPTION​ ​​ ​​ ​WHEN
CREATE OR REPLACE PROCEDURE GetPessoaByCpf(
    p_cpf IN Pessoa.cpf%TYPE
) IS
    v_cpf Pessoa.cpf%TYPE;
    v_nome Pessoa.nome%TYPE;
    v_email Pessoa.email%TYPE;
BEGIN
    SELECT Cpf, Nome, Email INTO v_cpf, v_nome, v_email FROM Pessoa WHERE Cpf=p_cpf;
    dbms_output.put_line('Cpf: ' || v_cpf || 'Nome: ' || v_nome || ' Email: ' || v_email);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('Usuário não encontrado');
END GetPessoaByCpf;

-- %ROWTYPE | CURSOR​ | LOOP​ | FETCH
DECLARE
    PessoaRow Pessoa%ROWTYPE;
    CURSOR c_pessoas_homens IS SELECT * FROM Pessoa WHERE Sexo='M';
BEGIN
    OPEN c_pessoas_homens;
    LOOP
        FETCH c_pessoas_homens INTO PessoaRow;
        EXIT WHEN c_pessoas_homens%NOTFOUND;
        dbms_output.put_line('Nome: ' || PessoaRow.nome || ' CPF: ' || PessoaRow.cpf );
    END LOOP;
END;

-- ​TABLE | FOR
DECLARE
    PessoaRow Pessoa%ROWTYPE;
    TYPE PessoasTable IS TABLE OF PessoaRow%ROWTYPE INDEX BY BINARY_INTEGER;
    Pessoas PessoasTable;

    CURSOR c_pessoas IS SELECT * FROM Pessoa WHERE Peso>70;
    table_index NUMBER := 0;
BEGIN
    FOR PessoaRow IN c_pessoas LOOP
        Pessoas(table_index) := PessoaRow;
        table_index := table_index + 1;
    END LOOP;

    FOR table_i iN 0..table_index-1 LOOP
        dbms_output.put_line('Nome: ' || Pessoas(table_i).nome || ' CPF: ' || Pessoas(table_i).cpf );
    END LOOP;
END;

-- RECORD
DECLARE
    TYPE PessoaRow IS RECORD (cpf Pessoa.cpf%TYPE, nome Pessoa.nome%TYPE, email Pessoa.email%TYPE);
    PessoaSelected PessoaRow;
BEGIN
    SELECT Cpf, Nome, Email INTO PessoaSelected FROM Pessoa WHERE Cpf='13384332458';
    dbms_output.put_line('Cpf: ' || PessoaSelected.cpf || ' Nome: ' || PessoaSelected.nome || ' Email: ' || PessoaSelected.email);
END;

-- PACKAGE | FUNCTION
CREATE OR REPLACE PACKAGE PessoasHelper AS
    TYPE DoadoresTable IS TABLE OF Doador%ROWTYPE INDEX BY BINARY_INTEGER;
    FUNCTION GetPessoasByTipoSangue(v_tipo_sang IN Doador.tipo_sang%TYPE) RETURN DoadoresTable;
    FUNCTION GetSanguesParaTipo(v_tipo_sang_receptor IN Doador.tipo_sang%TYPE) RETURN DoadoresTable;
END PessoasHelper;

CREATE OR REPLACE PACKAGE BODY PessoasHelper AS
    FUNCTION GetPessoasByTipoSangue(
        v_tipo_sang IN Doador.tipo_sang%TYPE
    ) RETURN DoadoresTable IS
        doadorRow Doador%ROWTYPE;
        doadores DoadoresTable;
        CURSOR c_doadores IS SELECT * FROM Doador WHERE tipo_sang=v_tipo_sang;
        table_i NUMBER := 0;
    BEGIN
        FOR doadorRow IN c_doadores LOOP
            doadores(table_i) := doadorRow;
            table_i := table_i + 1;
        END LOOP;
        RETURN doadores;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('Usuário não encontrado');
    END GetPessoasByTipoSangue;

    FUNCTION GetSanguesParaTipo(
        v_tipo_sang_receptor IN Doador.tipo_sang%TYPE
    ) RETURN DoadoresTable IS
        table_i NUMBER := 0;
        doadorRow Doador%ROWTYPE;
        doadoresCompativeis DoadoresTable;

        CURSOR c_ab_pos IS SELECT * FROM Doador WHERE tipo_sang=SOME('A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-');
        CURSOR c_ab_neg IS SELECT * FROM Doador WHERE tipo_sang=SOME('A-', 'B-', 'O-', 'AB-');
        CURSOR c_a_pos IS SELECT * FROM Doador WHERE tipo_sang=SOME('A-', 'A+', 'O-', 'O+');
        CURSOR c_a_neg IS SELECT * FROM Doador WHERE tipo_sang=SOME('A-', 'O-');
        CURSOR c_b_pos IS SELECT * FROM Doador WHERE tipo_sang=SOME('B-', 'B+', 'O-', 'O+');
        CURSOR c_b_neg IS SELECT * FROM Doador WHERE tipo_sang=SOME('O-', 'B-');
        CURSOR c_o_pos IS SELECT * FROM Doador WHERE tipo_sang=SOME('O-', 'O+');
        CURSOR c_o_neg IS SELECT * FROM Doador WHERE tipo_sang=SOME('O-');

    BEGIN
        CASE v_tipo_sang_receptor
            WHEN 'AB+' THEN
                FOR doadorRow IN c_ab_pos LOOP
                    doadoresCompativeis(table_i) := doadorRow;
                    table_i := table_i + 1;
                END LOOP;

            WHEN 'AB-' THEN
                FOR doadorRow IN c_ab_neg LOOP
                    doadoresCompativeis(table_i) := doadorRow;
                    table_i := table_i + 1;
                END LOOP;

            WHEN 'A+' THEN
                FOR doadorRow IN c_a_pos LOOP
                    doadoresCompativeis(table_i) := doadorRow;
                    table_i := table_i + 1;
                END LOOP;
            WHEN 'A-' THEN
                FOR doadorRow IN c_ab_neg LOOP
                    doadoresCompativeis(table_i) := doadorRow;
                    table_i := table_i + 1;
                END LOOP;
            WHEN 'B+' THEN
                FOR doadorRow IN c_b_pos LOOP
                    doadoresCompativeis(table_i) := doadorRow;
                    table_i := table_i + 1;
                END LOOP;
            WHEN 'B-' THEN
                FOR doadorRow IN c_b_neg LOOP
                    doadoresCompativeis(table_i) := doadorRow;
                    table_i := table_i + 1;
                END LOOP;
            WHEN 'O+' THEN
                FOR doadorRow IN c_o_pos LOOP
                    doadoresCompativeis(table_i) := doadorRow;
                    table_i := table_i + 1;
                END LOOP;
            WHEN 'O-' THEN
                FOR doadorRow IN c_o_neg LOOP
                    doadoresCompativeis(table_i) := doadorRow;
                    table_i := table_i + 1;
                END LOOP;
        END CASE;

        RETURN doadoresCompativeis;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            dbms_output.put_line('Sangue não encontrado');
    END GetSanguesParaTipo;

END PessoasHelper;

-- WHILE
DECLARE
    PessoaRow Pessoa%ROWTYPE;
    doadores_t PessoasHelper.DoadoresTable;
    index_d NUMBER := 0;
BEGIN
    doadores_t := PessoasHelper.GetPessoasByTipoSangue('O+');

    WHILE index_d < doadores_t.COUNT LOOP
        dbms_output.put_line('CPF: ' || doadores_t(index_d).cpf_p || ' Tipo Sang: ' || doadores_t(index_d).tipo_sang);
        index_d := index_d + 1;
    END LOOP;
END;

-- IF | ELSE IF
DECLARE
    num_doadores_universais NUMBER := 0;
BEGIN
    SELECT COUNT(*) INTO num_doadores_universais FROM Doador WHERE tipo_sang='O-';
    IF num_doadores_universais != 0 THEN
        dbms_output.put_line('Temos ' || num_doadores_universais || ' doadores universais disponíveis.');
    ELSIF num_doadores_universais = 0 THEN
        dbms_output.put_line('Não temos doadores universais disponíveis.');
    END IF;
END;

-- ​TRIGGER​ DE LINHA
CREATE OR REPLACE TRIGGER Sangue_Doado AFTER INSERT ON Solicita FOR EACH ROW
DECLARE
    d_cpf_e Enfermeiro_Doador.cpf_e%TYPE;
    d_cpf_d Enfermeiro_Doador.cpf_d%TYPE;
    d_data_coleta Enfermeiro_Doador.data_coleta%TYPE;
BEGIN
    d_cpf_e := :new.cpf_e;
    d_cpf_d := :new.cpf_d;
    d_data_coleta := :new.data_coleta;

    UPDATE Enfermeiro_Doador SET Solicitado='S' WHERE cpf_e=d_cpf_e AND cpf_d=d_cpf_d AND data_coleta=d_data_coleta;
END Sangue_Doado;

-- TRIGGER DE COMANDO
CREATE OR REPLACE TRIGGER qtdDePessoas AFTER DELETE ON Pessoa
DECLARE
v_qtdPessoa INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_qtdPessoa FROM Pessoa;
    DBMS_OUTPUT.PUT_LINE('Há agora '|| v_qtdPessoa || ' pessoa(s) na tabela Pessoa.');
END qtdDePessoas;
