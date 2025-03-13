use lesson11;

------ Puzzle1 Transfer employees 
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary)
VALUES
    (1, 'Alice', 'HR', 5000),
    (2, 'Bob', 'IT', 7000),
    (3, 'Charlie', 'Sales', 6000),
    (4, 'David', 'HR', 5500),
    (5, 'Emma', 'IT', 7200);

Select * from Employees

CREATE  TABLE #EmployeeTransfers (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
)
Insert into #EmployeeTransfers
Select 
	EmployeeID,
	Name, 
	Case When Department = 'Hr' then 'IT'
		 When Department = 'IT' then 'Sales'
		 When Department = 'Sales' then 'Hr'
		 End as Deparment,
	salary 
from Employees;

Select * from #EmployeeTransfers
-----Puzzle 2
--- An e-commerce company tracks orders in two separate systems,
--- but some orders are missing in one of them. You need to find the missing records.


CREATE TABLE Orders_DB1 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB1 VALUES
(101, 'Alice', 'Laptop', 1),
(102, 'Bob', 'Phone', 2),
(103, 'Charlie', 'Tablet', 1),
(104, 'David', 'Monitor', 1);

CREATE TABLE Orders_DB2 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB2 VALUES
(101, 'Alice', 'Laptop', 1),
(103, 'Charlie', 'Tablet', 1);

DECLARE @MissingOrders TABLE (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT );

INSERT INTO @MissingOrders
SELECT * FROM Orders_DB1
EXCEPT
SELECT * FROM Orders_DB2;

SELECT * FROM @MissingOrders; -- To verify the missing orders

------- Puzzle 3 

CREATE TABLE WorkLog (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    WorkDate DATE,
    HoursWorked INT
);

INSERT INTO WorkLog VALUES
(1, 'Alice', 'HR', '2024-03-01', 8),
(2, 'Bob', 'IT', '2024-03-01', 9),
(3, 'Charlie', 'Sales', '2024-03-02', 7),
(1, 'Alice', 'HR', '2024-03-03', 6),
(2, 'Bob', 'IT', '2024-03-03', 8),
(3, 'Charlie', 'Sales', '2024-03-04', 9);

Select * from WorkLog;

Go
Create View  vw_MonthlyWorkSummary  As 
Select 
   EmployeeID,
   EmployeeName,
   Department,
   HoursWorked as TotalHoursWorked ,
   Sum(HoursWorked) Over (partition by Department ) as TotalHoursDepartment, 
   Avg(HoursWorked) Over (partition by Department ) as AvgHoursDepartment 
from WorkLog ;
Go

select * from vw_MonthlyWorkSummary