USE AdventureWorks2016

SELECT S.AccountNumber,S.CustomerID FROM Sales.Customer S;


 SELECT 
    c.CustomerID,
    s.Name AS CompanyName,
    c.AccountNumber
FROM 
    Sales.Customer c,
    Sales.Store s 
WHERE 
    s.Name LIKE '%N'AND c.StoreID = s.BusinessEntityID
ORDER BY 
    s.Name;


SELECT 
    c.CustomerID,
    c.AccountNumber,
    a.City
FROM 
    Sales.Customer c
JOIN 
    Person.BusinessEntityAddress bea ON c.PersonID = bea.BusinessEntityID
JOIN 
    Person.Address a ON bea.AddressID = a.AddressID
WHERE 
    a.City IN ('Berlin', 'London')
ORDER BY 
    a.City;


SELECT 
    c.CustomerID,
    p.FirstName,
    p.LastName,
    a.AddressLine1,
    a.City,
    sp.Name AS StateProvince,
    cr.Name AS Country
FROM 
    Sales.Customer c
JOIN 
    Person.Person p ON c.PersonID = p.BusinessEntityID
JOIN 
    Person.BusinessEntityAddress bea ON c.PersonID = bea.BusinessEntityID
JOIN 
    Person.Address a ON bea.AddressID = a.AddressID
JOIN 
    Person.StateProvince sp ON a.StateProvinceID = sp.StateProvinceID
JOIN 
    Person.CountryRegion cr ON sp.CountryRegionCode = cr.CountryRegionCode
WHERE 
    cr.Name IN ('United Kingdom', 'United States')
ORDER BY 
    c.CustomerID;




 SELECT 
    ProductID,
    Name AS ProductName,
    ProductNumber,
    ListPrice
FROM 
    Production.Product
ORDER BY 
    Name;

 

SELECT 
    ProductID,
    Name AS ProductName,
    ProductNumber,
    ListPrice
FROM 
    Production.Product
WHERE 
    Name LIKE 'A%'
ORDER BY 
    Name;

SELECT DISTINCT
    c.CustomerID,
    p.FirstName,
    p.LastName,
    a.AddressLine1,
    a.City
FROM 
    Sales.Customer c
JOIN 
    Person.Person p ON c.PersonID = p.BusinessEntityID
JOIN 
    Person.BusinessEntityAddress bea ON c.PersonID = bea.BusinessEntityID
JOIN 
    Person.Address a ON bea.AddressID = a.AddressID
JOIN 
    Person.StateProvince sp ON a.StateProvinceID = sp.StateProvinceID
JOIN 
    Person.CountryRegion cr ON sp.CountryRegionCode = cr.CountryRegionCode
JOIN 
    Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
ORDER BY 
    c.CustomerID;




SELECT Name FROM Production.Product;
SELECT DISTINCT
    c.CustomerID,
    p.FirstName,
    p.LastName,
    a.AddressLine1,
    a.City
FROM 
    Sales.Customer c
JOIN 
    Person.Person p ON c.PersonID = p.BusinessEntityID
JOIN 
    Person.BusinessEntityAddress bea ON c.PersonID = bea.BusinessEntityID
JOIN 
    Person.Address a ON bea.AddressID = a.AddressID
JOIN 
    Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
JOIN 
    Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN 
    Production.Product prod ON sod.ProductID = prod.ProductID
WHERE 
    a.City = 'London'
    AND prod.Name = 'Chain'
ORDER BY 
    c.CustomerID;


SELECT 
    c.CustomerID
FROM 
    Sales.Customer c
JOIN  
    Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
WHERE 
    soh.SalesOrderID IS NULL
ORDER BY 
    c.CustomerID;



	SELECT 
    c.CustomerID
FROM 
    Sales.Customer c
JOIN 
    Person.Person p ON c.PersonID = p.BusinessEntityID
JOIN 
    Person.BusinessEntityAddress bea ON c.PersonID = bea.BusinessEntityID
JOIN 
    Person.Address a ON bea.AddressID = a.AddressID
JOIN 
    Person.StateProvince sp ON a.StateProvinceID = sp.StateProvinceID
JOIN 
    Person.CountryRegion cr ON sp.CountryRegionCode = cr.CountryRegionCode
JOIN 
    Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
JOIN 
    Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN 
    Production.Product prod ON sod.ProductID = prod.ProductID
WHERE 
    prod.Name = 'Tofu'
ORDER BY 
    c.CustomerID;




SELECT 
    soh.SalesOrderID,
    soh.OrderDate,
    c.CustomerID,
    c.AccountNumber,
    p.FirstName + ' ' + p.LastName AS CustomerName,
    a.EmailAddress,
    ph.PhoneNumber,
    soh.TotalDue
FROM 
    Sales.SalesOrderHeader soh
JOIN 
    Sales.Customer c ON soh.CustomerID = c.CustomerID
LEFT JOIN 
    Person.Person p ON c.PersonID = p.BusinessEntityID
LEFT JOIN 
    Person.EmailAddress a ON p.BusinessEntityID = a.BusinessEntityID
LEFT JOIN 
    Person.PersonPhone ph ON p.BusinessEntityID = ph.BusinessEntityID
WHERE 
    soh.OrderDate = (
        SELECT 
            MIN(OrderDate)
        FROM 
            Sales.SalesOrderHeader
    );




SELECT 
    soh.SalesOrderID,
    soh.OrderDate,
    c.CustomerID,
    c.AccountNumber,
    p.FirstName + ' ' + p.LastName AS CustomerName,
    a.EmailAddress,
    ph.PhoneNumber,
    soh.TotalDue
FROM 
    Sales.SalesOrderHeader soh
JOIN 
    Sales.Customer c ON soh.CustomerID = c.CustomerID
LEFT JOIN 
    Person.Person p ON c.PersonID = p.BusinessEntityID
LEFT JOIN 
    Person.EmailAddress a ON p.BusinessEntityID = a.BusinessEntityID
LEFT JOIN 
    Person.PersonPhone ph ON p.BusinessEntityID = ph.BusinessEntityID
WHERE 
    soh.TotalDue = (
        SELECT 
            MAX(TotalDue)
        FROM 
            Sales.SalesOrderHeader
    );



	SELECT 
    SalesOrderID,
    AVG(OrderQty) AS AverageQuantity
FROM 
    Sales.SalesOrderDetail
GROUP BY 
    SalesOrderID;



SELECT SalesOrderID, MIN(ORDERQTY) AS MIN_QUUANTITY, MAX(ORDERQTY) AS MAX_QUANTITY
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID;



SELECT JOBTITLE,COUNT(BUSINESSENTITYID) AS NO_OF_EMPLOYEE 
FROM HumanResources.Employee WHERE JOBTITLE LIKE '%MANAGER%' GROUP BY JobTitle;


SELECT SalesOrderID, SUM(ORDERQTY) AS TOTAL_QTY
FROM Sales.SalesOrderDetail 
GROUP BY SalesOrderID HAVING SUM(OrderQty)>300;




SELECT 
    SalesOrderID,
    OrderDate,
    CustomerID,
    TotalDue
FROM 
    Sales.SalesOrderHeader
WHERE 
    OrderDate >= '1996-12-31'
ORDER BY 
    OrderDate;




SELECT SALESORDERID, TotalDue 
FROM Sales.SalesOrderHeader WHERE TotalDue>200;




SELECT 
    cr.Name AS CountryName,
    SUM(soh.TotalDue) AS TotalSales
FROM 
    Sales.SalesOrderHeader soh
JOIN 
    Person.Address a ON soh.BillToAddressID = a.AddressID
JOIN 
    Person.StateProvince sp ON a.StateProvinceID = sp.StateProvinceID
JOIN 
    Person.CountryRegion cr ON sp.CountryRegionCode = cr.CountryRegionCode
GROUP BY 
	cr.Name
ORDER BY 
    TotalSales DESC;





SELECT 
    c.CustomerID,
    p.FirstName + ' ' + p.LastName AS ContactName,
    COUNT(soh.SalesOrderID) AS NumberOfOrders
FROM 
    Sales.Customer c
JOIN 
    Person.Person p ON c.PersonID = p.BusinessEntityID
LEFT JOIN 
    Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
GROUP BY 
    c.CustomerID, p.FirstName, p.LastName
ORDER BY 
    NumberOfOrders;






SELECT 
    c.CustomerID,
    p.FirstName + ' ' + p.LastName AS ContactName,
    COUNT(soh.SalesOrderID) AS NumberOfOrders
FROM 
    Sales.Customer c
JOIN 
    Person.Person p ON c.PersonID = p.BusinessEntityID
LEFT JOIN 
    Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
GROUP BY 
    c.CustomerID, p.FirstName, p.LastName HAVING COUNT(SOH.SALESORDERID)>3
ORDER BY 
    NumberOfOrders;





SELECT DISTINCT
    p.ProductID,
    p.Name AS ProductName,
    p.ProductNumber,
    p.DiscontinuedDate,
    soh.OrderDate
FROM 
    Production.Product p
JOIN 
    Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
JOIN 
    Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
WHERE 
    p.DiscontinuedDate IS NOT NULL
    AND soh.OrderDate >= '1997-01-01' 
    AND soh.OrderDate < '1998-01-01'
ORDER BY 
    soh.OrderDate;




SELECT 
    ep.FirstName AS EmployeeFirstName,ep.LastName AS EmployeeLastName,
    sp.FirstName AS superVisorFirstName,sp.LastName AS superVisorLastName
FROM 
    HumanResources.Employee e
JOIN 
    Person.Person ep ON e.BusinessEntityID = ep.BusinessEntityID
LEFT JOIN 
    HumanResources.Employee s ON e.OrganizationLevel = s.OrganizationLevel - 1 AND e.OrganizationNode = s.OrganizationNode
LEFT JOIN 
    Person.Person sp ON s.BusinessEntityID = sp.BusinessEntityID
ORDER BY 
    EmployeeFirstName;





SELECT 
    e.BusinessEntityID AS EmployeeID,
    SUM(soh.TotalDue) AS TotalSales
FROM 
    Sales.SalesOrderHeader soh
JOIN 
    HumanResources.Employee e ON soh.SalesPersonID = e.BusinessEntityID
GROUP BY 
    e.BusinessEntityID
ORDER BY 
    TotalSales DESC;




SELECT 
    BusinessEntityID,
    FirstName,
    LastName
FROM 
    Person.Person
WHERE 
    FirstName LIKE '%a%';




SELECT 
    m.BusinessEntityID AS ManagerID,
    p.FirstName + ' ' + p.LastName AS ManagerName,
    COUNT(e.BusinessEntityID) AS TotalEmployees
FROM 
    HumanResources.Employee e
JOIN 
    HumanResources.Employee m ON e.ManagerID = m.BusinessEntityID
JOIN 
    Person.Person p ON m.BusinessEntityID = p.BusinessEntityID
GROUP BY 
    m.BusinessEntityID, p.FirstName, p.LastName
HAVING 
    COUNT(e.BusinessEntityID) > 4;



SELECT 
    sod.SalesOrderID,
    p.Name AS ProductName
FROM 
    Sales.SalesOrderDetail sod
JOIN 
    Production.Product p ON sod.ProductID = p.ProductID
ORDER BY 
    sod.SalesOrderID;



SELECT 
    soh.SalesOrderID,
    soh.OrderDate,
    soh.TotalDue,
    soh.CustomerID
FROM 
    Sales.SalesOrderHeader soh
WHERE 
    soh.CustomerID = (
        SELECT TOP 1 CustomerID
        FROM Sales.SalesOrderHeader
        GROUP BY CustomerID
        ORDER BY SUM(TotalDue) DESC
    )
ORDER BY 
    soh.OrderDate;



SELECT 
    soh.SalesOrderID,
    soh.OrderDate,
    soh.TotalDue,
    soh.CustomerID
FROM 
    Sales.SalesOrderHeader AS soh
INNER JOIN 
    Sales.Customer AS c ON soh.CustomerID = c.CustomerID
LEFT JOIN 
    Person.PersonPhone AS pp ON c.PersonID = pp.BusinessEntityID
WHERE 
    pp.PhoneNumber IS NULL
ORDER BY 
    soh.OrderDate;


SELECT DISTINCT 
    a.PostalCode
FROM 
    Sales.SalesOrderDetail AS sod
INNER JOIN 
    Production.Product AS p ON sod.ProductID = p.ProductID
INNER JOIN 
    Sales.SalesOrderHeader AS soh ON sod.SalesOrderID = soh.SalesOrderID
INNER JOIN 
    Person.Address AS a ON soh.ShipToAddressID = a.AddressID
WHERE 
    p.Name = 'Tofu';




	SELECT DISTINCT 
    p.Name AS ProductName,
	CR.Name
FROM 
    Sales.SalesOrderDetail AS sod
INNER JOIN 
    Production.Product AS p ON sod.ProductID = p.ProductID
INNER JOIN 
    Sales.SalesOrderHeader AS soh ON sod.SalesOrderID = soh.SalesOrderID
INNER JOIN 
    Person.Address AS a ON soh.ShipToAddressID = a.AddressID
INNER JOIN 
    Person.StateProvince AS sp ON a.StateProvinceID = sp.StateProvinceID
INNER JOIN 
    Person.CountryRegion AS cr ON sp.CountryRegionCode = cr.CountryRegionCode
WHERE 
    cr.Name = 'France';



SELECT 
    p.Name AS ProductName,
    pc.Name AS CategoryName
FROM 
    Production.Product AS p
INNER JOIN 
    Production.ProductSubcategory AS psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
INNER JOIN 
    Production.ProductCategory AS pc ON psc.ProductCategoryID = pc.ProductCategoryID
INNER JOIN 
    Purchasing.ProductVendor AS pv ON p.ProductID = pv.ProductID
INNER JOIN 
    Purchasing.Vendor AS v ON pv.BusinessEntityID = v.BusinessEntityID
WHERE 
    v.Name = 'Specialty BiscuitS,Ltd';




SELECT 
    p.ProductID,
    p.Name AS ProductName
FROM 
    Production.Product AS p
LEFT JOIN 
    Sales.SalesOrderDetail AS sod ON p.ProductID = sod.ProductID
WHERE 
    sod.SalesOrderID IS NULL;



SELECT 
    p.ProductID,
    p.Name AS ProductName,
    p.SAFETYSTOCKLEVEL,
    p.REORDERPOINT
FROM 
    Production.Product AS p
WHERE 
    p.SAFETYSTOCKLEVEL < 10 
    AND p.REORDERPOINT = 0;




	SELECT 
    cr.Name AS Country,
    SUM(soh.TotalDue) AS TotalSales
FROM 
    Sales.SalesOrderHeader AS soh
JOIN 
    Person.Address AS a ON soh.ShipToAddressID = a.AddressID
JOIN 
    Person.StateProvince AS sp ON a.StateProvinceID = sp.StateProvinceID
JOIN 
    Person.CountryRegion AS cr ON sp.CountryRegionCode = cr.CountryRegionCode
GROUP BY 
    cr.Name
ORDER BY 
    TotalSales DESC;




SELECT 
    sp.BusinessEntityID AS EmployeeID,
     
    COUNT(soh.SalesOrderID) AS NumberOfOrders
FROM 
    Sales.SalesOrderHeader AS soh
INNER JOIN 
    Sales.Customer AS c ON soh.CustomerID = c.CustomerID
INNER JOIN 
    HumanResources.Employee AS e ON soh.SalesPersonID = e.BusinessEntityID
INNER JOIN 
    Sales.SalesPerson AS sp ON e.BusinessEntityID = sp.BusinessEntityID
WHERE 
    c.CustomerID BETWEEN 'A' AND 'AO'
GROUP BY 
    sp.BusinessEntityID
ORDER BY 
    NumberOfOrders DESC;





SELECT 
    soh.OrderDate AS MostExpensiveOrderDate
FROM 
    Sales.SalesOrderHeader AS soh
WHERE 
    soh.TotalDue = (
        SELECT 
            MAX(TotalDue)
        FROM 
            Sales.SalesOrderHeader
    );




SELECT 
    p.Name AS ProductName,
    SUM(sod.OrderQty * sod.UnitPrice) AS TotalRevenue
FROM 
    Production.Product AS p
INNER JOIN 
    Sales.SalesOrderDetail AS sod ON p.ProductID = sod.ProductID
GROUP BY 
    p.Name;



SELECT 
    pv.BusinessEntityID AS SupplierID,
    COUNT(*) AS NumberOfProducts
FROM 
    Purchasing.ProductVendor AS pv
INNER JOIN 
    Production.Product AS p ON pv.ProductID = p.ProductID
GROUP BY 
    pv.BusinessEntityID;




	SELECT TOP 10
    c.CustomerID,
    c.AccountNumber,
    p.LastName + ', ' + p.FirstName AS CustomerName,
    SUM(soh.TotalDue) AS TotalSpent
FROM 
    Sales.Customer AS c
INNER JOIN 
    Person.Person AS p ON c.PersonID = p.BusinessEntityID
INNER JOIN 
    Sales.SalesOrderHeader AS soh ON c.CustomerID = soh.CustomerID
GROUP BY 
    c.CustomerID,
    c.AccountNumber,
    p.LastName,
    p.FirstName
ORDER BY 
    TotalSpent DESC;



SELECT 
    SUM(TotalDue) AS TotalRevenue
FROM 
    Sales.SalesOrderHeader;








































































