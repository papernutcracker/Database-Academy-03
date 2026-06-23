USE Academy;
GO

PRINT '1. Вивести кількість викладачів кафедри «Software Development».';
SELECT COUNT(DISTINCT T.Id) AS TeacherCount
FROM Teachers T
JOIN Lectures L ON T.Id = L.TeacherId
JOIN GroupsLectures GL ON L.Id = GL.LectureId
JOIN Groups G ON GL.GroupId = G.Id
JOIN Departments D ON G.DepartmentId = D.Id
WHERE D.Name = N'Software Development';

PRINT '2. Вивести кількість лекцій, які читає викладач «Dave McQueen».';
SELECT COUNT(L.Id) AS LectureCount
FROM Lectures L
JOIN Teachers T ON L.TeacherId = T.Id
WHERE T.Name = N'Dave' AND T.Surname = N'McQueen';

PRINT '3. Вивести кількість занять, які проводяться в аудиторії «D201».';
SELECT COUNT(Id) AS LectureCount
FROM Lectures
WHERE LectureRoom = N'D201';

PRINT '4. Вивести назви аудиторій та кількість лекцій, що проводяться в них.';
SELECT LectureRoom, COUNT(Id) AS LectureCount
FROM Lectures
GROUP BY LectureRoom;

PRINT '5. Вивести кількість студентів, які відвідують лекції викладача «Jack Underhill».';
SELECT SUM(G.Students) AS TotalStudents
FROM Groups G
WHERE G.Id IN (
    SELECT DISTINCT GL.GroupId
    FROM GroupsLectures GL
    JOIN Lectures L ON GL.LectureId = L.Id
    JOIN Teachers T ON L.TeacherId = T.Id
    WHERE T.Name = N'Jack' AND T.Surname = N'Underhill'
);

PRINT '6. Вивести середню ставку викладачів факультету «Computer Science».';
SELECT AVG(T.Salary) AS AverageSalary
FROM Teachers T
WHERE T.Id IN (
    SELECT DISTINCT L.TeacherId
    FROM Lectures L
    JOIN GroupsLectures GL ON L.Id = GL.LectureId
    JOIN Groups G ON GL.GroupId = G.Id
    JOIN Departments D ON G.DepartmentId = D.Id
    JOIN Faculties F ON D.FacultyId = F.Id
    WHERE F.Name = N'Computer Science'
);

PRINT '7. Вивести мінімальну та максимальну кількість студентів серед усіх груп.';
SELECT MIN(Students) AS MinStudents, MAX(Students) AS MaxStudents
FROM Groups;

PRINT '8. Вивести середній фонд фінансування кафедр.';
SELECT AVG(Financing) AS AverageFinancing
FROM Departments;

PRINT '9. Вивести повні імена викладачів та кількість читаних ними дисциплін.';
SELECT T.Name + ' ' + T.Surname AS FullName, COUNT(DISTINCT L.SubjectId) AS SubjectCount
FROM Teachers T
LEFT JOIN Lectures L ON T.Id = L.TeacherId
GROUP BY T.Id, T.Name, T.Surname;

PRINT '10. Вивести кількість лекцій щодня протягом тижня.';
SELECT DayOfWeek, COUNT(Id) AS LectureCount
FROM Lectures
GROUP BY DayOfWeek;

PRINT '11. Вивести номери аудиторій та кількість кафедр, чиї лекції в них читаються.';
SELECT L.LectureRoom, COUNT(DISTINCT G.DepartmentId) AS DepartmentCount
FROM Lectures L
JOIN GroupsLectures GL ON L.Id = GL.LectureId
JOIN Groups G ON GL.GroupId = G.Id
GROUP BY L.LectureRoom;

PRINT '12. Вивести назви факультетів та кількість дисциплін, які на них читаються.';
SELECT F.Name AS FacultyName, COUNT(DISTINCT L.SubjectId) AS SubjectCount
FROM Faculties F
JOIN Departments D ON F.Id = D.FacultyId
JOIN Groups G ON D.Id = G.DepartmentId
JOIN GroupsLectures GL ON G.Id = GL.GroupId
JOIN Lectures L ON GL.LectureId = L.Id
GROUP BY F.Id, F.Name;