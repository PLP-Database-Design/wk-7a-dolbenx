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

-- First Orders Table (OrderID → CustomerName) --
SELECT DISTINCT 
    OrderID, 
    CustomerName
FROM OrderDetails;
 --Second OrderItems Table (OrderID + Product → Quantity) --
SELECT 
    OrderID, 
    Product, 
    Quantity
FROM OrderDetails;


