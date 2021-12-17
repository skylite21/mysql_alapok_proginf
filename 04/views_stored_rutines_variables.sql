

-- view: 

create or replace view employees.v_department_emp_latest_date as
select emp_no, max(from_date) as from_date, max(to_date) as to_date
from employees.dept_emp
group by emp_no
limit 10;

select * from employees.v_department_emp_latest_date;

-- Készítsünk egy view-t ami az összes manager átlagfizetését kiszámolja és
-- kerekíti is az értéket
create or replace view employees.v_manager_avg_salary as
select round(avg(salary), 2)
from employees.salaries s
join employees.dept_manager m on s.emp_no = m.emp_no
limit 10;

select * from employees.v_manager_avg_salary;

show full tables in employees where table_type like 'view';

drop view employees.v_department_emp_latest_date;


use employees;
drop procedure if exists select_employees;

delimiter $$
create procedure select_employees()
begin
  select * from employees
  limit 100;
end$$
delimiter ;


call employees.select_employees();


-- készítsünk egy procedúrát ami az összes dolgozó átlagfizetését kiszámolja

use employees;
drop procedure if exists avg_salary;

delimiter $$
create procedure avg_salary()
begin
  select avg(salary)
  from salaries;
end$$
delimiter ;

-- zarojel nelkul is hivhato:
call employees.avg_salary;
call employees.avg_salary();


-- tárolt eljárások bemeneti paraméterrel:

use employees;
drop procedure if exists emp_salary;

delimiter $$
use employees $$
create procedure emp_salary(in p_emp_no integer)
begin
  select employees.first_name, employees.last_name, salaries.salary, salaries.from_date, salaries.to_date
  from employees
  inner join employees.salaries using(emp_no)
  where employees.emp_no = p_emp_no;
end$$

delimiter ;

call employees.emp_salary(11330);

-- Tárolt eljárások input és output paraméterrel:

use employees;
drop procedure if exists emp_avg_salary_out;

delimiter $$
use employees $$
-- decimal(10,2) > 12345678,09
create procedure emp_avg_salary_out(in p_emp_no integer, out p_avg_salary decimal(10, 2))
begin
  select avg(salaries.salary) into p_avg_salary
  from employees
  inner join employees.salaries using(emp_no)
  where employees.emp_no = p_emp_no;
end$$

delimiter ;


use employees;
set @v_avg_salary = 0;
call employees.emp_avg_salary_out(11300, @v_avg_salary);
select @v_avg_salary;

-- tárolt fügvények:

use employees;
drop function if exists f_emp_avg_salary;

delimiter $$
create function f_emp_avg_salary(p_emp_no integer) returns decimal(10,2)
begin
  -- a függvények esetén a declare szóval hozunk létre lokális változókat:
  declare v_avg_salary decimal(10, 2);

  select avg(salaries.salary)
  into v_avg_salary
  from employees
  inner join salaries using(emp_no)
  where emp_no = p_emp_no;
  -- ha ezt kihagyjuk az hibát dobna mert a deklaráláskor megmondtuk hogy
  -- ez a függvény vissza kell hogy adjon valamit...
  return v_avg_salary;
end$$

delimiter ;

select employees.f_emp_avg_salary(11300);


use employees;
set @v_emp_no = 11300;
select emp_no, first_name, last_name, f_emp_avg_salary(@v_emp_no) as avg_salary
from employees
where emp_no = @v_emp_no;

-- globális változók:

select @@max_connections;
set global max_connections = 150;

-- A mysql 5.5 óta a felhasználó nem hozhat létre globális változókat
-- egy alternatíva lehet pl készíteni egy tárolt eljárást ami visszaadja a változót...

drop procedure if exists pdo.get_my_var;
delimiter $$
create procedure pdo.get_my_var ()
begin
select 'valami';
end$$
delimiter ;

call pdo.get_my_var();
