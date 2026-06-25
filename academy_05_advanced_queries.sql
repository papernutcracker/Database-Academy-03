USE Academy;
GO

PRINT '1. Номери корпусів, де сумарний фонд фінансування кафедр перевищує 100000';
SELECT Building
FROM Departments
GROUP BY Building
HAVING SUM(Financing) > 100000;

PRINT '2. Назви груп 5-го курсу кафедри «Software Development», які мають понад 10 пар на перший тиждень';
SELECT G.Name
FROM Groups G
JOIN Departments D ON G.DepartmentId = D.Id
JOIN GroupsLectures GL ON G.Id = GL.GroupId
JOIN Lectures L ON GL.LectureId = L.Id
WHERE G.Year = 5 
  AND D.Name = N'Software Development' 
  AND L.Week = 1
GROUP BY G.Id, G.Name
HAVING COUNT(L.Id) > 10;

PRINT '3. Назви груп, які мають рейтинг більший, ніж рейтинг групи «D221»';
SELECT Name 
FROM Groups 
WHERE Rating > (SELECT Rating FROM Groups WHERE Name = 'D221');

PRINT '4. Прізвища та імена викладачів, ставка яких вища за середню ставку професорів';
SELECT Name, Surname 
FROM Teachers 
WHERE Salary > (SELECT AVG(Salary) FROM Teachers WHERE Position = N'Professor');

PRINT '5. Назви груп, які мають більше одного куратора';
SELECT G.Name
FROM Groups G
JOIN GroupsCurators GC ON G.Id = GC.GroupId
GROUP BY G.Id, G.Name
HAVING COUNT(GC.CuratorId) > 1;

PRINT '6. Назви груп, які мають рейтинг менший, ніж мінімальний рейтинг груп 5-го курсу';
SELECT Name 
FROM Groups 
WHERE Rating < (SELECT MIN(Rating) FROM Groups WHERE Year = 5);

PRINT '7. Назви факультетів, де фінансування кафедр більше, ніж на «Computer Science»';
SELECT F.Name
FROM Faculties F
JOIN Departments D ON F.Id = D.FacultyId
GROUP BY F.Id, F.Name
HAVING SUM(D.Financing) > (
    SELECT SUM(D2.Financing) 
    FROM Departments D2 
    JOIN Faculties F2 ON D2.FacultyId = F2.Id 
    WHERE F2.Name = N'Computer Science'
);

PRINT '8. Назви дисциплін та повні імена викладачів, які читають найбільшу кількість лекцій з них';
WITH LectureCounts AS (
    SELECT SubjectId, TeacherId, COUNT(Id) AS LCount,
           MAX(COUNT(Id)) OVER(PARTITION BY SubjectId) AS MaxLCount
    FROM Lectures
    GROUP BY SubjectId, TeacherId
)
SELECT S.Name AS SubjectName, T.Name + ' ' + T.Surname AS TeacherName
FROM LectureCounts LC
JOIN Subjects S ON LC.SubjectId = S.Id
JOIN Teachers T ON LC.TeacherId = T.Id
WHERE LC.LCount = LC.MaxLCount;

PRINT '9. Назва дисципліни, за якою читається найменше лекцій';
SELECT TOP 1 S.Name
FROM Subjects S
LEFT JOIN Lectures L ON S.Id = L.SubjectId
GROUP BY S.Id, S.Name
ORDER BY COUNT(L.Id) ASC;

PRINT '10. Кількість студентів та дисциплін на кафедрі «Software Development»';
SELECT SUM(DISTINCT G.Students) AS TotalStudents, COUNT(DISTINCT L.SubjectId) AS TotalSubjects
FROM Departments D
LEFT JOIN Groups G ON D.Id = G.DepartmentId
LEFT JOIN GroupsLectures GL ON G.Id = GL.GroupId
LEFT JOIN Lectures L ON GL.LectureId = L.Id
WHERE D.Name = N'Software Development';
