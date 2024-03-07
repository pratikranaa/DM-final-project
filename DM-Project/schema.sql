DROP TABLE IF EXISTS "Buses";
DROP TABLE IF EXISTS "Drivers";
DROP TABLE IF EXISTS "Routes";
DROP TABLE IF EXISTS "Schedules";
DROP TABLE IF EXISTS "Passengers";
DROP TABLE IF EXISTS "Tickets";
DROP TABLE IF EXISTS "MaintenanceRecords";


-- Buses Table
CREATE TABLE IF NOT EXISTS "Buses" (
    "BusID" INTEGER PRIMARY KEY AUTOINCREMENT,
    "RegistrationNumber" TEXT NOT NULL,
    "Capacity" INTEGER NOT NULL,
    "Type" TEXT NOT NULL,
    "DriverID" INTEGER,
    FOREIGN KEY ("DriverID") REFERENCES "Drivers"("DriverID")
);

-- Drivers Table
CREATE TABLE IF NOT EXISTS "Drivers" (
    "DriverID" INTEGER PRIMARY KEY AUTOINCREMENT,
    "Name" TEXT NOT NULL,
    "LicenseNumber" TEXT NOT NULL UNIQUE,
    "ContactDetails" TEXT
);

-- Routes Table
CREATE TABLE IF NOT EXISTS "Routes" (
    "RouteID" INTEGER PRIMARY KEY AUTOINCREMENT,
    "StartPoint" TEXT NOT NULL,
    "EndPoint" TEXT NOT NULL,
    "EstimatedDuration" TEXT NOT NULL
);

-- Schedules Table
CREATE TABLE IF NOT EXISTS "Schedules" (
    "ScheduleID" INTEGER PRIMARY KEY AUTOINCREMENT,
    "RouteID" INTEGER NOT NULL,
    "BusID" INTEGER NOT NULL,
    "DriverID" INTEGER NOT NULL,
    "DepartureTime" DATETIME NOT NULL,
    FOREIGN KEY ("RouteID") REFERENCES "Routes"("RouteID"),
    FOREIGN KEY ("BusID") REFERENCES "Buses"("BusID"),
    FOREIGN KEY ("DriverID") REFERENCES "Drivers"("DriverID")
);

-- Passengers Table
CREATE TABLE IF NOT EXISTS "Passengers" (
    "PassengerID" INTEGER PRIMARY KEY AUTOINCREMENT,
    "Name" TEXT NOT NULL,
    "Email" TEXT NOT NULL UNIQUE,
    "ContactNumber" TEXT,
    "Age" INTEGER,
    "Gender" TEXT CHECK("Gender" IN ('m', 'f', 'others'))
);

-- Tickets Table
CREATE TABLE IF NOT EXISTS "Tickets" (
    "TicketID" INTEGER PRIMARY KEY AUTOINCREMENT,
    "ScheduleID" INTEGER NOT NULL,
    "PassengerID" INTEGER NOT NULL,
    "SeatNumber" INTEGER NOT NULL,
    "Price" REAL NOT NULL,
    FOREIGN KEY ("ScheduleID") REFERENCES "Schedules"("ScheduleID"),
    FOREIGN KEY ("PassengerID") REFERENCES "Passengers"("PassengerID")
);

-- MaintenanceRecords Table
CREATE TABLE IF NOT EXISTS "MaintenanceRecords" (
    "RecordID" INTEGER PRIMARY KEY AUTOINCREMENT,
    "BusID" INTEGER NOT NULL,
    "MaintenanceDate" DATETIME NOT NULL,
    "Details" TEXT NOT NULL,
    "Cost" REAL NOT NULL,
    FOREIGN KEY ("BusID") REFERENCES "Buses"("BusID")
);
