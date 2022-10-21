CREATE DATABASE DZara
GO
USE DZara
GO

CREATE TABLE MsCustomer(
    CustomerID CHAR(5),
    CustomerName VARCHAR(50),
    CustomerGender VARCHAR(10),
    CustomerAddress VARCHAR(50),
    CustomerPhone VARCHAR(20),
    CustomerDOB DATE,
    PRIMARY KEY (CustomerID)
)

CREATE TABLE MsStaff(
    StaffID CHAR(5),
    StaffName VARCHAR(50),
    StaffGender VARCHAR(10),
    StaffAddress VARCHAR(50),
    StaffPhone VARCHAR(20),
    StaffSalary INT,
    StaffDOB DATE,
    PRIMARY KEY (StaffID)
)

CREATE TABLE MsShirtType(
    ShirtTypeID CHAR(5),
    ShirtTypeName VARCHAR(50) ,
    PRIMARY KEY (ShirtTypeID)
)

CREATE TABLE MsShirt(
    ShirtID CHAR(5),
    ShirtTypeID CHAR(5) FOREIGN KEY (ShirtTypeID) REFERENCES MsShirtType(ShirtTypeID)
    ON DELETE CASCADE ON UPDATE CASCADE,
    ShirtName VARCHAR(50),
    Price INT,
    PRIMARY KEY (ShirtID)
)

CREATE TABLE HeaderTransaction(
    TransactionID CHAR(5) CHECK (TransactionID LIKE 'TR[0-9][0-9][0-9]') ,
    CustomerID CHAR(5) FOREIGN KEY (CustomerID) REFERENCES MsCustomer(CustomerID) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    StaffID CHAR(5) FOREIGN KEY (StaffID) REFERENCES MsStaff(StaffID) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    TransactionDate DATE ,
    PRIMARY KEY (TransactionID)
)

CREATE TABLE DetailTransaction(
    TransactionID CHAR(5) FOREIGN KEY (TransactionID) REFERENCES HeaderTransaction(TransactionID) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    ShirtID CHAR(5) FOREIGN KEY (ShirtID) REFERENCES MsShirt(ShirtID) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    Quantity INT,
    PRIMARY KEY (TransactionID, ShirtID)
)

GO
INSERT INTO MsCustomer VALUES
('CU001', 'Adrian', 'Male', 'Syahdan Street No.259', '085262831824','08/09/2000'),
('CU002', 'William', 'Male', 'Anggrek Street No.179', '085245835726','11/12/2000'),
('CU003', 'Julia Stephany ', 'Female', 'Star Street No.20', '081267834020', '11/21/1999'),
('CU004', 'Swanny Wijaya', 'Female', 'George Street No.12', '083262561212', '10/08/2000'),
('CU005', 'Andrew Wiseson Tanjaya', 'Male', 'Eureka Street No.259', '085221631200','07/08/1999')

GO
INSERT INTO MsStaff VALUES 
('ST001','Emma Watson','Female', 'Country Street No.45', '081252342835', 5000000, '12/07/1998'),
('ST002','Daniel Kang','Male', 'Sky Street No.45', '081345213535', 6000000, '11/12/1995'),
('ST003','Dahyun Kim','Female', 'Heaven Street No.123', '081231342135', 7000000, '05/28/1998'),
('ST004','Richard Lee','Male', 'Kongo Street No.2', '081256713233', 5000000, '03/25/1997'),
('ST005','Samuel Zhang','Male', 'Orange Street No.15', '081214326423', 5500000, '01/28/1995')

GO
INSERT INTO MsShirtType VALUES
('SE001', 'Long Sleeve'),
('SE002', 'Denim'),
('SE003', 'Chambray'),
('SE004', 'Polo'),
('SE005', 'Flannel')

GO
INSERT INTO MsShirt VALUES
('SH001', 'SE001', 'Long Linen Oversize', 400000),
('SH002', 'SE002', 'Slim Fit Barstow', 500000),
('SH003', 'SE003', 'Oxford Chambray', 400000),
('SH004', 'SE004', 'Unisex Polo Shirt', 500000),
('SH005', 'SE005', 'Checked Red Flannel', 700000),
('SH006', 'SE003', 'Grey Chambray', 900000),
('SH007', 'SE004', 'Basic Polo Pink', 600000),
('SH008', 'SE005', 'Oversize Flanel Check', 650000),
('SH009', 'SE002', 'Striped Denim', 350000),
('SH010', 'SE001', 'Basic Linen', 800000)

GO
INSERT INTO HeaderTransaction VALUES
('TR001','CU001','ST001', '03/05/2021'),
('TR002','CU002','ST003', '01/10/2021'),
('TR003','CU003','ST004', '02/15/2021'),
('TR004','CU001','ST002', '03/06/2021'),
('TR005','CU004','ST005', '11/21/2020'),
('TR006','CU005','ST002', '03/05/2021'),
('TR007','CU002','ST001', '12/08/2020'),
('TR008','CU003','ST001', '02/10/2021'),
('TR009','CU004','ST003', '02/18/2021'),
('TR010','CU002','ST004', '10/27/2020')

GO
INSERT INTO DetailTransaction VALUES
('TR001', 'SH001', 2),
('TR002', 'SH003', 1),
('TR003', 'SH002', 4),
('TR004', 'SH005', 3),
('TR005', 'SH002', 1),
('TR006', 'SH006', 5),
('TR007', 'SH003', 1),
('TR008', 'SH007', 3),
('TR009', 'SH008', 1),
('TR010', 'SH009', 4),
('TR001', 'SH003', 2),
('TR002', 'SH005', 3),
('TR003', 'SH006', 1),
('TR007', 'SH008', 2),
('TR004', 'SH004', 1)