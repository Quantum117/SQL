use lesson7;
drop table if exists Customers ;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

drop table if exists Orders ;
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

drop table if exists OrderDetails;
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);

drop table if exists Products;
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);

INSERT INTO Customers VALUES
(1, 'Alice'), (2, 'Bob'), (3, 'Charlie');

INSERT INTO Orders VALUES
(101, 1, '2024-01-01'), (102, 1, '2024-02-15'),
(103, 2, '2024-03-10'), (104, 2, '2024-04-20');

INSERT INTO OrderDetails VALUES
(1, 101, 1, 2, 10.00), (2, 101, 2, 1, 20.00),
(3, 102, 1, 3, 10.00), (4, 103, 3, 5, 15.00),
(5, 104, 1, 1, 10.00), (6, 104, 2, 2, 20.00);

INSERT INTO Products VALUES
(1, 'Laptop', 'Electronics'),
(2, 'Mouse', 'Electronics'),
(3, 'Book', 'Stationery');

---- Task1
Select * from Customers
left join Orders
on Customers.CustomerID = Orders.CustomerID;

---- Task2
Select * from Customers
 Where  Customers.CustomerID not in (Select Distinct CustomerId from Orders );

-- Task3
Select ord.OrderID, p.ProductName, ord.Quantity   from OrderDetails as ord
join Products as p
on ord.ProductID = p.ProductId ;

---Task4
Select  Customers.Customerid , CustomerName from Customers
join  Orders
on Customers.CustomerID = Orders.CustomerID
group by Customers.Customerid , CustomerName
Having Count(Customers.CustomerId) > 1;

---- Task5
SELECT od.OrderID, p.ProductName, od.Price
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
JOIN OrderDetails od2 ON od.OrderID = od2.OrderID
GROUP BY od.OrderID, p.ProductName, od.Price
HAVING od.Price = MAX(od2.Price);

--6
SELECT o.CustomerID, c.CustomerName, o.OrderID, o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Orders o2 ON o.CustomerID = o2.CustomerID
GROUP BY o.CustomerID, c.CustomerName, o.OrderID, o.OrderDate
HAVING o.OrderDate = MAX(o2.OrderDate);

--7
SELECT c.CustomerID, c.CustomerName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(DISTINCT CASE WHEN p.Category <> 'Electronics' THEN p.ProductID END) = 0;

--8
SELECT DISTINCT c.CustomerID, c.CustomerName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.Category = 'Stationery';

--9
SELECT c.CustomerID, c.CustomerName, SUM(od.Quantity * od.Price) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CustomerName;