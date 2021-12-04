

create table pdo.persons (
    id int not null,
    lastname varchar(255) not null,
    firstname varchar(255),
    age int,
    primary key (id)
);

create table pdo.orders (
    orderid int not null,
    ordernumber int not null,
    personid int,
    primary key (orderid),
    -- A FOREIGN KEY is a field (or collection of fields) in one table, that
    -- refers to the PRIMARY KEY in another table.
    --  The FOREIGN KEY constraint prevents invalid data from being inserted
    -- into the foreign key column, because it has to be one of the values
    --  contained in the parent table.

    foreign key (personid) references persons(id)
);

insert into pdo.persons (id, lastname, firstname, age) values (1, "smith", "john", 44);
insert into pdo.orders (orderid, ordernumber, personid) values (1, 23, 1);

select * from pdo.orders;

-- error
insert into pdo.orders (orderid, ordernumber, personid) values (2, 23, 2);

