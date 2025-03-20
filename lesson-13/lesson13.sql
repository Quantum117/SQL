
create database lesson13;

use lesson13;
select * from sys.objects where type in ('S','SP')

select * from sys.schemas

----------- Cursor
declare cursor1 cursor for  
 select name from sys.schemas ;

declare @name varchar(50) ;
open cursor1
--- give first value to the cursor1 (anchor) 
Fetch next from cursor1  into @name
while @@FETCH_STATUS =0 
  begin 
    print @name 
	Fetch next from cursor1  into @name
  end;
  --- close and delete cursor1
close cursor1 ;
deallocate cursor1 ;

------------------- UDF (user defined functions ) . Scalar functions
if (111 > 110 )
begin 
  select 11
end

------- cleaning data 
select ascii('	') --- tab /t : 9
select ascii(' ')  ---  whitespace : 32
select ascii('
') --- newline character: 13

go
alter function dbo.cleaner (@line nvarchar(255)) 
returns nvarchar(255)
 begin 
 return trim(
      replace(
		replace(
			replace(@line, char(13),''), --removing newline character
				char(9),''), char(10),''))  --- removing tab
 end 
go
--- apperently in windows to remove whitespace we should remove both char(10):/r and char(13) :/n
select dbo.cleaner(' iskandarburiev42@gmail.com
')

----- 2. Table valued functions

-- 2.1 Inline 
go
alter function my_tvf(@order_id int)
returns table
as
return
(
	select *
	from [Tsqlv6].[sales].[orders] 
	where empid = @order_id
	--where store_id = store_id -- TRUE
)
go

select * from dbo.my_tvf(1)


-- 2.2 Multiline


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FullName VARCHAR(100) NOT NULL,
    Department VARCHAR(50) NOT NULL
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY IDENTITY(1,1),
    ProjectName VARCHAR(100) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NULL
);

CREATE TABLE EmployeeProjects (
    EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID),
    ProjectID INT FOREIGN KEY REFERENCES Projects(ProjectID),
    Role VARCHAR(50),
    HoursWorked DECIMAL(10,2),
    PRIMARY KEY (EmployeeID, ProjectID)
);


INSERT INTO Employees (FullName, Department) VALUES
    ('Alice Johnson', 'IT'),
    ('Bob Smith', 'IT'),
    ('Charlie Brown', 'HR'),
    ('David White', 'Finance');

INSERT INTO Projects (ProjectName, StartDate, EndDate) VALUES
    ('ERP System', '2023-01-01', '2024-06-30'),
    ('Website Redesign', '2023-05-15', '2023-12-31'),
    ('HR Automation', '2023-07-01', '2024-03-15'),
    ('Financial Forecasting', '2023-08-01', NULL); -- Ongoing project

INSERT INTO EmployeeProjects (EmployeeID, ProjectID, Role, HoursWorked) VALUES
    (1, 1, 'Developer', 400),
    (1, 2, 'Lead Developer', 300),
    (2, 1, 'QA Engineer', 250),
    (2, 3, 'Consultant', 150),
    (3, 3, 'HR Specialist', 350),
    (4, 4, 'Analyst', 200);


select * from EmployeeProjects
select * from Projects
select * from Employees

-- EmployeeName, Department, TotalProject, TotalHoursWorked, LatestProjectEndDate
go
Create function getDetails()
returns table As
Return (

	select distinct Employees.FullName,
	       Employees.Department,
	       count(p.ProjectId) Over(partition by emp.EmployeeId) as TotalProjects,
		   Sum(emp.HoursWorked) Over(partition by emp.EmployeeId) as TotalHoursWorked,
		   Max(p.EndDate) Over(partition by emp.EmployeeID) as LatestProjectEndDate
	from EmployeeProjects emp
	join Projects p
	on emp.ProjectID = p.ProjectID
	join Employees
	on emp.EmployeeID = Employees.EmployeeID 
	);
go
select * from getDetails()

--- Tnalu function version
go
Create function getDetails2()
returns @result table (
      FullName text,
	  Department text,
	  TotalProjects int,
	  TotalHoursWorked float,
	  LatestProjectEndDate Datetime )
As 
begin insert into @result
	select distinct Employees.FullName,
	       Employees.Department,
	       count(p.ProjectId) Over(partition by emp.EmployeeId) as TotalProjects,
		   Sum(emp.HoursWorked) Over(partition by emp.EmployeeId) as TotalHoursWorked,
		   Max(p.EndDate) Over(partition by emp.EmployeeID) as LatestProjectEndDate
	from EmployeeProjects emp
	join Projects p
	on emp.ProjectID = p.ProjectID
	join Employees
	on emp.EmployeeID = Employees.EmployeeID 
return
end
go

select * from getDetails2()