use sakila;

-- 2a.

Select actor_id, first_name, last_name from actor
where first_name = "JOE";

-- 2b.

Select first_name, last_name from actor
where last_name like "%GEN%";

-- 2c.

Select first_name, last_name from actor
where last_name like "%LI%"
order by last_name, first_name;

-- 2d. 

Select country_id, country from country
where country in ("Afghanistan", "Bangladesh", "China");