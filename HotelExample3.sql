/*
Janny Velazquez
HOTEL EXAMPLE 3
*/

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Rooms;
DROP TABLE IF EXISTS Customers;

SET FOREIGN_KEY_CHECKS = 1;

/* create customer table */
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100),
    DateOfBirth DATE
);

/* create room table */
CREATE TABLE Rooms (
    RoomID INT AUTO_INCREMENT PRIMARY KEY,
    RoomNumber INT NOT NULL,
    RoomType VARCHAR(50), 
    PricePerNight DECIMAL(10, 2),
    AvailabilityStatus VARCHAR(20) 
);

/* create booking table */
CREATE TABLE Bookings (
    BookingID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    RoomID INT,
    CheckInDate DATE,
    CheckOutDate DATE,
    TotalPrice DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);

/* insert data to customer table */
INSERT INTO Customers (FullName, PhoneNumber, Email, DateOfBirth)
VALUES 
('Janny Velazquez', '123-456-7890', 'janny@example.com', '2000-09-22'),
('Emma Ingles', '555-123-4567', 'emma@example.com', '1995-12-22'),
('Charlie Brown', '777-888-9999', 'charlie@example.com', '2000-07-30');

/* insert data to room table */
INSERT INTO Rooms (RoomNumber, RoomType, PricePerNight, AvailabilityStatus)
VALUES 
(101, 'Single', 75.00, 'Available'),
(102, 'Double', 120.00, 'Available'),
(201, 'Suite', 250.00, 'Available'),
(202, 'Double', 120.00, 'Available');

/* insert data to booking table */
INSERT INTO Bookings (CustomerID, RoomID, CheckInDate, CheckOutDate, TotalPrice)
VALUES 
(1, 2, '2025-01-15', '2025-01-17', 240.00),
(2, 3, '2025-01-16', '2025-01-20', 1000.00), 
(3, 1, '2025-01-20', '2025-01-22', 150.00);

/* update room availability */
UPDATE Rooms
SET AvailabilityStatus = 'Booked'
WHERE RoomID IN (2, 3, 1);

/* find all bookings with customer name and room */
SELECT 
    b.BookingID,
    c.FullName AS CustomerName,
    r.RoomNumber,
    r.RoomType,
    b.CheckInDate,
    b.CheckOutDate,
    b.TotalPrice
FROM 
    Bookings b
JOIN 
    Customers c ON b.CustomerID = c.CustomerID
JOIN 
    Rooms r ON b.RoomID = r.RoomID;
 
 /* find all customers who booked a double room */
SELECT 
    c.FullName,
    c.Email,
    r.RoomType,
    b.CheckInDate,
    b.CheckOutDate
FROM 
    Bookings b
JOIN 
    Customers c ON b.CustomerID = c.CustomerID
JOIN 
    Rooms r ON b.RoomID = r.RoomID
WHERE 
    r.RoomType = 'Double';
   
   /* calculate the revenue of bookings */  
SELECT 
    SUM(b.TotalPrice) AS TotalRevenue
FROM 
    Bookings b;

    
/* find available room */      
SELECT 
    RoomNumber,
    RoomType,
    PricePerNight
FROM 
    Rooms
WHERE 
    AvailabilityStatus = 'Available';





