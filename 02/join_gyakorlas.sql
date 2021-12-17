drop table if exists pdo.student_class;
drop table if exists pdo.students;
drop table if exists pdo.classes;

create table if not exists pdo.students (
  StudentId int not null auto_increment,
  StudentName varchar(50) not null,
  primary key (StudentId)
  );


create table if not exists pdo.classes (
  ClassId int not null auto_increment,
  ClassName varchar(50) not null,
  primary key (ClassId)
  );

create table if not exists pdo.student_class (
  ClassId int not null,
  StudentId int not null,
  foreign key (ClassId) references pdo.classes(ClassId),
  foreign key (StudentId) references pdo.students(StudentId)
);

insert into pdo.students
(StudentName)
values
('John'),
('Matt'),
('James'),
('Chris');

insert into pdo.classes
(ClassName)
values
('Math'),
('Art'),
('History');

-- join table, junction table, associative table
-- https://en.wikipedia.org/wiki/Many-to-many_(data_model)
-- https://www.relationaldbdesign.com/database-design/module6/three-relationship-types.php
insert into pdo.student_class
(classId, StudentId)
values
(1,1),
(1,2),
(3,1),
(3,2),
(3,3);

select * from pdo.students;
select * from pdo.classes;
select * from pdo.student_class;

-- 1. ki az aki feliratkozott már valamilyen kurzusra?
select DISTINCT pdo.students.StudentName
from pdo.student_class
inner join pdo.students using(StudentId);
-- inner join pdo.students on students.StudentId = student_class.StudentId;

-- 2. Ki iratkozott fel matekra?
select pdo.students.StudentName
from pdo.student_class
inner join pdo.students using(StudentId)
inner join pdo.classes using(ClassId)
where className = 'Math';

-- ki az aki nem iratkozott fel semmire?
select StudentName 
from pdo.students
left join pdo.student_class using(StudentId)
where classId is null;

-- mik a fel nem vett tárgyak?
select ClassName
from pdo.classes
left join pdo.student_class using(ClassId)
where StudentId is null;

