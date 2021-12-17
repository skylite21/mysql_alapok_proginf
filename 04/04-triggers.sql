

-- A mysql trigger egy olyan tárolt program ami akkor fut le ha egy adott
-- táblában változás történik (valamilyen esemény következik be ami INSERT,
-- UPDATE vagy DELETE)

-- a trigger-ek nagyon hasznos eszközök ha az adat konzisztenciára törekszünk,
-- és az adat integritása fontos A triggereknek két típusa is van 'before' és
-- 'after'

-- tehát a trigger egy olyan esemény ami bekövetkezhet előtte vagy utána az
-- alábbi eseményeknek: INSERT, UPDATE, DELETE

use employees;

--  A triggerek tárolt program-ok, tehát a syntax meglehetősen hasonló a tárolt
--  eljárásokhoz és a procedúrákhoz

delimiter $$
-- a create trigger statement után meg kell határoznunk a típusát, és azt hogy
-- melyik táblán milyen művelet végzése esetén kell hogy lefusson.
create trigger employees.before_salaries_insert
before insert on salaries
for each row
begin 
	if new.salary < 0 then 
		set new.salary = 0; 
	end if; 
end $$

delimiter ;

-- for each row: lefuttatjuk minden létező sorra ebben a táblában
-- a new.salary-ban a new kulcsszó egy újonnan hozzáadott sorra utal

-- Ellenőrizzük az adott dolgozó fizetését:
select * from salaries
where emp_no = '10001';
    
-- Nézzük meg mitörténik ha negatív fizetést próbálunk beállítani a dolgozónak:
insert into salaries values ('10001', -92891, '2010-06-22', '9999-01-01');

-- Ha most megnézzük 0-t kell kapnunk a fizetésnél:
select * from salaries
where emp_no = '10001';
    

-- Nézzünk meg egy példát a before update-re:
delimiter $$

create trigger employees.trig_upd_salary
before update on salaries
for each row
begin 
	if new.salary < 0 then 
-- a triggerek készítésekor elérhető az old kulcsszó is ami a régi értékre vonatkozik
		set new.salary = old.salary; 
	end if; 
end $$

delimiter ;


-- teszteljük a triggert:
update salaries set salary = 98765
where emp_no = '10001'
and from_date = '2010-06-22';


-- nézzük meg sikerült e:
select * from salaries
where emp_no = '10001'
and from_date = '2010-06-22';

-- viszont ha negatív értéket próbálunk beállítani
update salaries 
set salary = - 50000
where emp_no = '10001'
and from_date = '2010-06-22';
        
-- Az előző lekérdezés most nem módosította az értéket:
select * from salaries
where emp_no = '10001'
and from_date = '2010-06-22';
        

-- info a triggerekről:
select trigger_schema, trigger_name, action_statement
from information_schema.triggers;

-- csak 1 db-re
select * from information_schema.triggers where 
information_schema.triggers.trigger_schema like '%employees%'


-- a mysql-ben léteznek system function-ök, pl a sysdate visszaadja azt az időt
-- amikor meghívtuk:
select sysdate();

-- vagy pl a date_format fgv:
select date_format(sysdate(), '%y-%m-%d') as today;


-- az alábbi (after) trigger automatikusan hozzáad 20 000 dollárt a fizetéséhez
-- annak a dolgozónak akit épp most léptettek elő manager-é továbbá beállítja
-- a dátumát a to_date fieldjének arra a napra amikor lefuttattuk az insert
-- statement-et
delimiter $$

create trigger employees.trig_ins_dept_mng
after insert on dept_manager
for each row
begin
	declare v_curr_salary int;
    
  select max(salary)
	into v_curr_salary from salaries
	where emp_no = new.emp_no;
	if v_curr_salary is not null then
		update salaries 
		set to_date = sysdate()
		where emp_no = new.emp_no and to_date = new.to_date;

		insert into salaries 
    values (new.emp_no, v_curr_salary + 20000, new.from_date, new.to_date);
    end if;
end $$

delimiter ;

insert into employees.dept_manager values ('111534', 'd009', date_format(sysdate(), '%y-%m-%d'), '9999-01-01');

select *
from employees.dept_manager
where emp_no = 111534;
select *
from employees.salaries
where emp_no = 111534;


drop trigger employees.trig_ins_dept_mng;
drop trigger employees.before_salaries_insert;
drop trigger employees.trig_upd_salary;
