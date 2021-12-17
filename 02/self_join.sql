drop table if exists pdo.employee;

create table pdo.employee (
  EmployeeID int primary key,
  Name varchar(50),
  ManagerId int
);

insert into pdo.employee
(employeeID, name, managerid)
values
(1, 'Mike', 3),
(2, 'David', 3),
(3, 'Roger', Null),
(4, 'Marry', 2),
(5, 'Joseph', 2),
(6, 'Ben', 2);

select * from pdo.employee;

select e1.name as EmployeeName, e2.name as ManagerName
from pdo.employee e1
inner join pdo.employee e2
on e1.managerid = e2.employeeID;


select e1.name as EmployeeName, ifnull(e2.name, 'TopManager') as
ManagerName
from pdo.employee e1
left join pdo.employee e2
on e1.managerid = e2.employeeID;
