#Punto 1 - 2
SELECT *
FROM dimproduct D
JOIN dimproductsubcategory SUB ON D.ProductSubcategoryKey = SUB.ProductSubcategoryKey
JOIN dimproductcategory CAT ON SUB.ProductCategoryKey = CAT.ProductCategoryKey
;
#Punto 3
SELECT *
FROM dimproduct D 
JOIN factresellersales F ON D.ProductKey = F.ProductKey;
#Punto 4
SELECT DISTINCT ProductKey
FROM factresellersales;

SELECT DISTINCT P.ProductKey, P.EnglishProductName, P.FinishedGoodsFlag
FROM dimproduct P
WHERE FinishedGoodsFlag = 1 AND P.Productkey NOT IN (SELECT DISTINCT ProductKey
FROM factresellersales);

#Punto5
SELECT F.ProductKey, D.EnglishProductName, F.SalesOrderNumber, F.OrderDate, F.OrderQuantity, F.UnitPrice, F.TotalProductCost, F.SalesAmount, D.EnglishProductName
FROM factresellersales F
JOIN dimproduct D ON F.ProductKey = D.ProductKey;

#Esplora la tabella DimReseller.
SELECT * FROM dimreseller;

#Esponi in output lʼelenco dei reseller indicando, per ciascun reseller, anche la sua area geografica
SELECT D.ResellerName, G.City, G.StateProvinceName AS Stato, G.CountryRegionCode AS Paese
FROM dimreseller D
JOIN dimgeography G ON D.GeographyKey = G.GeographyKey;

#Esponi lʼelenco delle transazioni di vendita. Il result set deve esporre i campi: SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, Quantity, TotalProductCost. Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto, il nome del reseller e lʼarea geografica.
SELECT F.SalesOrderNumber, F.SalesOrderLineNumber, F.OrderDate, F.UnitPrice, F.OrderQuantity AS Quantity,
F.TotalProductCost, D.EnglishProductName AS ProductName, DC.EnglishProductCategoryName AS ProductCategory, DR.ResellerName,
G.City, G.StateProvinceName AS Stato, G.EnglishCountryRegionName AS Paese
FROM factresellersales F
JOIN dimproduct D ON F.ProductKey = D.ProductKey
JOIN dimproductsubcategory PSUB ON D.ProductSubcategoryKey = PSUB.ProductSubcategoryKey
JOIN dimproductcategory DC ON PSUB.ProductCategoryKey = DC.ProductCategoryKey
JOIN dimreseller DR ON F.ResellerKey = DR.ResellerKey
JOIN dimgeography G ON DR.GeographyKey = G.GeographyKey;






