1.
-- SQL Query to achieve 1NF by splitting the Products column into individual rows
-- First, let's insert individual rows for each product per order

-- Create a temporary table with individual products
SELECT OrderID, CustomerName, 'Laptop' AS Product
FROM ProductDetail
WHERE FIND_IN_SET('Laptop', Products) > 0

UNION ALL

SELECT OrderID, CustomerName, 'Mouse' AS Product
FROM ProductDetail
WHERE FIND_IN_SET('Mouse', Products) > 0

UNION ALL

SELECT OrderID, CustomerName, 'Tablet' AS Product
FROM ProductDetail
WHERE FIND_IN_SET('Tablet', Products) > 0

UNION ALL

SELECT OrderID, CustomerName, 'Keyboard' AS Product
FROM ProductDetail
WHERE FIND_IN_SET('Keyboard', Products) > 0

UNION ALL

SELECT OrderID, CustomerName, 'Phone' AS Product
FROM ProductDetail
WHERE FIND_IN_SET('Phone', Products) > 0;




2.
-- Create a table to store OrderID and CustomerName
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Insert data into the Orders table
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;


-- Create a table to store OrderID, Product, and Quantity
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),  -- Composite primary key
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert data into the OrderItems table
INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

