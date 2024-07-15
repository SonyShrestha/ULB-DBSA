-- To restore database from tar file 
-- Navigate to bin folder
C:\>cd C:\Program Files\PostgreSQL\12\bin
pg_restore -U postgres -d dvdrental C:\sampledb\dvdrental.tar

-- 1. What are the names (first and last) and emails of our customers?
SELECT first_name,last_name,email from customer;


-- 2. How many movies are rated PG-13?
select count(*) from film where rating='PG-13';


-- 3. What is the first name of the staff member that did not store a picture in the database?
select first_name from staff where picture is null; 


-- 4. Who are the customers (first and last name) who returned a DVD on May 27th 2005?
select distinct c.first_name,c.last_name -- distint is needed
from rental r 
join customer c 
on r.customer_id=c.customer_id
where date(r.return_date)='2005-05-27'; 


-- 5. Who is both an actor and a customer?
select a.first_name,a.last_name from actor a 
inner join customer c 
on upper(a.first_name)=upper(c.first_name)
and upper(a.last_name)=upper(c.last_name);

select first_name,last_name from actor
intersect 
select first_name,last_name from customer;


-- 6. Give all pairs of actors with the same last name, ordered by last name.
SELECT a.first_name as actor_1, b.first_name as actor_2, b.last_name as last_name
FROM actor a, actor b
WHERE a.actor_id < b.actor_id AND a.last_name = b.last_name
ORDER BY a.last_name;


-- 7. What are the titles of the movies in which an actor with a last name ending in ’son’ has played?
select f.title 
from film f 
inner join film_actor fa
on f.film_id=fa.film_id
inner join actor a 
on fa.actor_id=a.actor_id
where upper(a.last_name) like '%SON';


-- 8. Who were the 10 first customers to rent a DVD?
select c.first_name, c.last_name from customer c
inner join rental r 
on c.customer_id=r.customer_id
group by c.first_name, c.last_name
order by min(rental_date)
limit 10


-- 9. Who is the customer with the most DVD rentals?
select  c.first_name, c.last_name from customer c
inner join rental r 
on c.customer_id=r.customer_id
group by c.first_name, c.last_name
order by count(r.rental_id) desc
limit 1;


-- 10. Which customers rented at least one DVD lasting 3h or more?
SELECT DISTINCT first_name, last_name
FROM customer c
INNER JOIN rental r 
ON c.customer_id=r.customer_id
INNER JOIN inventory i 
ON r.rental_id=i.inventory_id
INNER JOIN film f 
ON f.film_id=i.film_id
WHERE length >= 180;


