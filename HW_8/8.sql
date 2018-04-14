-- 8a

Create View `Top_Genre` as 
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

-- 8b

select * from top_genre;

-- 8c

drop view top_genre;
