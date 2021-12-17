use pdo;
create table `student` (
    `studentid` int unsigned not null auto_increment,
    `firstname` varchar(25),
    `lastname` varchar(25) not null,
    primary key (`studentid`)
);

create table `course` (
    `courseid` smallint unsigned not null auto_increment,
    `code` varchar(10) character set ascii collate ascii_general_ci not null,
    `name` varchar(100) not null,
    primary key (`courseid`)
);

create table `coursemembership` (
    `student` int unsigned not null,
    `course` smallint unsigned not null,
    primary key (`student`, `course`),
    constraint `constr_coursemembership_student_fk`
        foreign key `student_fk` (`student`) references `student` (`studentid`)
        on delete cascade on update cascade,
    constraint `constr_coursemembership_course_fk`
        foreign key `course_fk` (`course`) references `course` (`courseid`)
        on delete cascade on update cascade
);

show create table pdo.CourseMembership;

