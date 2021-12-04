
-- adatbázisok listájának lekérdezése:
show databases;

create database if not exists ecommerce;

-- vagy a use statementet használjuk, vagy minden alkalommal
-- explicit megadjuk az adatbázis nevét...
use ecommerce;
create table if not exists rates (
  rental_rate int,
  id int auto_increment primary key
);

use ecommerce;
show tables;

create table if not exists ecommerce.rates (
  rental_rate int,
  id int auto_increment primary key
);

show tables from ecommerce;

-- mindent bejegyzést lekérdezünk az a rates táblában
select * from ecommerce.rates;

insert into ecommerce.rates (rental_rate) values (1000); 

describe ecommerce.rates;

create table if not exists ecommerce.users (
  -- varchar: egy adott táblában a varchar típusú mezők hosszának összege nem
  -- lehet több mint ~65000 not null: kötelező kitölteni insert-kor
  first_name varchar(50) not null,
  last_name varchar(50) not null,
  user_name varchar(50) not null,
  id int unsigned auto_increment primary key
);


insert into ecommerce.users
(first_name, last_name, user_name)
values
('Lengyel', 'Zsolt', 'Zsolti');

insert into ecommerce.users
(first_name, last_name, user_name)
values
('Kovács', 'János', 'kovi');

select * from ecommerce.users;

insert into ecommerce.users
(first_name, last_name, user_name)
values
('István', 'Kovács', 'pityu'),
('Gábor', 'Benke', 'Gabesz'),
('Nóra', 'Király', 'Noncsi');

select first_name, last_name from ecommerce.users;


select first_name, last_name from ecommerce.users
where id > 2
order by first_name desc;

select * from ecommerce.users
where first_name != 'Lengyel';

select * from ecommerce.users
where 1=2;

select first_name as 'Keresztnév'
from ecommerce.users;

create table if not exists ecommerce.movies (
  duration int,
  id int unsigned auto_increment primary key
);

select duration/60 as TimeInHour
from ecommerce.movies;

select rental_rate * 1.27 as `bruttó ár` from ecommerce.rates;

select (cast(rental_rate as float) * 1.27) / 2 as `float típus` from ecommerce.rates;

create table if not exists ecommerce.payment(
  amount int,
  -- van külön date, és time típus is...
  created datetime,
  id int unsigned auto_increment primary key
);

insert into ecommerce.payment (amount, created) values (123, '2020-01-18-15-16');
insert into ecommerce.payment (amount, created) values (312, curdate());
insert into ecommerce.payment (amount, created) values (312, now());

select * from ecommerce.payment;

-- https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-format
select date_format(created, '%Y %b, %d - %T : %f ') as TheDate from ecommerce.payment;

select amount from ecommerce.payment
  where created between '2020-01-01' and '2020-12-12 12:59:59';

select amount from ecommerce.payment
  where created between '2020-01-01' and now();

select created,
  weekday(created) +1 as dayofweek,
  quarter(created) as quarter,
  week(created) as weekoftheyear,
  monthname(created) as monthname
  from ecommerce.payment;

select round(amount) from ecommerce.payment;

select concat(first_name, ' ', last_name) as FullName from ecommerce.users;

select user_name, concat(first_name, ' ',last_name) as full_name
from ecommerce.users
order by concat(first_name, ' ', last_name);

select concat(left(first_name, 1), ' ', left(last_name, 1)) as Monogramm
from ecommerce.users;

select * from ecommerce.rates;

select DISTINCT rental_rate from ecommerce.rates;

select count(DISTINCT rental_rate) from ecommerce.rates;


-- A logikai operátorok működnek, de ha a sorrendet meg akarjuk szabni akkor használjunk
-- zárójeleket!!!
select * from ecommerce.rates
-- https://dev.mysql.com/doc/refman/8.0/en/operator-precedence.html
  where rental_rate = 100 and (id < 5 or id > 20);



select *
from ecommerce.users
where first_name in ('Gábor', 'Nóra');

select *
from ecommerce.users
where first_name not in ('Gábor', 'Nóra');

select * from ecommerce.users
where id BETWEEN 2 and 6;

select * from ecommerce.users
where first_name like 'gá%r';

select * from ecommerce.users
where first_name like 'gáb_r';

select * from ecommerce.users
where user_name is not null;

select * from ecommerce.users
where user_name is not null
limit 5;

select * from ecommerce.users
where user_name is not null
limit 5, 2;

-- nem egyenlő: != vagy <> 
