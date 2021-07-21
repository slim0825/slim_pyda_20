select store_id, 
count(customer_id) as customers 
from customer 
group by store_id 
having count(customer_id)>300;

