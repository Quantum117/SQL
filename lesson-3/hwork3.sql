Create database lesson3 ;
use lesson3 ;
drop table if exists Employees;
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);
drop table if exists Orders ;
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);
drop table if exists Products ;
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);


INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, HireDate)
VALUES
    (1, 'Alice', 'Johnson', 'HR', 60000, '2019-03-15'),
    (2, 'Bob', 'Smith', 'IT', 85000, '2018-07-20'),
    (3, 'Charlie', 'Brown', 'Finance', 95000, '2017-01-10'),
    (4, 'David', 'Williams', 'HR', 50000, '2021-05-22'),
    (5, 'Emma', 'Jones', 'IT', 110000, '2016-12-02'),
    (6, 'Frank', 'Miller', 'Finance', 40000, '2022-06-30'),
    (7, 'Grace', 'Davis', 'Marketing', 75000, '2020-09-14'),
    (8, 'Henry', 'White', 'Marketing', 72000, '2020-10-10'),
    (9, 'Ivy', 'Taylor', 'IT', 95000, '2017-04-05'),
    (10, 'Jack', 'Anderson', 'Finance', 105000, '2015-11-12'),
  (11, 'Karen', 'Baker', 'HR', 58000, '2018-02-25'),
    (12, 'Leo', 'Harris', 'IT', 90000, '2019-06-18'),
    (13, 'Mia', 'Clark', 'Finance', 98000, '2016-09-30'),
    (14, 'Noah', 'Martinez', 'HR', 52000, '2021-03-10'),
    (15, 'Olivia', 'Garcia', 'IT', 115000, '2015-07-19'),
    (16, 'Paul', 'Rodriguez', 'Finance', 42000, '2022-08-22'),
    (17, 'Quinn', 'Lee', 'Marketing', 77000, '2020-11-08'),
    (18, 'Ryan', 'Walker', 'Marketing', 70000, '2019-05-15'),
    (19, 'Sophia', 'Hall', 'IT', 97000, '2016-12-12'),
    (20, 'Tom', 'Allen', 'Finance', 102000, '2014-10-28'),
  (21, 'Uma', 'Young', 'HR', 61000, '2019-04-17'),
    (22, 'Victor', 'King', 'IT', 88000, '2017-08-23'),
    (23, 'Wendy', 'Scott', 'Finance', 99000, '2015-05-12'),
    (24, 'Xavier', 'Green', 'HR', 54000, '2022-02-28'),
    (25, 'Yara', 'Adams', 'IT', 113000, '2014-06-05'),
    (26, 'Zane', 'Nelson', 'Finance', 43000, '2023-01-10'),
    (27, 'Abby', 'Carter', 'Marketing', 76000, '2020-07-29'),
    (28, 'Ben', 'Mitchell', 'Marketing', 71000, '2021-11-04'),
    (29, 'Clara', 'Perez', 'IT', 94000, '2018-03-20'),
    (30, 'Daniel', 'Roberts', 'Finance', 106000, '2013-09-15'),
    (31, 'Ella', 'Stewart', 'HR', 59000, '2020-05-21'),
    (32, 'Finn', 'Lopez', 'IT', 89000, '2016-12-10'),
    (33, 'Georgia', 'Hill', 'Finance', 101000, '2015-02-14'),
    (34, 'Hector', 'Bennett', 'HR', 53000, '2021-08-19'),
    (35, 'Iris', 'Collins', 'IT', 112000, '2013-04-07'),
    (36, 'Jake', 'Turner', 'Finance', 45000, '2022-09-05'),
    (37, 'Kylie', 'Ward', 'Marketing', 78000, '2019-06-11'),
    (38, 'Liam', 'Torres', 'Marketing', 74000, '2020-10-22'),
    (39, 'Mason', 'Richardson', 'IT', 96000, '2017-05-30'),
    (40, 'Nina', 'Wood', 'Finance', 108000, '2012-12-01');

	-- Task1



Select  * from Employees


SELECT Department, AVG(Salary) as AverageSalary,
  CASE
    WHEN AVG(Salary) > 80000 Then 'High'
    WHEN (AVG(Salary) >= 50000 and AVG(Salary) <= 80000) Then 'Medium'
    ELSE 'Low'
  END
  AS SalaryCategory

FROM (
  SELECT Top 40
  *
  FROM Employees
  ORDER BY Salary DESC
  ) as p
GROUP BY Department
ORDER BY AverageSalary DESC
OFFSET 2 ROWS FETCH FIRST 5 ROWS ONLY;


-- Task2

INSERT INTO Orders (OrderID, CustomerName, OrderDate, TotalAmount, Status)
VALUES
    (101, 'John Doe', '2023-01-15', 2500, 'Shipped'),
    (102, 'Mary Smith', '2023-02-10', 4500, 'Pending'),
    (103, 'James Brown', '2022-03-25', 6200, 'Delivered'),
    (104, 'Patricia Davis', '2024-05-05', 1800, 'Cancelled'),
    (105, 'Michael Wilson', '2023-06-14', 7500, 'Shipped'),
    (106, 'Elizabeth Garcia', '2023-07-20', 9000, 'Delivered'),
    (107, 'David Martinez', '2023-08-02', 1300, 'Pending'),
    (108, 'Susan Clark', '2023-09-12', 5600, 'Shipped'),
    (109, 'Robert Lewis', '2023-10-30', 4100, 'Cancelled'),
    (110, 'Emily Walker', '2024-12-05', 9800, 'Delivered'),
	(111, 'Daniel Harris', '2023-01-20', 3400, 'Shipped'),
    (112, 'Sophia Lee', '2023-02-25', 5000, 'Delivered'),
    (113, 'William Scott', '2023-04-05', 2750, 'Pending'),
    (114, 'Olivia White', '2023-05-18', 6900, 'Shipped'),
    (115, 'Ethan Hall', '2023-06-28', 8200, 'Delivered'),
    (116, 'Charlotte Allen', '2023-07-30', 4600, 'Pending'),
    (117, 'Liam Young', '2024-08-15', 3800, 'Cancelled'),
    (118, 'Mia King', '2023-09-25', 9200, 'Shipped'),
    (119, 'Benjamin Wright', '2023-11-11', 5800, 'Delivered'),
    (120, 'Amelia Lopez', '2024-12-20', 10500, 'Shipped');


SELECT
  CASE
    WHEN Status IN ('Shipped', 'Delivered') THEN 'Completed'
    WHEN Status = 'Pending' THEN 'Pending'
    WHEN Status = 'Cancelled' THEN 'Cancelled'
  END AS OrderStatus,
  COUNT(OrderID) AS TotalOrders,
    SUM(TotalAmount) AS TotalRevenue
From Orders
Where OrderDate BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY Status
HAVING SUM(TotalAmount) > 5000
ORDER BY TotalRevenue DESC;

--

SELECT Orders.*, TotalAmounts.SumTotalAmount
FROM Orders
JOIN
    (SELECT Status, SUM(TotalAmount) AS SumTotalAmount FROM Orders GROUP BY Status) TotalAmounts
ON Orders.Status = TotalAmounts.Status;

--Task3

INSERT INTO Products (ProductID, ProductName, Category, Price, Stock)
VALUES
    (1, 'Laptop', 'Electronics', 1200, 15),
    (2, 'Smartphone', 'Electronics', 800, 30),
    (3, 'Desk Chair', 'Furniture', 150, 5),
    (4, 'LED TV', 'Electronics', 1400, 8),
    (5, 'Coffee Table', 'Furniture', 250, 0),
    (6, 'Headphones', 'Accessories', 200, 25),
    (7, 'Monitor', 'Electronics', 350, 12),
    (8, 'Sofa', 'Furniture', 900, 2),
    (9, 'Backpack', 'Accessories', 75, 50),
    (10, 'Gaming Mouse', 'Accessories', 120, 20);

SELECT DISTINCT p.Category,
       p.ProductName,
       p.Price,
       IIF(p.Stock = 0, 'Out of Stock',
           IIF(p.Stock BETWEEN 1 AND 10, 'Low Stock', 'In Stock')) AS InventoryStatus
FROM Products p
WHERE p.Price = (SELECT MAX(p2.Price)
                 FROM Products p2
                 WHERE p2.Category = p.Category)
ORDER BY p.Price DESC
OFFSET 5 ROWS;

