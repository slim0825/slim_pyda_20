select r.rental_date, concat(c.last_name,' ', c.first_name) "name_customer", c.customer_id,
row_number() over (partition by c.customer_id order by r.rental_date) as order_number
from rental r
join customer c on c.customer_id = r.customer_id

select r.customer_id, count(r.rental_id) as rental
from rental r
join inventory i on i.inventory_id = r.inventory_id
join film f on f.film_id = i.film_id
where 'Behind the Scenes' = any(special_features)
group by r.customer_id

create materialized view task1 as 
select r.customer_id, count(r.rental_id) as rental
from rental r
join inventory i on i.inventory_id = r.inventory_id
join film f on f.film_id = i.film_id
where 'Behind the Scenes' = any(special_features)
group by r.customer_id
with data

refresh materialized view task1

select *
from task1

select title, special_features
from film 
where 'Behind the Scenes' = any(special_features)

select title, string_agg(t.unnest, ', ') 
from (select title, unnest(special_features), film_id 
	from film) as t
where t.unnest = 'Behind the Scenes'
group by film_id, title

select title, special_features
from film 
where special_features @> array['Behind the Scenes']