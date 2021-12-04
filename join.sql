drop table if exists pdo.table1;
drop table if exists pdo.table2;

create table pdo.table1
(id int, value varchar(10));

create table pdo.table2
(id int, value varchar(10));

insert into pdo.table1 (id, value)
values
(1, 'first'),
(2, 'second'),
(3, 'third'),
(4, 'fourth'),
(5, 'fifth');

insert into pdo.table2 (id, value)
values
(1, 'first'),
(2, 'second'),
(3, 'third'),
(6, 'sixth'),
(7, 'seventh'),
(8, 'eighth');

select * from pdo.table1;
select * from pdo.table2;

select pdo.table1.*, pdo.table2.*
from pdo.table1
inner join pdo.table2 on table1.id = table2.id;

-- ugyanaz mint az előző csak a table1-et t1-nek rövidítjük a table2-t meg t2-nek
-- alias-t használva..:
select t1.*, t2.*
from pdo.table1 t1
inner join pdo.table2 t2 on t1.id = t2.id;


select t1.value as T1Value, t2.value as T2Value
from pdo.table1 t1
inner join pdo.table2 t2 on t1.id = t2.id;

-- csak ami a t1-be van és ami közös
select t1.value as T1Value
from pdo.table1 t1
left outer join pdo.table2 t2 on t1.id = t2.id;

-- csak ami a t1-be van és nem közös
select t1.value as T1Value
from pdo.table1 t1
left outer join pdo.table2 t2 on t1.id = t2.id
where t2.id is null;

-- minden a jobb oldali táblából és ami közös
select t2.value as T2Value
from pdo.table1 t1
right outer join pdo.table2 t2 on t1.id = t2.id;

-- minden a jobb oldali táblából(t2) és ami nem közös
select t2.value as T2Value
from pdo.table1 t1
right outer join pdo.table2 t2 on t1.id = t2.id
where t1.id is null;

-- csak ami t1-be van és nem közös
-- right join-al is ki lehet fejezni...
select t1.value as T1Value
from pdo.table2 t2
right outer join pdo.table1 t1 on t2.id = t1.id
where t2.id is null;


-- full outer join (egy left és egy right egyben...)
select * from pdo.table1
left join pdo.table2 on pdo.table1.id = pdo.table2.id
union all
select * from pdo.table1
right join pdo.table2 on pdo.table1.id = pdo.table2.id
where pdo.table1.id is null;


-- full outer join a közös-t kihagyva
select * from pdo.table1
left join pdo.table2 on pdo.table1.id = pdo.table2.id
where pdo.table1.id is null
or pdo.table2.id is null
union all
select * from pdo.table1
right join pdo.table2 on pdo.table1.id = pdo.table2.id
where pdo.table1.id is null
or pdo.table2.id is null;

-- joinok esetében nem követelmény hogy primary vagy foreign key-ek kell h legyenekek azok
-- amikkel joinolunk. A lényeg hogy legyen egy oszlop ami mindkét táblában megegyezik.
-- Olyan esetekben is lehet joinolni ahol két tábla (EER diagram-ban) nincs közvetlenül összekötve
-- nem az összeköttetés számít hanem a common column.

