USE Academy;
GO

ALTER TABLE Departments ADD Building INT NOT NULL DEFAULT 1;
GO
UPDATE Departments SET Building = 2 WHERE Id % 2 = 0;
UPDATE Departments SET Building = 3 WHERE Id = 1;
GO

ALTER TABLE Lectures ADD Week INT NOT NULL DEFAULT 1;
GO

ALTER TABLE Groups ADD Rating DECIMAL(5,2) NOT NULL DEFAULT 60.00;
GO

IF NOT EXISTS (SELECT 1 FROM Groups WHERE Name = 'D221')
BEGIN
    INSERT INTO Groups (Name, Year, DepartmentId, Students, Rating) 
    VALUES ('D221', 5, 1, 20, 75.50);
END
GO
UPDATE Groups SET Rating = 85.00 WHERE Name LIKE '%SD%' AND Year = 5;
GO

ALTER TABLE Teachers ADD Position NVARCHAR(50) NOT NULL DEFAULT N'Assistant';
GO
UPDATE Teachers SET Position = N'Professor' WHERE Id IN (1, 2);
GO

IF OBJECT_ID('Curators', 'U') IS NULL
BEGIN
    CREATE TABLE Curators (
        Id INT IDENTITY(1,1) NOT NULL,
        Name NVARCHAR(MAX) NOT NULL,
        Surname NVARCHAR(MAX) NOT NULL,
        CONSTRAINT PK_Curators PRIMARY KEY (Id)
    );
    INSERT INTO Curators (Name, Surname) VALUES (N'Alexander', N'Green'), (N'Maria', N'Brown');
END
GO

IF OBJECT_ID('GroupsCurators', 'U') IS NULL
BEGIN
    CREATE TABLE GroupsCurators (
        Id INT IDENTITY(1,1) NOT NULL,
        GroupId INT NOT NULL,
        CuratorId INT NOT NULL,
        CONSTRAINT PK_GroupsCurators PRIMARY KEY (Id),
        CONSTRAINT FK_GroupsCurators_Groups FOREIGN KEY (GroupId) REFERENCES Groups(Id),
        CONSTRAINT FK_GroupsCurators_Curators FOREIGN KEY (CuratorId) REFERENCES Curators(Id)
    );
    INSERT INTO GroupsCurators (GroupId, CuratorId) VALUES (1, 1), (1, 2);
END
GO
