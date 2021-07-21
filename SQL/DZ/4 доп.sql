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
(1, 'Иванов Иван', 'Вано', '05-06-1985'),
(2, 'Пётр Петров', 'Петька', '10-01-1976'),
(3, 'Александр Александров', 'Санёк', '11-10-1983')

alter table avtor add column birthplace VARCHAR(50)

update avtor 
set birthplace = 'Moscow'
where id = 1


create table Произведения
(
id serial not null,
год int,
название VARCHAR(255) not null,
foreign key (id serial) references avtor (id serial)
)

drop table Произведения

insert into Произведения
values
(1, 2002, 'Полёт шмеля'),
(3, 2010, 'Готовка для чайников'
)

 select *
 from Произведения
