select first_name, last_name, city
from customer 
inner join address
on customer.address_id = address.address_id
inner join city on address.city_id = city.city_id;


select first_name, last_name, city
from customer c
join address a
on c.address_id = a.address_id
join city cy
on a.city_id = cy.city_id;
