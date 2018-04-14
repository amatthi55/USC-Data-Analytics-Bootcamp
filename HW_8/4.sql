use sakila;

-- 4a

select last_name, count(last_name) from actor
group by last_name;

-- 4b


select last_name, count(last_name) from actor
group by last_name having count(last_name) >= 2;

-- 4c

update actor
set first_name = "HARPO"
where first_name = "GROUCHO" and last_name = "WILLIAMS";

-- 4d

update actor
set first_name = "GROUCHO"
where first_name = "HARPO" and last_name = "WILLIAMS";

