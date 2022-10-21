CREATE DATABASE GymShop
GO

USE GymShop
GO

CREATE TABLE MsCustomer(
	CustomerID CHAR(5) PRIMARY KEY CHECK(CustomerID LIKE 'CU[0-9][0-9][0-9]'),
	CustomerName VARCHAR(50) NOT NULL,
	CustomerEmail VARCHAR(50) NOT NULL,
	CustomerAddress VARCHAR(255) NOT NULL,
	CustomerGender VARCHAR(10) NOT NULL,
	CustomerDOB DATE NOT NULL
)
GO

CREATE TABLE MsEmployee(
	EmployeeID CHAR(5) PRIMARY KEY CHECK(EmployeeID LIKE 'EM[0-9][0-9][0-9]'),
	EmployeeName VARCHAR(50) NOT NULL,
	EmployeeEmail VARCHAR(50) NOT NULL,
	EmployeeAddress VARCHAR(255) NOT NULL,
	EmployeeGender VARCHAR(10) NOT NULL,
	EmployeeDOB DATE NOT NULL,
	EmployeeSalary INT NOT NULL
)
GO

CREATE TABLE MsEquipmentType(
	EquipmentTypeID CHAR(5) PRIMARY KEY CHECK(EquipmentTypeID LIKE 'ET[0-9][0-9][0-9]'),
	EquipmentTypeName VARCHAR(50) NOT NULL,
)
GO

CREATE TABLE MsEquipment(
	EquipmentID CHAR(5) PRIMARY KEY CHECK(EquipmentID LIKE 'EQ[0-9][0-9][0-9]'),
	EquipmentTypeID CHAR(5) FOREIGN KEY REFERENCES MsEquipmentType(EquipmentTypeID) ON UPDATE CASCADE ON DELETE CASCADE,
	EquipmentName VARCHAR(50) NOT NULL,
	EquipmentPrice INT NOT NULL,
	EquipmentStock INT NOT NULL
)
GO

CREATE TABLE TrTransactionHeader(
	TransactionID CHAR(5) PRIMARY KEY CHECK(TransactionID LIKE 'TR[0-9][0-9][0-9]'),
	CustomerID CHAR(5) FOREIGN KEY REFERENCES MsCustomer(CustomerID) ON UPDATE CASCADE ON DELETE CASCADE,
	EmployeeID CHAR(5) FOREIGN KEY REFERENCES MsEmployee(EmployeeID) ON UPDATE CASCADE ON DELETE CASCADE,
	TransactionDate DATE NOT NULL,
)
GO

CREATE TABLE TrTransactionDetail(
	TransactionID CHAR(5) FOREIGN KEY REFERENCES TrTransactionHeader(TransactionID) ON UPDATE CASCADE ON DELETE CASCADE,
	EquipmentID CHAR(5) FOREIGN KEY REFERENCES MsEquipment(EquipmentID) ON UPDATE CASCADE ON DELETE CASCADE,
	Quantity INT NOT NULL
	PRIMARY KEY(TransactionID, EquipmentID)
)
GO

INSERT INTO MsCustomer
VALUES
('CU001', 'Alex Kwon', 'alexkwon@mail.com', 'Anggrek street no 8 West Jakarta', 'Male', '11/20/2000'),
('CU002', 'Lee Chul San', 'leechulsan@mail.com', 'Mawar street no 9 West Jakarta', 'Male', '11/1/1999'),
('CU003', 'Choi Won Deok', 'choiwondeok@mail.com', 'Dandelion street no 25 West Jakarta', 'Female', '12/3/1998'),
('CU004', 'Lee Hye Won', 'leehyewon@mail.com', 'Kambodia street no 51 West Jakarta', 'Female', '6/21/2001'),
('CU005', 'Kim Won Hae', 'kimwonhae@mail.com', 'Kaktus street no 22 West Jakarta', 'Male', '2/2/1998')
GO

INSERT INTO MsEmployee
VALUES
('EM001', 'Nam Do San', 'namdoosan@mail.com', 'Madu street no 31 East Jakarta', 'Male', '11/10/2000', 510000),
('EM002', 'Won In Jae', 'woninjae@mail.com', 'Fire street no 12 North Jakarta', 'Female', '8/13/2000', 320000),
('EM003', 'Han Ji Pyeong', 'hanjipyeong@mail.com', 'Leaf street no 44 East Jakarta', 'Male', '2/10/2001', 610000),
('EM004', 'Jeon Sa Ha', 'jeongsaha@mail.com', 'Sun street no 41 West Jakarta', 'Female', '6/19/1999', 310000),
('EM005', 'Kim Yong San', 'kimyongsan@mail.com', 'Bee street no 11 East Jakarta', 'Male', '1/22/2000', 810000)
GO

INSERT INTO MsEquipmentType
VALUES
('ET001', 'Treadmill'),
('ET002', 'Dumbbell'),
('ET003', 'Interlocking'),
('ET004', 'Mat'),
('ET005', 'Power Plate')
Go

INSERT INTO MsEquipment
VALUES
('EQ001', 'ET001', 'Cyber R Series 50L Treadmill', 16000000, 50),
('EQ002', 'ET004', 'Aeromat Black Mat', 115000, 200),
('EQ003', 'ET003', 'LOKTUFF 4x4 Interlocking Rubber Tile', 220000, 500),
('EQ004', 'ET002', 'Hampton Urethane Hex Dumbbell', 416000, 100),
('EQ005', 'ET005', 'Power Plate PR07', 8000000, 70)
GO

INSERT INTO TrTransactionHeader
VALUES
('TR001', 'CU001', 'EM001', '2/12/2020'),
('TR002', 'CU001', 'EM003', '3/1/2020'),
('TR003', 'CU002', 'EM002', '3/5/2020'),
('TR004', 'CU002', 'EM005', '4/22/2020'),
('TR005', 'CU003', 'EM001', '5/21/2020'),
('TR006', 'CU003', 'EM002', '5/30/2020'),
('TR007', 'CU004', 'EM003', '6/11/2020'),
('TR008', 'CU004', 'EM004', '8/9/2020'),
('TR009', 'CU005', 'EM005', '11/21/2020'),
('TR010', 'CU005', 'EM002', '12/12/2020')
GO

INSERT INTO TrTransactionDetail
VALUES
('TR001', 'EQ002', 2),
('TR002', 'EQ003', 8),
('TR003', 'EQ001', 1),
('TR004', 'EQ005', 2),
('TR005', 'EQ002', 6),
('TR006', 'EQ005', 7),
('TR007', 'EQ003', 3),
('TR008', 'EQ002', 4),
('TR009', 'EQ001', 1),
('TR010', 'EQ004', 2),
('TR001', 'EQ005', 5),
('TR002', 'EQ002', 7),
('TR003', 'EQ002', 1),
('TR004', 'EQ003', 2),
('TR005', 'EQ005', 3)
