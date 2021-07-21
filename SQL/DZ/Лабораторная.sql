����������� ���������� ����� ���� ��������� �� ������ ����.
������� 1:

select date(p.payment_date), sum(amount)
from payment p
group by date(p.payment_date)
order by date(p.payment_date)

������� 2:

with pds as (
    select cast(payment_date as date) as payment_date, sum(amount) as amount
    from payment
    group by cast(payment_date as date)
)
select payment_date, sum(amount) over (order by payment_date)
from pds
order by payment_date;

2. �������� �������� � �������� �������������� ����� (��, ������� ���������� ����������/���������� ���������� ���), ����� �� ����� ������ � ����� ������*
������� 1:

with trds as(
    select c.name as category_name, count(*) as cnt, sum(p.amount) as sums
    from category c
    join film_category fc using (category_id)
    join film f using (film_id)
    join inventory i using (film_id)
    join rental r using (inventory_id)
    join customer cu using (customer_id)
    join payment p using (rental_id)
    group by category_name
)
select category_name, cnt, sums
from trds 
where cnt = (select max(cnt) from trds) or cnt = (select min(cnt) from trds)

������� 2:

(select '���������� ���-�� ������ - ' || c.name || ' � ������� ' || count(p.rental_id) || ' �� ����� ' || sum(p.amount)
from payment p
inner join rental r on r.rental_id = p.rental_id
inner join inventory i on i.inventory_id = r.inventory_id
inner join film f on f.film_id = i.film_id
inner join film_category fc on fc.film_id = f.film_id
inner join category c on c.category_id = fc.category_id
group by c.name
order by count(p.rental_id) desc
limit 1)
union all
(select '���������� ���-�� ������ - ' || c.name || ' � ������� ' || count(p.rental_id) || ' �� ����� ' || sum(p.amount)
from payment p
inner join rental r on r.rental_id = p.rental_id
inner join inventory i on i.inventory_id = r.inventory_id
inner join film f on f.film_id = i.film_id
inner join film_category fc on fc.film_id = f.film_id
inner join category c on c.category_id = fc.category_id
group by c.name
order by count(p.rental_id) asc
limit 1)

 ������ ������� �������� ������ ��� ������� �����? (����������� �� ��������, ������� �������� ��������� �� �����)**
�������:

select c.name as category_name, round(avg(f.rental_rate/f.rental_duration), 2) as avr
from category c
join film_category fc using (category_id)
join film f using (film_id)
group by c.name
order by avr desc

C�������� ������ �� 5 ��������, ������� ��������� ������ ����� ����� �� ������ ������� � 10 �� 13 ������ ������������.
������ ������: '���_������� �������_������� email address is: e-mail_�������'

������� 1:

select first_name || ' ' || last_name || 's email address is: ' || email as name_and_email
from customer
where customer_id in (
	select customer_id from (
		select distinct customer_id, sum(amount)
		from payment
		where extract(month from payment_date) = 4
		and extract(day from payment_date) between 10 and 14
		group by customer_id
		order by sum(amount) desc
		limit 5
		) as top_five
	);

������� 2:

select c.first_name || ' ' || c.last_name || ' email address is: ' || c.email as clients_list
from customer c
inner join payment p on p.customer_id = c.customer_id 
    and p.payment_date between '20070410' and '20070413'::date + interval '1 day'
group by c.first_name, c.last_name, c.email
order by sum(p.amount) desc
limit 5

������� 3:

select
	first_name,
	last_name,
	concat('email address is ', email) as email
from
	payment as r
inner join 
    customer using (customer_id)
where 
    payment_date::date between '2007-04-10' and '2007-04-13'::date + interval '1 day'
group by 
    first_name, last_name, email
order by 
    sum(amount) desc
limit 5;
������� 4:

select ci.first_name, ci.last_name, concat('email address is:' ,ci.email) from customer as ci
inner join (
    select pay.customer_id, sum(pay.amount) 
    from payment as pay
    where pay.payment_date between '2007-04-10' and '2007-04-13'::date + interval '1 day'
    group by pay.customer_id
    order by sum(pay.amount) desc limit 5) as top on top.customer_id = ci.customer_id;
������� 5:

select
format('%s %s email address is: %s', b.first_name, b.last_name, b.email) as "������ ��������"
from customer b
inner join rental a on b.customer_id = a.customer_id
inner join payment c on a.rental_id = c.rental_id
where date(c.payment_date) <= '2007-04-13'::date + interval '1 day' and date(c.payment_date) >= '2007-04-10'
group by b.first_name, b.last_name, b.email
order by sum(c.amount) desc
limit 5;

 ������� ������������ ������� ���� ���������� � ����, �� ����� �������� � �����, �������� ������������ ������� �� ������?
�������������: ������� ���������� ������ � ���� ��������� ���������� ���������

������� 1:

with rdt as (
    select inventory_id, date_part('day', return_date - rental_date) as ddate
    from rental
),
sttbl as (
    select abs(rental_duration - ddate) as absdif,
    case 
        when rental_duration > ddate then '������'
        when rental_duration = ddate then '� ����'
        else '�����'
    end as status
    from film f
    join inventory i using (film_id)
    join rdt using (inventory_id)
)
select status, count(*) as cnt, round(max(absdif)) as maxdif
from sttbl
group by status
order by cnt, maxdif desc

������� 2:

with rental_scheme as (
select
	rental_id,
	rental_duration as dur,
	extract(day from return_date - rental_date) as back
from
	rental as r
	left join inventory as i using (inventory_id)
	left join film as f using (film_id)
)
select
	count(case when back = dur then rental_id else null end) as return_in_line,
	count(case when back < dur then rental_id else null end) as return_before_line,
	count(case when back > dur then rental_id else null end) as return_after_line,
	max(back - dur) as max_late_return
from
	rental_scheme


