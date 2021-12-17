

select first_name
from sakila.actor
group by first_name;

select first_name, count(first_name)
from sakila.actor
group by first_name;

select first_name, count(first_name) as name_count
from sakila.actor
group by first_name
having count(first_name) > 3;

select first_name, count(first_name) as name_count
from sakila.actor
where first_name like "ju%"
group by first_name
having count(first_name) > 3;
