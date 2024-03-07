-- Inserting dummy data into the Drivers table
INSERT INTO "Drivers" ("Name", "LicenseNumber", "ContactDetails") VALUES 
('Rajesh Kumar', 'CH01 20120001', '+91 98765 43210'),
('Sunita Gupta', 'CH01 20120002', '+91 98765 43211'),
('Amit Singh', 'CH01 20120003', '+91 98765 43212'),
('Priya Desai', 'CH01 20120004', '+91 98765 43213'),
('Vikram Bhatt', 'CH01 20120005', '+91 98765 43214'),
('Anita Reddy', 'CH01 20120006', '+91 98765 43215'),
('Karan Malhotra', 'CH01 20120007', '+91 98765 43216'),
('Geeta Mohan', 'CH01 20120008', '+91 98765 43217'),
('Pradeep Nair', 'CH01 20120009', '+91 98765 43218'),
('Lata Pillai', 'CH01 20120010', '+91 98765 43219');

-- Inserting dummy data into the Buses table
INSERT INTO "Buses" ("RegistrationNumber", "Capacity", "Type", "DriverID") VALUES 
('CH01 TB 0001', 32, 'Standard', 1),
('CH01 TB 0002', 40, 'Deluxe', 2),
('CH01 TB 0003', 50, 'Electric', 3),
('CH01 TB 0004', 30, 'Mini', 4),
('CH01 TB 0005', 45, 'Standard', 5),
('CH01 TB 0006', 35, 'Mini', 6),
('CH01 TB 0007', 50, 'Electric', 7),
('CH01 TB 0008', 40, 'Deluxe', 8),
('CH01 TB 0009', 32, 'Standard', 9),
('CH01 TB 0010', 45, 'Standard', 10);

-- Inserting dummy data into the Routes table
INSERT INTO "Routes" ("StartPoint", "EndPoint", "EstimatedDuration") VALUES 
('Sector 17', 'Sector 31', '00:15:00'),
('Sector 10', 'Manimajra', '00:20:00'),
('Sector 21', 'IT Park', '00:22:00'),
('Sector 15', 'Elante Mall', '00:18:00'),
('Sector 9', 'Rock Garden', '00:12:00'),
('Sector 34', 'Chandigarh Railway Station', '00:25:00'),
('Sector 26', 'Sukhna Lake', '00:10:00'),
('Mohali', 'Panchkula', '00:30:00'),
('Zirakpur', 'Sector 43 ISBT', '00:35:00'),
('Sector 11', 'Capitol Complex', '00:08:00');

-- Inserting dummy data into the Schedules table
INSERT INTO "Schedules" ("RouteID", "BusID", "DriverID", "DepartureTime") VALUES 
(1, 1, 1, '2024-03-07 06:30:00'),
(2, 2, 2, '2024-03-07 07:00:00'),
(3, 3, 3, '2024-03-07 07:30:00'),
(4, 4, 4, '2024-03-07 08:00:00'),
(5, 5, 5, '2024-03-07 08:30:00'),
(6, 6, 6, '2024-03-07 09:00:00'),
(7, 7, 7, '2024-03-07 09:30:00'),
(8, 8, 8, '2024-03-07 10:00:00'),
(9, 9, 9, '2024-03-07 10:30:00'),
(10, 10, 10, '2024-03-07 11:00:00');

-- Inserting dummy data into the Passengers table
INSERT INTO "Passengers" ("Name", "Email", "ContactNumber", "Age", "Gender") VALUES 
('Manpreet Kaur', 'manpreet.kaur@example.com', '+91 97653 44210', 24, 'f'),
('Rahul Jain', 'rahul.jain@example.com', '+91 97653 44211', 30, 'm'),
('Neha Sharma', 'neha.sharma@example.com', '+91 97653 44212', 27, 'f'),
('Aarav Patel', 'aarav.patel@example.com', '+91 97653 44213', 33, 'm'),
('Riya Mehta', 'riya.mehta@example.com', '+91 97653 44214', 21, 'f'),
('Sohail Khan', 'sohail.khan@example.com', '+91 97653 44215', 45, 'm'),
('Anjali Singh', 'anjali.singh@example.com', '+91 97653 44216', 29, 'f'),
('Vishal Rana', 'vishal.rana@example.com', '+91 97653 44217', 52, 'm'),
('Kirti Chawla', 'kirti.chawla@example.com', '+91 97653 44218', 37, 'f'),
('Gurpreet Sidhu', 'gurpreet.sidhu@example.com', '+91 97653 44219', 41, 'm');

-- Inserting dummy data into the Tickets table
INSERT INTO "Tickets" ("ScheduleID", "PassengerID", "SeatNumber", "Price") VALUES 
(1, 1, 1, 20.0),
(2, 2, 2, 30.0),
(3, 3, 3, 25.0),
(4, 4, 4, 20.0),
(5, 5, 5, 30.0),
(6, 6, 6, 25.0),
(7, 7, 7, 20.0),
(8, 8, 8, 30.0),
(9, 9, 9, 25.0),
(10, 10, 10, 20.0);

-- Inserting dummy data into the MaintenanceRecords table
INSERT INTO "MaintenanceRecords" ("BusID", "MaintenanceDate", "Details", "Cost") VALUES 
(1, '2023-01-10 09:00:00', 'Oil Change', 1000.0),
(2, '2023-02-15 10:00:00', 'Brake Check', 800.0),
(3, '2023-03-20 11:00:00', 'Tire Replacement', 1200.0),
(4, '2023-04-25 12:00:00', 'Battery Replacement', 4500.0),
(5, '2023-05-30 13:00:00', 'Air Filter Change', 750.0),
(6, '2023-06-04 14:00:00', 'General Inspection', 500.0),
(7, '2023-07-09 15:00:00', 'Engine Tune-up', 1500.0),
(8, '2023-08-14 16:00:00', 'AC Repair', 2000.0),
(9, '2023-09-19 17:00:00', 'Suspension Check', 1100.0),
(10, '2023-10-24 18:00:00', 'Full Service', 3000.0);