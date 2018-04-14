use sakila;

-- 7a
 
select title from film
where (title like "Q%" or  title like "K%") and
`language_id` =
	(select language_id from language
	where `name` = "English");
    
-- 7b



select first_name, last_name from actor
where actor_id in 
(select actor_id from film_actor
where film_id =
	(select film_id from film
	where title = "Alone Trip")
);

-- 7c
select first_name, last_name, email, country from
	(select first_name, last_name, email, country from customer
	join
		(select address_id, country from address
		join
			(select city_id, country from city
			join
			country 
			on city.country_id = country.country_id) as z
		on address.city_id = z.city_id) as zz
	on customer.address_id = zz.address_id) as zzz
where country = "Canada";

-- 7d


select title from film
where film_id in 
	(select film_id from film_category
	where film_category.category_id = 
		(select category_id from category
		where name = "Family")
	);

-- 7e

select title, Rentals from film
join 
	(select film_id, SUM(`COUNT(inventory_id)`) as Rentals from
		(select film_id, `COUNT(inventory_id)`, inventory_id from inventory
		join
			(select inventory_id as id, COUNT(inventory_id) from rental
			group by inventory_id) as z
		on inventory_id = z.id) as zz
	group by film_id) as zzz
on film.film_id = zzz.film_id
order by Rentals desc; 

-- 7f


select store_id, SUM(Revenue) as `Total Revenue` from
	(select store_id, `SUM(amount)` as Revenue from inventory
	join
			(select inventory_id as id, SUM(amount) from 
				(select amount, payment.rental_id, inventory_id from payment
				join 
				rental
				on payment.rental_id = rental.rental_id)as z
			group by inventory_id) as zz
	on inventory.inventory_id = zz.id) as zzz
group by store_id
order by `Total Revenue`
;

-- 7g

select store_id, city, country from country
join
	(select store_id, city.city, country_id from city
	join 
		(select store_id, city_id as city from store
		join 
		address
		on store.address_id = address.address_id)as z
	on city.city_id = z.city) as zz
on country.country_id = zz.country_id;

-- 7h

select `name` as Category, SUM(amount) as Revenue from
(select amount, `name` from
	(select amount, category_id from
		(select amount, invpay.inventory_id, film_id from
			(select amount, inventory_id from payment
			join
			rental
			on payment.rental_id = rental.rental_id) as invpay
		join 
		inventory
		on invpay.inventory_id = inventory.inventory_id) as filmpay
	join
	film_category
	on filmpay.film_id = film_category.film_id) as catpay
join 
category
on catpay.category_id = category.category_id) as finaltable
group by `name`
order by Revenue desc limit 5;










		
	



