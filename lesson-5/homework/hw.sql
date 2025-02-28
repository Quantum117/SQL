use lesson5;

drop table if exists Employees ;
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

-- Assign a Unique Rank to Each Employee Based on Salary
Select *,
Dense_Rank() Over(Order by Salary Desc) as ord
from Employees ;

--Find Employees Who Have the Same Salary Rank

SELECT SalaryRank, COUNT(*) AS Count
FROM (
    SELECT RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
) AS Ranked
GROUP BY SalaryRank
HAVING COUNT(*) > 1;



--average salary by department
Select *,
Avg(Salary) Over(partition by Department ) as avg_salary
from Employees ;

--Identify the Top 2 Highest Salaries in Each Department. HOw to solve without subquery ?

SELECT EmployeeID, Name, Department, Salary, SalaryRank
FROM (
    SELECT EmployeeID, Name, Department, Salary,
           DEnse_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
) AS RankedEmployees
WHERE SalaryRank <= 2;

--Find the Lowest-Paid Employee in Each Department

SELECT EmployeeID, Name, Department, Salary, SalaryRank
FROM (
    SELECT EmployeeID, Name, Department, Salary,
           DEnse_RANK() OVER (PARTITION BY Department ORDER BY Salary Asc) AS SalaryRank
    FROM Employees
) AS RankedEmployees
WHERE SalaryRank = 1;

--Calculate the Running Total of Salaries in Each Department
SELECT EmployeeID, Name, Department, Salary,
       SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate) AS RunningTotal
FROM Employees;

--Find the Total Salary of Each Department Without GROUP BY

SELECT EmployeeID, Name, Department, Salary,
       SUM(Salary) OVER (PARTITION BY Department) AS Salary_BY_Dept
FROM Employees;

--Calculate the Average Salary in Each Department Without GROUP BY
SELECT EmployeeID, Name, Department, Salary,
       Avg(Salary) OVER (PARTITION BY Department) AS Avg_Salary_BY_Dept
FROM Employees;

--Find the Difference Between an Employee’s Salary and Their Department’s Average

SELECT EmployeeID, Name, Department, Salary,
       Salary - Avg(Salary) OVER (PARTITION BY Department) AS Diff
FROM Employees;

--Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)

SELECT EmployeeID, Name, Department, Salary,
       Avg(Salary) OVER ( order by salary rows between 1 preceding and 1 following  ) AS moving_avg
FROM Employees;

--Find the Sum of Salaries for the Last 3 Hired Employees
SELECT SUM(Salary) AS Sum3
FROM (
    SELECT TOP 3 Salary
    FROM Employees
    ORDER BY HireDate DESC
) AS Sum3;

--Calculate the Running Average of Salaries Over All Previous Employees
SELECT
    EmployeeID,
    Name,
    Department,
    Salary,
    AVG(Salary) OVER (ORDER BY HireDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Running_Avg_Salary
FROM Employees;

--Find the Maximum Salary Over a Sliding Window of 2 Employees Before and After
SELECT
    EmployeeID,
    Name,
    Department,
    Salary,
    MAX(Salary) OVER (ORDER BY EmployeeID ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS Max_Salary_Window
FROM Employees;

--Determine the Percentage Contribution of Each Employee’s Salary to Their Department’s Total Salary
SELECT
     Name,Department,
    CAST(Salary / SUM(Salary) OVER(PARTITION BY Department) AS DECIMAL(10,2)) *100 AS TotalSalary
FROM Employees;
