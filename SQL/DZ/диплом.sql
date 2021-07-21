select a.aircraft_code,
       a.model,
       s.seat_no,
       s.fare_conditions
from aircrafts a
join seats s on a.aircraft_code = s.aircraft_code 
where a.model = 'Cessna 208 Caravan'
order by s.seat_no

select s2.aircraft_code,
       string_agg (s2.fare_conditions || '(' || s2.num::text || ')', ', ') as fare_conditions
from   (
       select s.aircraft_code, s.fare_conditions, count(seat_no) as num
       from seats s
       group by s.aircraft_code, s.fare_conditions
       order by s.aircraft_code, s.fare_conditions
       ) s2
group by s2.aircraft_code
order by s2.aircraft_code


select a.airport_code as code,
       a.airport_name,
       a.city,
       a.longitude,
       a.latitude,
       a.timezone
from   airports a
where  a.city in (
          select   aa.city
          from     airports aa
          group by aa.city
          having   count(*) > 1
          )
order by a.city, a.airport_code

select r.arrival_city as city,
       r.arrival_airport as airport_code,
       r.arrival_airport_name as airport_name,
       r.days_of_week,
       r.duration
from   routes r
where  r.departure_city = 'Волгоград'

select bookings.now() as now

select status,
       count(*) as count,
       min(scheduled_departure) as min_scheduled_departure,
       max(scheduled_departure) as max_scheduled_departure
from flights
group by status 
order by min_scheduled_departure

select   f.*
from     flights_v f
where    f.departure_city = 'Екатеринбург'
and      f.arrival_city = 'Москва'
and      f.scheduled_departure > bookings.now()
order by f.scheduled_departure
limit    1

select *
from bookings
order by total_amount desc
limit 10

select ticket_no,
       passenger_id,
       passenger_name
from   tickets
where  book_ref = '521C53'

select    to_char(f.scheduled_departure, 'DD.MM.YYYY') as when,
          f.departure_city || '(' || f.departure_airport || ')' as departure,
          f.arrival_city || '(' || f.arrival_airport || ')' as arrival,
          tf. fare_conditions as class,
          tf.amount
from      ticket_flights tf
          join flights_v f on tf.flight_id = f.flight_id 
where     tf.ticket_no = '0005432661915'
order by  f.scheduled_departure 

select    to_char(f.scheduled_departure, 'DD.MM.YYYY') as when,
          f.departure_city || '(' || f.departure_airport || ')' as departure,
          f.arrival_city || '(' || f.arrival_airport || ')' as arrival,
          f.status,
          bp.seat_no
from      ticket_flights tf
          join flights_v f on tf.flight_id = f.flight_id
          left join boarding_passes bp on tf.flight_id = bp.flight_id
                                      and tf.ticket_no = bp.ticket_no
where     tf.ticket_no = '0005432661915'
order by  f.scheduled_departure

begin;

insert into bookings (book_ref, book_date, total_amount)
values      ('_QWE12', bookings.now(), 0);

insert into tickets (ticket_no, book_ref, passenger_id, passenger_name)
values      ('_000000000001', '_QWE12', '1749 051790', 'ALEKSANDR RADISHCHEV')

insert into ticket_flights (ticket_no, flight_id, fare_conditions, amount)
values     ('_000000000001', 9720, 'Business', 0),
           ('_000000000001', 6662, 'Business', 0)
           
commit;

select   b.book_ref,
         t.ticket_no,
         t.passenger_id,
         t.passenger_name,
         tf.fare_conditions,
         tf.amount,
         f.scheduled_departure_local,
         f.scheduled_arrival_local,
         f.departure_city || '(' || f.departure_airport || ')' as departure,
         f.arrival_city || '(' || f.arrival_airport || ')' as arrival,
         f.status,
         bp.seat_no
from bookings b
     join tickets t on b.book_ref = t.book_ref 
     join ticket_flights tf on tf.ticket_no = t.ticket_no 
     join flights_v f on tf.flight_id = f.flight_id 
     left join boarding_passes bp on tf.flight_id = bp.flight_id 
                                 and tf.ticket_no = bp.ticket_no 
where     b.book_ref = '_QWE12'
order by  t.ticket_no , f.scheduled_departure 