/*CRIANDO UM BANCO DE DADOS SIMPLES PARA RELEMBRAR ALGUNS COMANDOS */


/*---------------------------------------- Criação das tabelas e as suas respectivas inserções ----------------------------------------*/
create table setor(idSetor int primary key, nomeSetor varchar(100), descricaoSetor varchar(100));

-- Criação da sequence idSetor
create sequence idSetor minvalue 1 start with 1;

-- Inserção dos setores
insert into setor(idSetor, nomeSetor, descricaoSetor) 
values(idSetor.nextval, 'Marketing', 'Setor responsável pelo marketing da empresa');
insert into setor(idSetor, nomeSetor, descricaoSetor) 
values(idSetor.nextval, 'Financeiro', 'Setor responsável pelo financeiro da empresa');
insert into setor(idSetor, nomeSetor, descricaoSetor) 
values(idSetor.nextval, 'Administrativo', 'Setor responsável pela administração da empresa');
insert into setor(idSetor, nomeSetor, descricaoSetor) 
values(idSetor.nextval, 'RH', 'Setor responsável pelo RH da empresa');
insert into setor(idSetor, nomeSetor, descricaoSetor) 
values(idSetor.nextval, 'TI', 'Setor responsável pelo TI da empresa');

-- Criação da tabela setor
create table funcionario(idFuncionario int primary key, nomeFuncionario varchar(50), nascimentoFuncionario date, salarioFuncionario decimal(10,2), id_setor int);

-- Criação da chave estrangeira da tabela funcionario nomeando a sua constraint
alter table funcionario 
add constraint fk_funcionario_setor
foreign key(id_setor) references setor(idSetor);

-- Criação da sequence idFuncionario
create sequence idFuncionario minvalue 1 start with 1;

-- Inserção dos funcionarios
insert into funcionario(idFuncionario, nomeFuncionario, nascimentoFuncionario, salarioFuncionario, id_setor)
values(idFuncionario.nextval, 'Vinicius', '18/07/2001', 4607.63, 5);
insert into funcionario(idFuncionario, nomeFuncionario, nascimentoFuncionario, salarioFuncionario, id_setor)
values(idFuncionario.nextval, 'Fernando', '21/03/1999', 1233.43, 2);
insert into funcionario(idFuncionario, nomeFuncionario, nascimentoFuncionario, salarioFuncionario, id_setor)
values(idFuncionario.nextval, 'Matheus', '01/04/1987', 6868.57, 4);
insert into funcionario(idFuncionario, nomeFuncionario, nascimentoFuncionario, salarioFuncionario, id_setor)
values(idFuncionario.nextval, 'Rodrigo', '23/11/1998', 4363.64, 2);
insert into funcionario(idFuncionario, nomeFuncionario, nascimentoFuncionario, salarioFuncionario, id_setor)
values(idFuncionario.nextval, 'Astolfo', '08/01/1976', 1244.00, 3);
insert into funcionario(idFuncionario, nomeFuncionario, nascimentoFuncionario, salarioFuncionario, id_setor)
values(idFuncionario.nextval, 'Frederico', '12/07/2000', 4607.63, 1);


/*---------------------------------------- Select ----------------------------------------*/

-- Selecionando as informações dos setores e funcionários
select idSetor,nomeSetor,descricaoSetor from setor;
select nomeFuncionario, nascimento from funcionario where idFuncionario = 1;

-- Retorna os funcionários por ordem descrescente de saláro.
select idFuncionario,nomeFuncionario, nascimentoFuncionario, salarioFuncionario
from funcionario
order by salarioFuncionario desc;

-- Retorna o salario de funcionários > 3000 e seus respectivso setores.
select f.nomeFuncionario, s.nomeSetor, f.salarioFuncionario
from funcionario f
inner join setor s
on idSetor = id_setor
where salarioFuncionario > 3000;

-- Retorna o salario dos funcionários que estejam entre 1200 e 3000 e seus respectivos setores.
select f.nomeFuncionario, s.nomeSetor, f.salarioFuncionario
from funcionario FALSE
inner join setor s
on idSetor = id_setor
where salarioFuncionario between 1500 and 3000;

-- Retorna o salario dos funcionários do departamento de TI
select idFuncionario,nomeFuncionario, nascimentoFuncionario, salarioFuncionario
from funcionario
where id_setor = 5;

-- Retorna as informações dos funcionários que começam com a letra V
select idFuncionario,nomeFuncionario, nascimentoFuncionario, salarioFuncionario
from funcionario
where nomeFuncionario like "V%";

-- Retorna os funcionários cujo nascimento tenha sido depois de 01/01/2001.
select nomeFuncionario, nascimentoFuncionario
from funcionario
where nascimentoFuncionario >= '01/01/2001';

/*---------------------------------------- Funções de agregação ----------------------------------------*/

--Retorna o funcionario com o maior salario com a função max().
select idFuncionario, nomeFuncionario, nascimentoFuncionario,salarioFuncionario 
from funcionario 
where salarioFuncionario = (select max(salarioFuncionario) from funcionario);

--Retorna o segundo maior salário da tabela funcionario com a função max().
select max(salarioFuncionario)
from funcionario
where salarioFuncionario not in (select max(salarioFuncionario) from funcionario);


-- Retorna a média de salário dentre os funcionários com a função avg().
select round(avg(salarioFuncionario), 2) as "Media de salario"
from funcionario;

-- Retorna a folha salarial de cada setor com a função sum().
select f.id_setor, s.nomeSetor, sum(f.salarioFuncionario)
from funcionario f
inner join setor s
on f.id_setor = s.idSetor
group by f.id_setor, s.nomeSetor
order by f.id_setor asc;

-- Retorna o funcionario com menor salario com a função min().

select idFuncionario, nomeFuncionario, nascimentoFuncionario, salarioFuncionario
from funcionario
where salarioFuncionario = (select min(salarioFuncionario) from funcionario);

-- Retorna a quantidade de funcionários registrados com a função count().
select count(idFuncionario) as "Quantidade de funcionarios registrados"
from funcionario;

-- Verifica se existe salários repetidos e retorna o salário e quantas pessoas o recebem.
select salarioFuncionario, count(idFuncionario)
from funcionario
group by salarioFuncionario
having count(idFuncionario)>1;

/*---------------------------------------- Trabalhando um pouco com datas ----------------------------------------*/

-- Utilizando a função TO_CHAR(variavel, 'modeloDeData') para personalizar o modelo da data.
select nomeFuncionario as "Funcionario", TO_CHAR(nascimentoFuncionario, 'MM/DD/YY') as "Data"
from funcionario;

select nomeFuncionario as "Funcionario", TO_CHAR(nascimentoFuncionario, "YY/MM/DD") as "Data"
from funcionario;

select nomeFuncionario as "Funcionario", TO_CHAR(nascimentoFuncionario, 'DD/MM/YY') as "Data" 
from funcionario;

-- Retorna o dia e o mês por escrito.
select nomeFuncionario as "Funcionario", TO_CHAR(nascimentoFuncionario, 'Day Month, YYYY') as "Data" --CASE SENSITIVE
from funcionario;

select nomeFuncionario as "Funcionario", TO_CHAR(nascimentoFuncionario, 'Month, DD/YYYY') as "Data" 
from funcionario;

select nomeFuncionario as "Funcionario", TO_CHAR(nascimentoFuncionario, 'Month Day Year') as "Data" 
from funcionario;

select nomeFuncionario as "Funcionario", TO_CHAR(nascimentoFuncionario, 'DD, Month, YYYY') as "Data" 
from funcionario;

-- Retorna o nome do dia/mês/ano

select TO_CHAR(nascimentoFuncionario, 'Day') as "Dia do nascimento"
from funcionario;

select TO_CHAR(nascimentoFuncionario, 'Month') as "Mês de nascimento"
from funcionario;

select TO_CHAR(nascimentoFuncionario, 'Year') as "Ano de nascimento"
from funcionario;

-- Coleta a data atual e trás a data do proximo dia mencionado.

select SYSDATE, NEXT_DAY(SYSDATE, 'Domingo') as "Proximo domingo" --SYSDATE retorna a data atual do sistema.
from DUAL;

-- Adiciona uma quantidade de meses a data atual.

select nascimentoFuncionario, ADD_MONTH(7,nascimentoFuncionario) --Neste caso foi adicionado 7 meses a data atual.
from funcionario;

-- Retorna o ultimo dia do mês.

select nascimentoFuncionario, LAST_DAY(nascimentoFuncionario) as "ULTIMO DIA DO MES"
from funcionario;

-- Retorna a idade do funcionário com base na sua data de nascimento

select nascimentoFuncionario, TRUNC(MONTHS_BETWEEN(SYSDATE, nascimentoFuncionario)/12) as "Idade"
from funcionario;

-- Extrai o dia/mês/ano 

select nascimentoFuncionario, EXTRACT(DAY from nascimentoFuncionario) as "Mês"
from funcionario;

select nascimentoFuncionario, EXTRACT(MONTH from nascimentoFuncionario) as "Mês"
from funcionario;

select nascimentoFuncionario, EXTRACT(YEAR from nascimentoFuncionario) as "Mês"
from funcionario;


/*---------------------------------------- Trigger ----------------------------------------*/

-- Criação da tabela de bkp
create table bkpFuncionario(idBpkFuncionario int primary key, nomeFuncionario varchar(50), nascimentoFuncionario date, salarioFuncionario decimal(10,2), idBkp_setor int);

-- Criação da trigger trg_bkpfunc.
create or replace trigger trg_bkpfunc
after insert on funcionario -- Antes do funcionário vem o schema do banco, caso não seja passado nenhum valor, o banco tratará o schema default.
for each row
begin
    insert into bkpFuncionario(idBpkFuncionario, nomeFuncionario, nascimentoFuncionario, salarioFuncionario, idBkp_setor)
    values(:new.idFuncionario, :new.nomeFuncionario, :new.nascimentoFuncionario, :new.salarioFuncionario, :new.id_setor);
end;

-- Criação da trigger trg_erros. 
create or replace trigger trg_erros
before insert on funcionario
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
BEGIN
    IF :new.salarioFuncionario > 10000 THEN
        RAISE_APPLICATION_ERROR(-20001,'Salario deve ser menor');
    END IF;
end;
/

-- Inserção de um novo funcionário para verificar se a trigger esta funcionando.
insert into funcionario(idFuncionario, nomeFuncionario, nascimentoFuncionario, salarioFuncionario, id_setor)
values(idFuncionario.nextval, 'Fernando', '10/02/1996', 4845.00, 5);

-- Links para tirar dúvidas sobre a sintaxe de triggers.
/*http://www.linhadecodigo.com.br/artigo/2821/trigger-oracle-basico.aspx
https://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_7004.htm*/


/*---------------------------------------- View ----------------------------------------*/

create or replace view vFullRelatorio 
as
    select f.idFuncionario, f.nomeFuncionario, f.nascimentoFuncionario, f.salarioFuncionario, f.id_setor, s.nomeSetor, s.descricaoSetor
    from funcionario f
    inner join setor s
    on s.idSetor = f.id_setor;

-- Links para tirar dúvidas sobre a sintaxe da view: https://www.devmedia.com.br/criando-visoes-views-no-oracle/1945

/*---------------------------------------- BLOCO ANONIMO ----------------------------------------*/

DECLARE 
    V_NM_FUNCIONARIO funcionario.nomeFuncionario%Type; -- Responsável por pegar o tipo da variavel: varchar/char/int e etc.
BEGIN
    SELECT nomeFuncionario
    INTO V_NM_FUNCIONARIO
    FROM funcionario
    WHERE idFuncionario = 1;
END;

/*---------------------------------------- PROCEDURE ----------------------------------------*/

-- Criação da procedure.
CREATE OR REPLACE PROCEDURE SP_FUNC(V_NM_FUNCIONARIO VARCHAR2)
IS -- Declaração das variaveis.
    V_NM_FUNCIONARIO funcionario.nomeFuncionario%Type;
BEGIN
    SELECT nomeFuncionario
    INTO V_NM_FUNCIONARIO
    FROM funcionario
    WHERE idFuncionario = 1;
END;

-- Métodos para chamar a procedure.
EXECUTE SP_FUNC; -- Utilizando um execute.

BEGIN -- Utilizando um bloco pl/sql.
    SP_FUNC;
END;


-- Como apagar uma procedure

DROP PROCEDURE SP_FUNC;