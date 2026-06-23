USE Academy;
GO

INSERT INTO Faculties (Name) VALUES 
(N'Computer Science'),
(N'Information Technology'),
(N'Engineering');

INSERT INTO Teachers (Name, Surname, Salary) VALUES 
(N'Dave', N'McQueen', 2500.00),
(N'Jack', N'Underhill', 3000.00),
(N'Elena', N'Petrova', 2200.00),
(N'John', N'Smith', 1800.00);

INSERT INTO Subjects (Name) VALUES 
(N'Introduction to Programming'),
(N'Databases'),
(N'Software Architecture'),
(N'Web Development'),
(N'Algorithms');

INSERT INTO Departments (Name, Financing, FacultyId) VALUES 
(N'Software Development', 50000.00, 1),
(N'Cybersecurity', 40000.00, 1),
(N'Data Science', 60000.00, 2);

INSERT INTO Groups (Name, Year, DepartmentId, Students) VALUES 
(N'SD-11', 1, 1, 25),
(N'SD-21', 2, 1, 18),
(N'CS-31', 3, 2, 30),
(N'DS-11', 1, 3, 15);

INSERT INTO Lectures (DayOfWeek, LectureRoom, SubjectId, TeacherId) VALUES 
(1, N'D201', 1, 1), 
(1, N'D202', 2, 2),
(2, N'D201', 3, 1),
(3, N'B105', 4, 2),
(4, N'D201', 5, 3),
(5, N'C303', 2, 2); 

INSERT INTO GroupsLectures (GroupId, LectureId) VALUES 
(1, 1), 
(2, 1), 
(3, 2), 
(1, 3), 
(3, 4), 
(2, 5), 
(3, 6); 