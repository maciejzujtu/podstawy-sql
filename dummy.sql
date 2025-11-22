/*
 * Prosta baza danych, na potrzeby demonstracji działania róznych kwerend
 * zawartch w skrypcie.
 */

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    LastName VARCHAR(50) NOT NULL,
    FirstName VARCHAR(50),
    DepartmentID INT
);

INSERT INTO Departments (DepartmentID, DepartmentName) VALUES 
    (31, 'Sales'),    
    (32, 'Engineering'),    
    (33, 'Marketing'),
    (34, 'Human Resources'),
    (35, 'Finance');

INSERT INTO Employees (EmployeeID, LastName, FirstName, DepartmentID) VALUES 
    (1, 'Smith',  'John',   33),
    (2, 'Jones',  'David',  33),
    (3, 'Brown',  'Sarah',  31),
    (4, 'Wilson', 'Mike',   32),
    (5, 'Taylor', 'Anna',   32),
    (6, 'Smith',  'Emily',  31),
    (7, 'Moore',  'Chris',  34),
    (8, 'White',  'Laura',  34),
    (9, 'Harris', 'Tom',    31),