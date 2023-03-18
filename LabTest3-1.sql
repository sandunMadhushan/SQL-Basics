CREATE DATABASE ABCIndustries;
USE ABCIndustries;

CREATE TABLE Manufacturer (
MID INT NOT NULL PRIMARY KEY,
MName VARCHAR(50),
Address VARCHAR(50),
ContactNo CHAR(10) );

INSERT INTO  Manufacturer (MID, MName, Address, ContactNo) VALUES
(001, "Sandun", "Melpitiya, Matale", "0711349060"),
(002, "Hasantha", "Naula, Matale", "0763983977"),
(003, "Madhushan", "Mel Naula, Matale", "0772579864");



CREATE TABLE Part (
PartID INT NOT NULL PRIMARY KEY,
PartName VARCHAR(50),
UnitPrice DECIMAL(10,2),
PartType VARCHAR(50),
AvailableQuantity INT,
MID INT,
FOREIGN KEY (MID) REFERENCES Manufacturer(MID)
);



INSERT INTO  Part (PartID, PartName, UnitPrice, PartType, AvailableQuantity, MID) VALUES
(001, "ABC", 10.00, "Mechanical", 50, 1),
(002, "DEF", 15.00, "Electrical", 25, 2),
(003, "GHI", 20.00, "Mechanical", 15, 1);
SELECT * FROM Part;


CREATE TABLE Customer (
CustomerID INT NOT NULL PRIMARY KEY,
FirstName VARCHAR(20),
Surname VARCHAR(20),
Address VARCHAR(50),
Email VARCHAR(30),
PhoneNO CHAR(10)
);

CREATE TABLE Customer (
    Cust_ID INT PRIMARY KEY,
    address VARCHAR(100),
    Email VARCHAR(100),
    phoneNO VARCHAR(20),
    firstName VARCHAR(50),
    SurName VARCHAR(50),
    Cust_Name VARCHAR(100) GENERATED ALWAYS AS (CONCAT(firstName, ' ', SurName))
);

INSERT INTO customer (Cust_ID, address, Email, phoneNO, firstName, SurName) VALUES
(1001, '111 First St.', 'silva@example.com', '0771001001', 'Amith', 'Silva'),
(1002, '222 Second St.', 'ruwan@example.com', '0772002002', 'Ruwan', 'Perera'),
(1003, '333 Third St.', 'jp@example.com', '0773003003', 'Jude', 'Peris');


CREATE TABLE Parts_Order (
OrderNo INT NOT NULL PRIMARY KEY,
OrderDate DATE,
Quantity INT,
TotalPrie DECIMAL(10,2),
SpecialInstructions TEXT,
PartID INT,
FOREIGN KEY(PartID) REFERENCES Part(PartID)
);

INSERT INTO Parts_Order (OrderNo, OrderDate, Quantity, SpecialInstructions, PartID) VALUES
(1001, '2022-01-01', 10, 'Handle with care', 1),
(1002, '2022-02-15', 5, 'Express delivery', 2),
(1003, '2022-03-31', 2, '', 3);



-- Create the trigger to calculate the total price
DELIMITER $$
CREATE TRIGGER calculate_total_price BEFORE INSERT ON parts_order
FOR EACH ROW
BEGIN
    SET NEW.TotalPrie = NEW.Quantity * (SELECT UnitPrice FROM Part WHERE PartID = NEW.PartID);
END $$
DELIMITER ;

CREATE TABLE customer_order (
    orderNo INT,
    Cust_ID INT,
    PRIMARY KEY (orderNo, Cust_ID),
    FOREIGN KEY (orderNo) REFERENCES parts_order(orderNo),
    FOREIGN KEY (Cust_ID) REFERENCES customer(Cust_ID)
);

INSERT INTO customer_order (orderNo, Cust_ID) VALUES
(1001, 1001),
(1002, 1002),
(1003, 1003);


SELECT * FROM customer_order;
