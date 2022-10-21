--1.	Display StaffName and  StaffGender for every staff whose last name is ‘Watson’
--(like)

SELECT StaffName, StaffGender
FROM MsStaff
WHERE StaffName LIKE '% Watson'

--2.	Display TransactionID, StaffName, and Day of Transaction (obtained from the datename of TransactionDate) for every transaction that is handled by staff whose id is ‘ST003’.
--(join, datename)

SELECT TransactionId, StaffName, [Day of Transaction] = DATENAME(WEEKDAY, TransactionDate)
FROM MsStaff s JOIN HeaderTransaction ht
ON s.StaffID = ht.StaffID
WHERE s.StaffID = 'ST003'

--3.	Display Customer Name, Phone Number (obtained by replacing ’0’ in front into ‘+62’ from CustomerPhone), and Total Transaction (obtained from the total number of transaction) for every every customer whose id is between ‘CU002’ and ‘CU004’.
--(stuff, between, count, join, groupby)

SELECT CustomerName, [Phone Number] = STUFF(CustomerPhone,1 , 1, '+62'), [Total Transaction] = COUNT(TransactionID)
FROM MsCustomer c JOIN HeaderTransaction ht
ON c.CustomerID = ht.CustomerID  
WHERE c.CustomerID BETWEEN 'CU002' AND 'CU004'
GROUP BY CustomerName, CustomerPhone

--4.	Display Date (obtained from TransactionDate in ‘Mon dd, yy’ format), CustomerName, Total Price (obtained from total price of shirt), and Number of Shirt Type(s) (obtained from the total number of shirt) for every transaction occurred in February and combine with Date (obtained from TransactionDate in ‘Mon dd, yy’ format), CustomerName, Total Price (obtained from total price of shirt), and Number of Shirt Type(s) (obtained from the total number of shirt) for every transaction occurred in January.  
--(convert,union, sum, count, join, group by, month)

SELECT[Date] = CONVERT(VARCHAR, TransactionDate, 7), CustomerName, [Total Price] = SUM(Price), [Number of Shirt Type(s)] = COUNT(Quantity)
FROM HeaderTransaction ht JOIN MsCustomer c
ON ht.CustomerID = c.CustomerID JOIN DetailTransaction dt
ON ht.TransactionID = dt.TransactionID JOIN MsShirt sh
ON dt.ShirtID = sh.ShirtID
WHERE MONTH(TransactionDate) = 2
GROUP BY  TransactionDate, CustomerName
UNION
SELECT [Date] = CONVERT(VARCHAR, TransactionDate, 7), CustomerName, [Total Price] = SUM(Price), [Number of Shirt Type(s)] = COUNT(Quantity)
FROM HeaderTransaction ht JOIN MsCustomer c
ON ht.CustomerID = c.CustomerID JOIN DetailTransaction dt
ON ht.TransactionID = dt.TransactionID JOIN MsShirt sh
ON dt.ShirtID = sh.ShirtID
WHERE MONTH(TransactionDate) = 1
GROUP BY  TransactionDate, CustomerName

--5.	Display StaffName, Salary (obtained by adding 'Rp. ' in front of StaffSalary) for every transaction which quantity is greater than 2 and handled by Male.
--(cast, in, join, like)

SELECT DISTINCT StaffName, [Salary] = 'Rp. ' + CAST(StaffSalary AS VARCHAR)
FROM MsStaff s JOIN HeaderTransaction ht
ON s.StaffID = ht.StaffID JOIN DetailTransaction dt
ON ht.TransactionID = dt.TransactionID
WHERE StaffGender LIKE 'Male' AND Quantity IN(
	SELECT Quantity
	FROM DetailTransaction
	WHERE Quantity > 2
)

--6.	Display ShirtID, ShirtName, and Price (obtained by adding 'Rp. ' in front of Price) where the price is greater than the average price for every shir bought in January and the name of the shirt contains 3 words.
--(cast, alias subquery, avg, datepart, like)

SELECT DISTINCT sh.ShirtID, ShirtName, [Price] = 'Rp. ' + CAST(Price AS VARCHAR)
FROM MsShirt sh JOIN DetailTransaction dt
ON sh.ShirtID = dt.ShirtID JOIN HeaderTransaction ht
ON dt.TransactionID = ht.TransactionID, (
	SELECT [Average] = AVG(Price)
	FROM MsShirt sh JOIN DetailTransaction dt
	ON sh.ShirtID = dt.ShirtID JOIN HeaderTransaction ht
	ON dt.TransactionID = ht.TransactionID
	WHERE DATEPART(MONTH, TransactionDate) = 1
)AS X
WHERE Price > X.Average AND ShirtName LIKE '% % %'

--7.	Create a view named ‘CustomerView’ to display CustomerName, CustomerAddress and DOB (obtained from CustomerDOB in ‘dd mon yyyy’ format) for every customer who born on Wednesday.
--(create view, datename, convert)

CREATE VIEW CustomerView AS
SELECT CustomerName, CustomerAddress, [DOB] = CONVERT(VARCHAR(50), CustomerDOB, 106)
FROM MsCustomer
WHERE DATENAME(WEEKDAY, CustomerDOB) = 'Wednesday'

--8.	Create a view named ‘ShirtView’ to display Name (obtained from ShirtName), Total Price (obtained from the total price) and Type (obtained from ShirtTypeName) for every shirt bought in 2021, where the shirt name contain three words and the total price is greater than 1200000.
--(create view, sum, join, datepart, like, group by, having)

CREATE VIEW ShirtView AS
SELECT  [Name] = ShirtName, [TotalPrice] = SUM(Price), [Type] = ShirtTypeName
FROM MsShirt sh JOIN DetailTransaction dt
ON sh.ShirtID = dt.ShirtID JOIN HeaderTransaction ht
ON dt.TransactionID = ht.TransactionID JOIN MsShirtType sht
ON sh.ShirtTypeID = sht.ShirtTypeID
WHERE DATEPART(YEAR, TransactionDate) = 2021 AND ShirtName LIKE '% % %'
GROUP BY ShirtName, ShirtTypeName
HAVING SUM(Price) > 1200000



--9.	Add a column named StaffEmail on Staff table with varchar (50) data type and add a constraint named ‘CheckEmail’ to check the StaffEmail must ends with ‘@binus.ac.id’.
--(alter table, add constraint, like)

ALTER TABLE MsStaff
ADD StaffEmail VARCHAR(50)

ALTER TABLE MsStaff
ADD CONSTRAINT CheckEmail CHECK(StaffEmail LIKE '%@binus.ac.id')

SELECT * FROM MsStaff

--10.	Delete data from MsShirt table for every shirt bought in 2020 and ShirtID between ‘SH007’ and ‘SH009’.
--(delete, join, datepart, between)

BEGIN TRAN 
DELETE MsShirt
FROM MsShirt sh JOIN DetailTransaction dt
ON sh.ShirtID = dt.ShirtID JOIN HeaderTransaction ht
ON dt.TransactionID = ht.TransactionID
WHERE DATEPART(YEAR, 2020) > 1 AND sh.ShirtID BETWEEN 'SH007' AND 'SH009'

SELECT * FROM MsShirt
ROLLBACK
