
-- 1.3 sec
select * from employees.employees
where hire_date > '1998-01-01';


create index i_hire_date on employees.employees(hire_date);



drop index if exists i_composite on employees.employees;

create index i_composite on employees.employees(first_name, last_name);

select * from employees.employees
where first_name = 'Georgi' and last_name = 'Facello';


show index from employees from employees;
