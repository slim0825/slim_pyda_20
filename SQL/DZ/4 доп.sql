create table avtor
(
id serial PRIMARY KEY,
full_name VARCHAR(100),
nickname VARCHAR(100),
birthday DATE NOT NULL
);

select *
from avtor

insert into avtor 
values
(1, '������ ����', '����', '05-06-1985'),
(2, 'ϸ�� ������', '������', '10-01-1976'),
(3, '��������� �����������', '����', '11-10-1983')

alter table avtor add column birthplace VARCHAR(50)

update avtor 
set birthplace = 'Moscow'
where id = 1


create table ������������
(
id serial not null,
��� int,
�������� VARCHAR(255) not null,
foreign key (id serial) references avtor (id serial)
)

drop table ������������

insert into ������������
values
(1, 2002, '���� �����'),
(3, 2010, '������� ��� ��������'
)

 select *
 from ������������
