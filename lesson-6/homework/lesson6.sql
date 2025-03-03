-- Create Departments table
drop table if exists Departments;
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);

-- Create Employees table
drop table if exists Employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    DepartmentID INT,
    Salary DECIMAL(10,2),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create Projects table
drop table if exists Projects ;
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50) NOT NULL,
    EmployeeID INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Insert data into Departments
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(101, 'IT'),
(102, 'HR'),
(103, 'Finance'),
(104, 'Marketing');

-- Insert data into Employees
INSERT INTO Employees (EmployeeID, Name, DepartmentID, Salary) VALUES
(1, 'Alice', 101, 60000),
(2, 'Bob', 102, 70000),
(3, 'Charlie', 101, 65000),
(4, 'David', 103, 72000),
(5, 'Eva', NULL, 68000);

-- Insert data into Projects
INSERT INTO Projects (ProjectID, ProjectName, EmployeeID) VALUES
(1, 'Alpha', 1),
(2, 'Beta', 2),
(3, 'Gamma', 1),
(4, 'Delta', 4),
(5, 'Omega', NULL);


Select * from Employees ;
Select * from Departments ;
----Q1
SELECT e.Name, d.DepartmentName  
FROM Employees AS e  
Inner JOIN Departments AS d  
ON e.DepartmentID = d.DepartmentID;

--- Q2
SELECT e.Name, d.DepartmentName  
FROM Employees AS e  
LEFT JOIN Departments AS d  
ON e.DepartmentID = d.DepartmentID;

--Q3

SELECT e.Name, d.DepartmentName  
FROM Employees AS e  
Right JOIN Departments AS d  
ON e.DepartmentID = d.DepartmentID;

---Q4 
SELECT e.Name, d.DepartmentName  
FROM Employees AS e  
Full Outer JOIN Departments AS d  
ON e.DepartmentID = d.DepartmentID;

--- Q5
SELECT d.DepartmentName, SUM(e.Salary) AS TotalSalary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;


---Q6 
SELECT e.Name, d.DepartmentName  
FROM Employees AS e  
Cross JOIN Departments AS d  ;

--- Q7  

SELECT e.Name, e.DepartmentID, d.DepartmentName  ,
p.ProjectName
FROM Employees AS e  
Left JOIN Departments AS d 
ON e.DepartmentID = d.DepartmentID
Left Join Projects as p
on e.EmployeeID = p.EmployeeID ;