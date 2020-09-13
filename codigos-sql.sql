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

-- Selecionando as informações dos setores e funcionários
select idSetor,nomeSetor,descricaoSetor from setor;
select nomeFuncionario, nascimento from funcionario where idFuncionario = 1;

-- Retorna os funcionários por ordem descrescente de saláro.
select idFuncionario,nomeFuncionario, nascimentoFuncionario, salarioFuncionario
from funcionario
order by salarioFuncionario desc;

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

