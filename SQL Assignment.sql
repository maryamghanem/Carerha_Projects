-- 1. How many total products are listed in the database?
SELECT COUNT(*) AS TotalProducts
FROM Products;
-- Output : 77


-- 2. How many products have names that start with the letter "C"?
SELECT COUNT(ProductName) AS ProductsStartingWithC
FROM Products
WHERE ProductName LIKE 'C%';
-- Output : 9


-- 3. What is the average (Round) unit price of all products? 
SELECT ROUND(AVG(UnitPrice)) AS AverageUnitPrice
FROM Products;
-- Output : 29


-- 4. How Many orders placed in the year 2023?
SELECT COUNT(*) AS OrdersIn2023 
FROM Orders
WHERE STRFTIME('%Y', OrderDate) = '2023';
-- Output : 1132



-- 5. Which country has the most customers?
SELECT Country, COUNT(*) AS NumberOfCustomers
FROM Customers
GROUP BY Country
ORDER BY NumberOfCustomers DESC
LIMIT 1;
-- Output : USA 


-- 6. Identify the category with the most discontinued products.
SELECT C.CategoryName, COUNT(*) AS DiscontinuedProductCount
FROM Products P
JOIN Categories C ON P.CategoryID = C.CategoryID
WHERE P.Discontinued = 1
GROUP BY C.CategoryName
ORDER BY DiscontinuedProductCount DESC
LIMIT 1;
-- Output : Meat/Poultry 


-- 7. What is the total amount spent by customer ALFKI?
SELECT SUM(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)) AS TotalAmountSpent
FROM Orders O
JOIN 'Order Details' OD ON O.OrderID = OD.OrderID
WHERE O.CustomerID = 'ALFKI';
-- Output : 3965464.95



-- 8. Find the employee full name with the most orders shipped.
SELECT 
    CONCAT(E.FirstName, ' ', E.LastName) AS EmployeeFullName,
    COUNT(*) AS ShippedOrdersCount
FROM 
    Employees AS E
JOIN 
    Orders AS O ON E.EmployeeID = O.EmployeeID
GROUP BY 
    E.EmployeeID
ORDER BY 
    ShippedOrdersCount DESC
LIMIT 1;
-- Output : Margaret Peacock 


-- 9. How many orders placed before '2023-01-01'?
SELECT COUNT(*) AS OrdersBefore2023
FROM Orders
WHERE OrderDate < '2023-01-01';
-- Output : 15150


-- 10. Find the top 5 most popular products (by total quantity sold) across all orders.
SELECT 
    OD.ProductID,  
    P.ProductName,
    SUM(OD.Quantity) AS TotalQuantitySold
FROM 
    'Order Details' OD 
JOIN 
    Products P ON OD.ProductID = P.ProductID
GROUP BY 
    OD.ProductID,  
    P.ProductName
ORDER BY 
    TotalQuantitySold DESC
LIMIT 5;
-- Output : Louisiana Hot Spiced Okra, Sir Rodney's Marmalade, 
-- Teatime Chocolate Biscuits, Sirop d'érable, Gumbär Gummibärchen










