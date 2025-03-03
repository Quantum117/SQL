-- ==========================
-- JOINS
-- ==========================

/*
1. INNER JOIN
2. OUTER JOIN:
	2.1 LEFT OUTER JOIN
	2.2 RIGHT OUTER JOIN
	2.3 FULL OUTER JOIN
3. CROSS JOIN

(SELF JOIN)
*/

drop table if exists employee;
drop table if exists department;

create table department
(
	id int primary key identity,
	name varchar(50) not null,
	description varchar(max)
);

create table employee
(
	id int primary key identity,
	name varchar(50),
	salary int,
	dept_id int --foreign key references department(id)
);


insert into department(name)
values
	('IT'), ('Marketing'), ('HR'), ('Finance')

select * from department;


insert into employee(name, salary, dept_id)
values
	('John', 15000, 4),
	('Josh', 12000, 5),
	('Adam', 9000, 2),
	('Smith', 11000, 4),
	('Doe', 10000, 1);

SELECT *
FROM employee
INNER JOIN Department
ON employee.dept_id = Department.id;

---  right outer join <=> right join
--- left outer join  <=> left join
--- inner join <=> join