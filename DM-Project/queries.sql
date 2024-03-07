-- CS50 SQL Concepts Application for CTU Database

-- Insert a new driver record
INSERT INTO Drivers (Name, LicenseNumber, ContactDetails)
VALUES ('Amanda Lee', 'LIC232345', '988-112-3344');

-- Insert a new bus with a reference to an existing driver
INSERT INTO Buses (RegistrationNumber, Capacity, Type, DriverID)
VALUES ('CH01TB1234', 40, 'Electric', (SELECT DriverID FROM Drivers WHERE Name = 'Amanda Lee'));

-- Retrieve all buses with their respective driver names
SELECT B.RegistrationNumber, B.Type, D.Name
FROM Buses B
JOIN Drivers D ON B.DriverID = D.DriverID;

-- Update a driver's contact details
UPDATE Drivers
SET ContactDetails = '988-999-8877'
WHERE Name = 'Amanda Lee';

-- Delete a driver who no longer works for CTU
DELETE FROM Drivers
WHERE LicenseNumber = 'LIC232345' AND NOT EXISTS (SELECT 1 FROM Schedules WHERE DriverID = Drivers.DriverID);

-- Begin a transaction to insert a schedule and associate tickets
BEGIN TRANSACTION;
INSERT INTO Routes (StartPoint, EndPoint, EstimatedDuration)
VALUES ('Sector 17', 'Sector 43', '00:30:00');
INSERT INTO Schedules (RouteID, BusID, DriverID, DepartureTime)
VALUES (LAST_INSERT_ROWID(), 1, 1, '2024-03-08 07:30:00');
INSERT INTO Tickets (ScheduleID, PassengerID, SeatNumber, Price)
VALUES (LAST_INSERT_ROWID(), 1, 5, 15.00);
COMMIT;


DROP VIEW IF EXISTS RouteTickets;
-- Create a view of all tickets for a particular route
CREATE VIEW RouteTickets AS
SELECT T.*
FROM Tickets T
JOIN Schedules S ON T.ScheduleID = S.ScheduleID
JOIN Routes R ON S.RouteID = R.RouteID
WHERE R.StartPoint = 'Sector 17' AND R.EndPoint = 'Sector 43';

-- Aggregate total revenue from ticket sales for a particular day
SELECT SUM(Price) AS TotalRevenue
FROM Tickets
WHERE ScheduleID IN (
    SELECT ScheduleID
    FROM Schedules
    WHERE DepartureTime BETWEEN '2024-03-08 00:00:00' AND '2024-03-08 23:59:59'
);


DROP INDEX IF EXISTS idx_departure_time;
-- Create an index for faster lookup of schedules by departure time
CREATE INDEX idx_departure_time ON Schedules(DepartureTime);


-- Update maintenance records and costs in a single statement using a CASE expression
UPDATE MaintenanceRecords
SET Cost = CASE
              WHEN MaintenanceDate < '2024-01-01' THEN Cost * 0.9
              ELSE Cost * 1.1
           END;

DROP TRIGGER IF EXISTS SetLastMaintenanceDate;
-- Create a trigger to automatically set the last maintenance date of a bus
CREATE TRIGGER SetLastMaintenanceDate AFTER INSERT ON MaintenanceRecords
BEGIN
  UPDATE Buses
  SET LastMaintenanceDate = NEW.MaintenanceDate
  WHERE BusID = NEW.BusID;
END;

-- Select drivers who have completed more than 10 trips
SELECT D.Name, COUNT(*) as NumTrips
FROM Drivers D
JOIN Schedules S ON D.DriverID = S.DriverID
GROUP BY D.DriverID
HAVING COUNT(*) > 10;

-- Select the top 3 most traveled routes based on ticket sales
SELECT R.StartPoint, R.EndPoint, COUNT(T.TicketID) as TicketsSold
FROM Routes R
JOIN Schedules S ON R.RouteID = S.RouteID
JOIN Tickets T ON S.ScheduleID = T.ScheduleID
GROUP BY R.RouteID
ORDER BY TicketsSold DESC
LIMIT 3;





-- Basic SELECT queries
-- 1. Retrieve all information from the Drivers table
SELECT * FROM Drivers;

-- 2. Get a list of buses with a capacity of more than 40 seats
SELECT * FROM Buses WHERE Capacity > 40;

-- Joins and relational queries
-- 3. Find all schedules along with the bus registration number and driver's name
SELECT S.ScheduleID, B.RegistrationNumber, D.Name
FROM Schedules S
JOIN Buses B ON S.BusID = B.BusID
JOIN Drivers D ON S.DriverID = D.DriverID;

-- Aggregate functions
-- 4. Count the total number of tickets sold
SELECT COUNT(*) AS TotalTickets FROM Tickets;

-- 5. Find the average cost of maintenance per bus
SELECT AVG(Cost) AS AverageMaintenanceCost FROM MaintenanceRecords;

-- Grouping and ordering
-- 6. List the total number of buses scheduled by each driver, ordered by their name
SELECT D.Name, COUNT(*) AS TotalBusesScheduled
FROM Drivers D
JOIN Schedules S ON D.DriverID = S.DriverID
GROUP BY D.Name
ORDER BY D.Name;

-- Subqueries and correlated subqueries
-- 7. Select all drivers who have driven more than the average number of routes
SELECT * FROM Drivers
WHERE DriverID IN (
    SELECT DriverID
    FROM Schedules
    GROUP BY DriverID
    HAVING COUNT(RouteID) > (SELECT AVG(NumRoutes) FROM (SELECT COUNT(RouteID) AS NumRoutes FROM Schedules GROUP BY DriverID))
);

-- Data manipulation
-- 8. Increase ticket price by 10% for all tickets
UPDATE Tickets SET Price = Price * 1.1;


-- 9. Delete all schedules that are in the past
DELETE FROM Schedules WHERE DepartureTime < CURRENT_TIMESTAMP;

-- Transactions
-- 10. Create a transaction for a new ticket purchase
BEGIN TRANSACTION;
INSERT INTO Passengers (Name, Email, ContactNumber, Age, Gender) VALUES ('Aditya Kumar', 'aditya.kumar@example.com', '+91 92345 67890', 30, 'm');
INSERT INTO Tickets (ScheduleID, PassengerID, SeatNumber, Price) VALUES (1, (SELECT PassengerID FROM Passengers WHERE Email = 'aditya.kumar@example.com'), 5, 200.0);
COMMIT;


-- Indexes (usually created to optimize SELECT queries)
DROP INDEX IF EXISTS idx_passenger_email;
-- 11. Create an index on the Email field of the Passengers table
CREATE INDEX idx_passenger_email ON Passengers (Email);

-- Views
DROP VIEW IF EXISTS ViewBusMaintenanceHistory;
-- 12. Create a view for bus maintenance history
CREATE VIEW ViewBusMaintenanceHistory AS
SELECT B.RegistrationNumber, MR.MaintenanceDate, MR.Details, MR.Cost
FROM MaintenanceRecords MR
JOIN Buses B ON MR.BusID = B.BusID;

-- Advanced JOINs using multiple tables
-- 13. Retrieve all information about the tickets, including passenger details and schedule timings
SELECT T.TicketID, P.Name AS PassengerName, P.Email, S.DepartureTime
FROM Tickets T
JOIN Passengers P ON T.PassengerID = P.PassengerID
JOIN Schedules S ON T.ScheduleID = S.ScheduleID;

-- GROUP BY with HAVING clause
-- 14. Get the total number of tickets for each route only for those routes that have sold more than 5 tickets
SELECT RouteID, COUNT(TicketID) AS TotalTickets
FROM Tickets T
JOIN Schedules S ON T.ScheduleID = S.ScheduleID
GROUP BY RouteID
HAVING COUNT(TicketID) > 5;

-- CASE statement
-- 15. Categorize passengers as 'Child', 'Adult', or 'Senior' based on their age
SELECT Name, 
       CASE 
           WHEN Age < 18 THEN 'Child'
           WHEN Age BETWEEN 18 AND 65 THEN 'Adult'
           ELSE 'Senior'
       END AS Category
FROM Passengers;

--Create a trigger to update a 'LastMaintenance' timestamp column in Buses table after a maintenance record insertion
DROP TRIGGER IF EXISTS AfterMaintenanceInsert;
CREATE TRIGGER AfterMaintenanceInsert
AFTER INSERT ON MaintenanceRecords
FOR EACH ROW
BEGIN
    UPDATE Buses
    SET LastMaintenance = NEW.MaintenanceDate
    WHERE BusID = NEW.BusID;
END;


