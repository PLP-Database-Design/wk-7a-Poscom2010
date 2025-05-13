--** ### Question 1 Achieving 1NF (First Normal Form) 🛠️
--The table above violates the 1NF rules of non repeating groups and single entries.
--The Products column has multiple entries in one row which leads to redunancy.
-- Step 1 
-- Creating a normalized ProductDetail table where each entry is in its own row without many products comma seperated.

CREATE TABLE ProductDetail (
OrderId INT,
CustomerName VARCHAR (200),
Products VARCHAR (200)
);

-- Step 2 is to now insert the data into the normalized NF1 table.alter.
INSERT INTO ProductDetail (OrderId, CustomerName, Products)  VALUES
(101, "Jonh Doe", "Laptop"),
(101, "Jonh Doe", "Mouse"),
(102, "Jane Smith", "Tablet"),
(102, "Jane Smith", "Keyboard"),
(102, "Jane Smith", "Mouse"),
(103, "Emily Clark", "Phone");


-- Step 2 is to now insert the data into the normalized NF1 table.alter.
INSERT INTO ProductDetail (OrderId, CustomerName, Products)  VALUES
(101, "Jonh Doe", "Laptop"),
(101, "Jonh Doe", "Mouse"),
(102, "Jane Smith", "Tablet"),
(102, "Jane Smith", "Keyboard"),
(102, "Jane Smith", "Mouse"),
(103, "Emily Clark", "Phone");

SELECT * FROM ProductDetail;


-- Question 2 Achieving 2NF (Second Normal Form) 🧩
-- In the table above, the CustomerName column depends on OrderID (a partial dependency), which violates 2NF.
-- Write an SQL query to transform this table into 2NF by removing partial dependencies. Ensure that each non-key column fully depends on the entire primary key.
-- In order to to transform this table into 2NF, need to split the table into two tables (orders Table and OrdersItem Table) 
-- and link them up through the usage of foreign Keys.

CREATE TABLE Orders (
OrderId INT PRIMARY KEY,
CustomerName VARCHAR(200)
);

CREATE TABLE OrderItems (
OrderId INT,
Product VARCHAR(200),
Quantity INT,
PRIMARY KEY (OrderID, Product),
FOREIGN KEY (OrderId) REFERENCES Orders (OrderId)
);

-- Now i will insert the data in the 2NF normalized tables.
-- Inserting data into Orders Table
INSERT INTO Orders (OrderId, CustomerName) VALUES
(101, "John Doe"),
(102, "Jane Smith"),
(103, "Emily Clark");

-- Inserting data into the OrderItems Table.

INSERT INTO OrderItems (OrderId, Product, Quantity) VALUES
(101, "Laptop", 2),
(101, "Mouse", 1),
(102, "Tablet", 3),
(102, "Keyboard", 1),
(102, "Mouse", 2),
(103, "Phone", 1);

-- Testing the tables if run well
SELECT* FROM orderItems;

SELECT o.CustomerName,  oi.Quantity
FROM Orders AS o
JOIN OrderItems oi ON o.OrderId = oi.OrderId;

SELECT CustomerName,
COUNT(OrderId) AS Total_Orders
FROM Orders
GROUP BY CustomerName;

SELECT o.CustomerName,
SUM(oi.Quantity) AS Total_Items
FROM Orders o
JOIN OrderItems oi ON o.OrderId = oi.OrderId
GROUP BY o.CustomerName;