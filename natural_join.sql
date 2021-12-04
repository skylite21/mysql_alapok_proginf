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
-- a natural join ugyanaz mint a sima join, csak itt automatikusan ki van választva
-- az összes közös oszlop
select table1.id as T1ID, table1.value as T1Value,
       table2.id as T2ID, table2.value as T2Value
from table1
natural join table2;

use pdo;
-- a natural join ugyanaz mint a sima join, csak itt automatikusan ki van választva
-- az összes közös oszlop
select table1.id as T1ID, table1.value as T1Value,
       table2.id as T2ID, table2.value as T2Value
from table1
natural left join table2;

use pdo;
-- a natural join ugyanaz mint a sima join, csak itt automatikusan ki van választva
-- az összes közös oszlop
select table1.id as T1ID, table1.value as T1Value,
       table2.id as T2ID, table2.value as T2Value
from table1
natural right join table2;
