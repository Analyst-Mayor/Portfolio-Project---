-- Creating New Database
CREATE DATABASE PanAfricanRealEstate
-- Database to Use
Use PanAfricanRealEstate

-- Creating Tables
CREATE TABLE PanAfricaRealEstateListing - 33(
ListingID INT PRIMARY KEY,
Country VARCHAR (100),
City VARCHAR (100),
Neighborhood VARCHAR (100),
PropertyType VARCHAR (100),
Bedrooms INT,
Bathrooms INT,
SizeSqm INT,
RentOrSale VARCHAR (100),
Price_LocalCurrency DECIMAL (10,2),
Currency_Code VARCHAR (100),
Furnished VARCHAR (100),
Sources VARCHAR (100),
Yr INT,
Currency_USD DECIMAL (10,2)
)

SELECT * 
FRom [dbo].[Pan Africa RealEstate Dataset - 33]

-- Total Number Of Properties
SELECT COUNT (ListingID) AS Total_Listing
FROM [dbo].[Pan Africa RealEstate Dataset - 33]

--1.0 Average Price of Different Property Types Across Country Listed
SELECT Country, PropertyType, AVG (Currency_USD) AS Average_Price_USD
FROM [dbo].[Pan Africa RealEstate Dataset - 33]
WHERE Country IN ('Nigeria', 'Ghana', 'Kenya','South Africa', 'Egypt', 'Morocco', 'Rwanda', 'Tanzania','Uganda', 'Ethiopia', 'Zambia', 'Ivory Coast')
GROUP BY Country, PropertyType
ORDER BY PropertyType DESC

--2.1 Minimum Price of Different Property Types Across Country Listed
SELECT Country, PropertyType, MIN (Currency_USD) AS Minimum_Price_USD
FROM [dbo].[Pan Africa RealEstate Dataset - 33]
WHERE Country IN ('Nigeria', 'Ghana', 'Kenya','South Africa', 'Egypt', 'Morocco', 'Rwanda', 'Tanzania','Uganda', 'Ethiopia', 'Zambia', 'Ivory Coast')
GROUP BY Country, PropertyType
ORDER BY PropertyType 


--2.2 Maximum Price of Different Property Types Across Country Listed
SELECT Country, PropertyType, MAX (Currency_USD) AS Maximum_Price_USD
FROM [dbo].[Pan Africa RealEstate Dataset - 33]
WHERE Country IN ('Nigeria', 'Ghana', 'Kenya','South Africa', 'Egypt', 'Morocco', 'Rwanda', 'Tanzania','Uganda', 'Ethiopia', 'Zambia', 'Ivory Coast')
GROUP BY Country, PropertyType
ORDER BY PropertyType


--3.0 Comparison of  Minimum And Maximum Prices Of Properties For Rent Or Sale By Property Type And No. of Bedrooms
SELECT Bedrooms, PropertyType, RentOrSale, 
	MIN (Currency_USD) AS Minimum_Price_USD,
	MAX (Currency_USD) AS Maxmum_Price_USD
FROM [dbo].[Pan Africa RealEstate Dataset - 33]
WHERE Bedrooms IN ('1', '2', '3', '4')
GROUP BY Bedrooms, PropertyType, RentOrSale
ORDER BY PropertyType


--4.0 Average Prices Of properties In Each Countries By No. Of Bedrooms On Rent Or Sale
SELECT bedrooms, RentOrSale, PropertyType, Country, AVG (Currency_USD) AS Average_Price_USD
FROM [dbo].[Pan Africa RealEstate Dataset - 33]
WHERE bedrooms IN ('1', '2', '3', '4')
GROUP BY bedrooms, RentOrSale, PropertyType, Country
ORDER BY PropertyType, Country


--5.0 Count On Property For Rent/Sale By Property Type and No. Of Bedroom
SELECT Bedrooms, RentOrSale, Furnished, PropertyType, COUNT(*) as PropertyCount
FROM [dbo].[Pan Africa RealEstate Dataset - 33]
WHERE Bedrooms IN ('1','2', '3', '4')
GROUP BY Bedrooms, RentOrSale, Furnished, PropertyType
ORDER BY Bedrooms, RentOrSale, PropertyCount DESC

--6.0 Comparing Average, Min and Max Prices Of Different Property Type Per Year Across Pan African Countries
SELECT 
    Country AS Country,
    Year AS Year,
    PropertyType AS Property_Type, 
    AVG(Price_LocalCurrency) AS Average_Price_Local_Currency,
    AVG(Currency_USD) AS Average_Price_USD,
    MAX(Currency_USD) AS Max_Price_USD,
    MIN(Currency_USD) AS Min_Price_USD  
FROM [dbo].[Pan Africa RealEstate Dataset - 33]
GROUP BY Year, Country, PropertyType
ORDER BY Country, PropertyType, Year