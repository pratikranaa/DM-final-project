
# Design Document for Chandigarh Transport Undertaking (CTU) Database

## Scope

This document outlines the database design for managing the operations of the Chandigarh Transport Undertaking (CTU). The database is scoped to include entities that are critical for the day-to-day management of public bus services offered by CTU, including managing buses, drivers, routes, schedules, passengers, tickets, and maintenance records. The focus is on facilitating efficient scheduling, ticketing, and maintenance operations while ensuring ease of access and management of data related to buses, drivers, passengers, and routes.

## Functional Requirements

The CTU database is designed to support:

Maintenance of buses, drivers, and routes information.
Scheduling of buses on various routes with designated drivers.
Booking and management of passenger tickets.
Tracking and recording of maintenance activities for buses.
Searching and reporting capabilities for operational efficiency and decision support.

## Representation

### Entities

The database comprises several entities including Buses, Drivers, Routes, Schedules, Passengers, Tickets, and MaintenanceRecords, each designed to hold specific information relevant to the functioning of the CTU.

#### Buses

The Buses table includes:

BusID: The unique identifier for each bus as an INTEGER. This column is auto-incremented and has the PRIMARY KEY constraint applied.
RegistrationNumber: The registration number of the bus as TEXT, ensuring uniqueness and easy identification.
Capacity: The seating capacity of the bus as INTEGER, important for scheduling and ticketing operations.
Type: The type of the bus (e.g., standard, electric) as TEXT, for operational and maintenance considerations.
DriverID: A reference to the Drivers table, indicating the primary driver assigned to the bus. This is a FOREIGN KEY that references DriverID in the Drivers table.

#### Drivers

The Drivers table includes:

DriverID: The unique identifier for each driver as an INTEGER. This column is auto-incremented and has the PRIMARY KEY constraint applied.
Name: The full name of the driver as TEXT.
LicenseNumber: The driver's license number as TEXT, unique to each driver.
ContactDetails: Contact information for the driver, stored as TEXT.

#### Routes

The Routes table includes:

RouteID: The unique identifier for each route as an INTEGER. This column is auto-incremented and has the PRIMARY KEY constraint applied.
StartPoint: The starting point of the route as TEXT.
EndPoint: The ending point of the route as TEXT.
EstimatedDuration: The estimated duration of the route as TEXT, to help with scheduling and passenger information.

#### Schedules

The Schedules table includes:

ScheduleID: The unique identifier for each schedule as an INTEGER. This column is auto-incremented and has the PRIMARY KEY constraint applied.
RouteID: A reference to the Routes table, indicating which route is being scheduled. This is a FOREIGN KEY that references RouteID in the Routes table.
BusID: A reference to the Buses table, indicating which bus is scheduled. This is a FOREIGN KEY that references BusID in the Buses table.
DriverID: A reference to the Drivers table, indicating which driver is scheduled. This is a FOREIGN KEY that references DriverID in the Drivers table.
DepartureTime: The scheduled departure time as DATETIME, important for passenger information and operations management.

#### Passengers

The Passengers table includes:

PassengerID: The unique identifier for each passenger as an INTEGER. This column is auto-incremented and has the PRIMARY KEY constraint applied.
Name: The full name of the passenger as TEXT.
Email: The email address of the passenger as TEXT, unique to ensure communication and ticketing.
ContactNumber: The contact number of the passenger as TEXT.
Age: The age of the passenger as INTEGER.
Gender: The gender of the passenger as TEXT, with a CHECK constraint to ensure values are within ('m', 'f', 'others').

#### Tickets

The Tickets table includes:

TicketID: The unique identifier for each ticket as an INTEGER. This column is auto-incremented and has the PRIMARY KEY constraint applied.
ScheduleID: A reference to the Schedules table, indicating for which schedule the ticket is issued. This is a FOREIGN KEY that references ScheduleID in the Schedules table.
PassengerID: A reference to the Passengers table, indicating which passenger the ticket is issued to. This is a FOREIGN KEY that references PassengerID in the Passengers table.
SeatNumber: The seat number assigned on the ticket as INTEGER.
Price: The price of the ticket as REAL, reflecting the cost of travel.

#### MaintenanceRecords

The MaintenanceRecords table includes:

RecordID: The unique identifier for each maintenance record as an INTEGER. This column is auto-incremented and has the PRIMARY KEY constraint applied.
BusID: A reference to the Buses table, indicating which bus underwent maintenance. This is a FOREIGN KEY that references BusID in the Buses table.
MaintenanceDate: The date of maintenance as DATETIME, important for tracking and scheduling future maintenance.
Details: Details of the maintenance performed as TEXT, for record-keeping and analysis.
Cost: The cost of maintenance as REAL, for financial tracking and budgeting.

## Relationships

The design incorporates relationships between entities to ensure data integrity and relational integrity. These relationships are enforced through FOREIGN KEY constraints, linking buses to drivers, schedules to routes, buses, and drivers, and tickets to schedules and passengers. Additionally, maintenance records are linked to specific buses.

## Optimizations

To improve query performance and support efficient data retrieval, indexes may be created on frequently queried columns such as RegistrationNumber in Buses, LicenseNumber in Drivers, and Email in Passengers. Additionally, careful consideration will be given to the indexing of foreign keys to support joins between tables.

## Limitations

The current schema is designed with simplicity and core functionalities in mind. It may require extensions or modifications to accommodate future enhancements such as handling multiple drivers per bus, complex ticketing schemes (e.g., discounts, promotions), or detailed passenger profiles (e.g., special needs, loyalty programs).

## Conclusion

This design document provides a comprehensive overview of the database schema for the Chandigarh Transport Undertaking (CTU), aimed at supporting the organization's operational needs while ensuring data integrity, efficiency, and scalability. Future enhancements and optimizations may be considered as operational requirements evolve.
