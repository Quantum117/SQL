Create Database lesson6 ;
use lesson6;
-- Exercises
Create table pq (
  id int ,
  name varchar(50),
  typed varchar(50));

  insert into pq Values
  (1,'P',Null ), (1 ,Null,'Q' ),
  (2,'A',Null ), (2, Null, 'B' )

  Select * from pq
  -- String_agg skips null values when concatenating
 Select id,
 STRING_AGG(Name,'')+','+STRING_AGG(typed,'') as non_null
 from pq
 Group by id

 -- from 1 to 100
 -- from sql server 2022
 Select * from generate_series(0, 100) ;
 --- Universal for all versions
 Select Row_Number() Over (Order by Value) as val
 from    String_Split(REPLICATE('1 ',99),' ') ;

 drop table if exists Sales
 CREATE TABLE Sales (
    SalesYear INT NOT NULL,
    CurrentQuota DECIMAL(10,2) NOT NULL
);
INSERT INTO Sales (SalesYear, CurrentQuota)
VALUES
    (2022, 50000.00),
    (2018, 40000.00),
    (2020, 45000.00),
    (2023, 55000.00),
    (2019, 42000.00),
    (2021, 48000.00),
    (2017, 38000.00),
    (2016, 35000.00),
    (2015, 30000.00),
    (2024, 60000.00);

Select *,
sum(CurrentQuota) Over(Order by SalesYear  Rows  1 Preceding  ) as Prev
from Sales
--------Lag and Lead
Select *,
-- returns one preceding row
    Lag(CurrentQuota,1,  00) Over (order by SalesYear) as Prev_Quota,
-- returns one following row
	Lead(CurrentQuota,1,  00) Over (order by SalesYear) as Next_Quota
from Sales

---------- Add Column Where gives info about previous employees (by hiredate)  salary by department
CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    HireDate DATE NOT NULL
);

INSERT INTO Employees (Name, Department, Salary, HireDate) VALUES
    ('Alice', 'HR', 50000, '2020-06-15'),
    ('Bob', 'HR', 60000, '2018-09-10'),
    ('Charlie', 'IT', 70000, '2019-03-05'),
    ('David', 'IT', 80000, '2021-07-22'),
    ('Eve', 'Finance', 90000, '2017-11-30'),
    ('Frank', 'Finance', 75000, '2019-12-25'),
    ('Grace', 'Marketing', 65000, '2016-05-14'),
    ('Hank', 'Marketing', 72000, '2019-10-08'),
    ('Ivy', 'IT', 67000, '2022-01-12'),
    ('Jack', 'HR', 52000, '2021-03-29');

Select *,
  Lag(Salary,1,0) Over(partition by Department order by HireDate) as prev_Emp_salary
from Employees