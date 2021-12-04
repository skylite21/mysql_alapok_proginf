

-- mennyi a nők és a férfiak átlagfizetése
select employees.gender, avg(employees.salaries.salary) as avarage_salary
from employees.employees
join employees.salaries using(emp_no)
group by gender;

select emp_no, employees.gender, avg(employees.salaries.salary) as avarage_salary
from employees.employees
join employees.salaries using(emp_no)
group by gender;
