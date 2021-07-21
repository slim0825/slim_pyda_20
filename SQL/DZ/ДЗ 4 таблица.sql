create table table1 (
	language_id serial primary key,
	language varchar(50) not null)	
	
select *
from table1

insert into table1 (language)
values 
('English'),
('French'),
('Spanish'),
('Russian'),
('Chinese')

create table table2 (
	nationality_id serial primary key,
	nationality varchar(50) not null)
	
insert into table2 (nationality)
values 
('English'),
('French'),
('Spanish'),
('Russian'),
('Chinese')

select *
from table2

create table table3 (
	countries_id serial primary key,
	countries varchar(50) not null)
	
insert into table3 (countries)
values 
('USA'),
('France'),
('Spain'),
('Russia'),
('China')

select *
from table3
	
CREATE TABLE lang_nation (
	language_id int2 NOT NULL,
	nationality_id int2 NOT NULL,
	CONSTRAINT lang_nation_pkey PRIMARY KEY (language_id, nationality_id),
	CONSTRAINT lang_nation_language_id_fkey FOREIGN KEY (language_id) REFERENCES table1(language_id),
	CONSTRAINT lang_nation_nationality_id_fkey FOREIGN KEY (nationality_id) REFERENCES table2(nationality_id)
);

select *
from lang_nation

CREATE TABLE nation_country (
	nationality_id int2 NOT NULL,
	countries_id int2 NOT NULL,
	CONSTRAINT nation_country_pkey PRIMARY KEY (nationality_id, countries_id),
	CONSTRAINT nation_country_nationality_id_fkey FOREIGN KEY (nationality_id) REFERENCES table2(nationality_id),
	CONSTRAINT nation_country_countries_id_fkey FOREIGN KEY (countries_id) REFERENCES table3(countries_id)
);

select *
from nation_country


CREATE TABLE lang_nation1 (
PRIMARY KEY (language_id, nationality_id),
	language_id int2 references table1(language_id),
	nationality_id int2 references table2(nationality_id)
	)
	
CREATE TABLE nation_country1 (
PRIMARY KEY (nationality_id, countries_id),
	nationality_id int2 references table2(nationality_id),
	countries_id int2 references table3(countries_id)
	)
	
insert into lang_nation (language_id, nationality_id) 
values
(1, 1),
(1, 2),
(2, 2),
(2, 1),
(3, 3),
(3, 1),
(4, 4),
(5, 5)

insert into nation_country (nationality_id, countries_id)
values 
(1, 1),
(2, 2),
(2, 1),
(3, 3),
(3, 1),
(4, 4),
(5, 5),
(5, 1),
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(2, 2),
(3, 3),
(1, 3),
(4, 4),
(5, 5),
(5, 1)

insert into nation_country (nationality_id, countries_id)
values 
(1, 1),
(2, 2),
(2, 1),
(3, 3),
(3, 1),
(4, 4),
(5, 5),
(5, 1)

insert into nation_country (countries_id, nationality_id)
values 
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(5, 1)
	