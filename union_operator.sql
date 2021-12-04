drop table pdo.table1;
drop table pdo.table2;

create table pdo.table1
(id int, value varchar(10));

insert into pdo.table1 (id, value)
values
(1, 'first'),
(2, 'second'),
(3, 'third'),
(4, 'fourth'),
(5, 'fifth');

create table pdo.table2
(id int, value varchar(10));

insert into pdo.table2 (id, value)
values
(1, 'first'),
(2, 'second'),
(3, 'third'),
(6, 'sixth'),
(7, 'seventh'),
(8, 'eighth');

use pdo;
select table1.id as T1ID, table1.value as T1Value
from table1
union
-- únió esetén a tábla fejléce, mindíg az első select-ben megírt fejléc lesz...
select table2.id as T2ID, table2.value as T2Value
from table2;

use pdo;
select table1.id as T1ID, table1.value as T1Value
from table1
-- a duplikált elemeket is megjeleníti
union all
select table2.id as T2ID, table2.value as T2Value
from table2;

-- ERROR
-- a táblák unioja esetén a kiválasztott oszlopok száma ugyanaz kell hogy legyen
use pdo;
select table1.id as T1ID
from table1
union all
select table2.id as T2ID, table2.value as T2Value
from table2;

-- full outer join lekérdezhető egy left és egy right join segítségével:
-- a közös elemek nélkül:
use pdo;
select * from table1
left join table2 using(id)
where table2.id is null
union
select * from table1
right join table2 using(id)
where table1.id is null;


-- full outer join lekérdezhető egy left és egy right join segítségével:
-- kozos elemekkel egyutt
use pdo;
select * from table1
left join table2 using(id)
union
select * from table1
right join table2 using(id);

