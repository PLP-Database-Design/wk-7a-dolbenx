1.
WITH SplitProducts AS (
    SELECT 
        OrderID,
        CustomerName,
        JSON_TABLE(
            CONCAT('["', REPLACE(Products, ',', '","'), '"]'),
            '$[*]' COLUMNS (Product VARCHAR(100) PATH '$')
        ) AS jt
    FROM ProductDetail
)
SELECT 
    OrderID,
    CustomerName,
    jt.Product
FROM SplitProducts;

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

