use sakila;

select title
from sakila.film
where film_id=1;

select name
from sakila.category
where category_id=6;

select * from sakila.film_category;

use sakila;
select title, name
from film
inner join film_category using(film_id)
inner join category using(category_id);

-- keressük meg azokat a vásárlókat (customer) akik akciófilmet béreltek

select distinct first_name, last_name
from sakila.customer
inner join sakila.rental using(customer_id)
inner join sakila.inventory using(inventory_id)
inner join sakila.film_category using(film_id)
inner join sakila.category using(category_id)
where category.name='Action'
order by first_name, last_name;

-- subqueryvel az előző példa megoldása:
use sakila;

select customer.customer_id, customer.first_name, customer.last_name
from customer
where customer.customer_id in (

select rental.customer_id
from rental
where rental.inventory_id in (

select inventory.inventory_id
from inventory
where inventory.film_id in (

select film_category.film_id
from film_category
where film_category.category_id in (

select category.category_id
from sakila.category
where category.name = 'Action'
))));


