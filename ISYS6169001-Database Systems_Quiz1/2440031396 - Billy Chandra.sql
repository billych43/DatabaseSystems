--1.	Create a table named ‘MsPaymentType’ with the following description:
--(create table, like, in)
BEGIN TRAN

CREATE TABLE MsPaymentType(
	PaymentTypeID CHAR(5) PRIMARY KEY CHECK (PaymentTypeID LIKE 'PA[0-9][0-9][0-9]'),
	PaymentTypeName VARCHAR(10) NOT NULL CHECK (PaymentTypeName IN ('Debit', 'Cash', 'Credit')),
	PaymentTypeDescription VARCHAR(255) NOT NULL
)

SELECT *FROM MsPaymentType
INSERT INTO MsPaymentType VALUES
('PA001','Debit', 'asdadadadsad')
ROLLBACK

--2.	Add ‘EquipmentBrand’ as new column on MsEquipment table with varchar(100) data type and add a constraint on MsEquipment to validate that EquipmentPrice must be between 10000 and 50000000.
--(alter table, add, add constraint, between)
BEGIN TRAN

ALTER TABLE MsEquipment
ADD EquipmentBrand VARCHAR(100)

ALTER TABLE MsEquipment
ADD CONSTRAINT check_price CHECK (EquipmentPrice BETWEEN 10000 AND 50000000)

SELECT *FROM MsEquipment
ROLLBACK

--3.	Insert these data into MsCustomer table:
--(insert)
BEGIN TRAN

INSERT INTO MsCustomer VALUES
('CU006', 'Nam Joo Hyuk', 'namjoohyuk@mail.com', 'Sand Street no 11 West Jakarta', 'Female', '2/10/1992')

SELECT *FROM MsCustomer
ROLLBACK

--4.	Display EmployeeName, EmployeeGender, EmployeeAddress, and EmployeeSalary for every employee whose name’s length is even number.
--(len)
BEGIN TRAN

SELECT EmployeeName, EmployeeGender, EmployeeAddress, EmployeeSalary
FROM MsEmployee
WHERE CONVERT(int,EmployeeName) LIKE LEN(EmployeeName) % 2 

ROLLBACK

--5.	Update CustomerName on MsCustomer table by adding CustomerName with ‘ December Member’ for every customer who ever make transaction in December.
--(update, like)
BEGIN TRAN 
SELECT *FROM TrTransactionHeader

UPDATE MsCustomer
SET CustomerName = CustomerName + ' December Member'
FROM TrTransactionHeader tr
WHERE MsCustomer.CustomerID = tr.CustomerID
AND tr.TransactionDate  LIKE '2020-12%' --pake ini karena semua transaksinya tahun 2020 semua

SELECT *FROM MsCustomer
ROLLBACK