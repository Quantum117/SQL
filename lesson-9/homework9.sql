Create database lesson9 ;
use lesson9 ;

CREATE TABLE Employees
(
	EmployeeID  INTEGER PRIMARY KEY,
	ManagerID   INTEGER NULL,
	JobTitle    VARCHAR(100) NOT NULL
);
INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) 
VALUES
	(1001, NULL, 'President'),
	(2002, 1001, 'Director'),
	(3003, 1001, 'Office Manager'),
	(4004, 2002, 'Engineer'),
	(5005, 2002, 'Engineer'),
	(6006, 2002, 'Engineer');

----Given this Employee table below, find the level of depth each employee from the President.

Select * from Employees;

;With hierarchy as (
 ---- Get a president  first ( managerId is null ).Aka  getting  Anchor member :
	 select *,
	 0 as depth 
     from Employees
	 Where ManagerID is null 

	 Union All
	 --- Recursive step inner join Employees(e) table to cte(hierarchy) table 
	 --- and increment depth by one whenever there is a match 
	 --- Aka Recursive member
	 Select e.EmployeeID ,e.ManagerId, e.JobTitle, hr.depth +1  
	 from Employees e 
	 inner join hierarchy hr on e.ManagerID = hr.EmployeeID
) 
---The recursion continues until no more records are found.
Select * from hierarchy;

--- Find Factorials up to N . Expected output for N=10
With Factorials
as (
   --- anchor member . p -> product 
	select 1 as n, 1 as p
	union all 
	---- recursive member 
	select n + 1, p* (n+1)  from Factorials
	where n < 10
)
select n as Num , p as Factorial from Factorials;

---Find Fibonacci numbers up to n
With Fibonacci as (
select 1 as n  , 1 as fib1, 1 as fib2 
union all 
select n+ 1 , fib2 , fib1+fib2
from Fibonacci
where n < 10
)
select n, fib1 as Fibonacci_Number from Fibonacci;




