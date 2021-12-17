

select emp_no, first_name, last_name,
case
  when gender = 'M' then 'Male'
  else 'Female'
  end
  as gender
from employees.employees
limit 20;


select emp_no, first_name, last_name,
max(salaries.salary) - min(salaries.salary) as salary_difference,
case
  when max(salaries.salary) - min(salaries.salary) > 30000 then 'Salary was raised by more than $30 000'
  when max(salaries.salary) - min(salaries.salary) between 20000 and 30000 then 'Salary was raised by more than $20 000 but less then $30 000'
  else 'Salary was raised by less than $20 000'
  end as salary_increase
from employees.dept_manager
inner join employees.employees using(emp_no)
inner join employees.salaries using(emp_no)
group by salaries.emp_no;


-- kiválasztjuk azokat a dolgozókat ahol az emp_no nagyobb mint 109990 és ha a dolgozó manager akkor ezt 
-- egy külön oszlopba jelezzük. 
select e.emp_no, e.first_name, e.last_name,
  case
      when dm.emp_no is not null then 'manager'
      else 'employee'
  end as is_manager
from employees.employees e
left join employees.dept_manager dm on dm.emp_no = e.emp_no
where e.emp_no > 109990;


select e.emp_no, e.first_name, e.last_name,
  case
      when max(de.to_date) > sysdate() then 'is still employed'
      else 'not an employee anymore'
  end as current_employee
from employees.employees e
join employees.dept_emp de on de.emp_no = e.emp_no
group by de.emp_no
limit 100;


