create table avtor
(
id serial PRIMARY KEY,
full_name VARCHAR(100),
nickname VARCHAR(100),
birthday TIMESTAMP NOT NULL
);

select *
from avtor