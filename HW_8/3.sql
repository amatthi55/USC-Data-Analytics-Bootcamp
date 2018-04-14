use sakila;
-- 3a

Alter table actor
Add middle_name VARCHAR(25);

select actor_id, first_name, middle_name, last_name, last_update from actor;

-- 3b

Alter table actor
modify column middle_name blob;

-- 3c

Alter table actor
drop middle_name;

