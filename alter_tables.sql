USE Academy;
GO

ALTER TABLE Groups ADD Students INT NOT NULL DEFAULT 15;
GO

UPDATE Groups SET Students = 25 WHERE Id % 2 = 0;
UPDATE Groups SET Students = 18 WHERE Id % 3 = 0;
GO

ALTER TABLE Lectures ADD DayOfWeek INT NOT NULL DEFAULT 1;
GO

UPDATE Lectures SET DayOfWeek = (Id % 5) + 1;
GO