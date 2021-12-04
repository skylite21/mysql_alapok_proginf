-- igazi one-to-one relationship nagyon nehézkesen megvalósítható mysql-ben
-- mert ahhoz egyszerre kellene beilelszteni adatot két táblába, vagy kikapcsolni
-- a foreign key check-et amíg az első táblába illesztünk be adatot.
-- chicken egg problem...

-- tehát ez valójában zero or one-to-one

create table pdo.users(
    id int not null auto_increment,
    user_name varchar(45) not null,
    primary key(id)
);


-- a primary key egyben foreign key is egy másik táblában
-- lehetne külön primary key itt is és egy másik ami a foreign key
-- de ez igy kevesebb tarhelyet igenyel.
create table pdo.accounts(
    id int not null,
    account_name varchar(45) not null,
    primary key(id),
    foreign key(id) references users(id)
);



