-- 6a

select first_name, last_name, address from staff
join address
on staff.address_id = address.address_id;

-- 6b


select first_name, last_name, `SUM(amount)` from 
	(select * from staff
	join
		(select staff_id as staff_id2, SUM(amount)  from payment
		where payment_date like "2005-08%"
		group by staff_id) as x 
	on staff.staff_id = x.staff_id2) as y;
    
    
-- 6c

select title, actors from film
inner join
	(select film_id as f, COUNT(film_id) as actors
	from film_actor
	group by film_id) as x
on film.film_id = x.f;

-- 6d

Select COUNT(*) as Copies from
	(select * from inventory
	where film_id = 
	(select film_id from film
	where title = "Hunchback Impossible")) as x;

-- 6e

(select first_name, last_name, `SUM(amount)` as `Customer Payment` from customer
join
	(select customer_id as Cid, SUM(amount) from payment 
	group by customer_id) as x
on customer.customer_id = x.Cid) 
order by last_name;
