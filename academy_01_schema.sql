CREATE DATABASE Academy;
GO
USE Academy;
GO

CREATE TABLE Faculties (
    Id INT IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_Faculties PRIMARY KEY (Id),
    CONSTRAINT UQ_Faculties_Name UNIQUE (Name),
    CONSTRAINT CHK_Faculties_Name CHECK (Name <> '')
);

CREATE TABLE Teachers (
    Id INT IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(MAX) NOT NULL,
    Salary MONEY NOT NULL,
    Surname NVARCHAR(MAX) NOT NULL,
    CONSTRAINT PK_Teachers PRIMARY KEY (Id),
    CONSTRAINT CHK_Teachers_Name CHECK (Name <> ''),
    CONSTRAINT CHK_Teachers_Surname CHECK (Surname <> ''),
    CONSTRAINT CHK_Teachers_Salary CHECK (Salary > 0)
);

CREATE TABLE Subjects (
    Id INT IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    CONSTRAINT PK_Subjects PRIMARY KEY (Id),
    CONSTRAINT UQ_Subjects_Name UNIQUE (Name),
    CONSTRAINT CHK_Subjects_Name CHECK (Name <> '')
);

CREATE TABLE Departments (
    Id INT IDENTITY(1,1) NOT NULL,
    Financing MONEY NOT NULL DEFAULT 0,
    Name NVARCHAR(100) NOT NULL,
    FacultyId INT NOT NULL,
    CONSTRAINT PK_Departments PRIMARY KEY (Id),
    CONSTRAINT UQ_Departments_Name UNIQUE (Name),
    CONSTRAINT CHK_Departments_Name CHECK (Name <> ''),
    CONSTRAINT CHK_Departments_Financing CHECK (Financing >= 0),
    CONSTRAINT FK_Departments_Faculties FOREIGN KEY (FacultyId) REFERENCES Faculties(Id)
);

CREATE TABLE Groups (
    Id INT IDENTITY(1,1) NOT NULL,
    Name NVARCHAR(10) NOT NULL,
    Year INT NOT NULL,
    DepartmentId INT NOT NULL,
    Students INT NOT NULL DEFAULT 0,
    CONSTRAINT PK_Groups PRIMARY KEY (Id),
    CONSTRAINT UQ_Groups_Name UNIQUE (Name),
    CONSTRAINT CHK_Groups_Name CHECK (Name <> ''),
    CONSTRAINT CHK_Groups_Year CHECK (Year BETWEEN 1 AND 5),
    CONSTRAINT CHK_Groups_Students CHECK (Students >= 0),
    CONSTRAINT FK_Groups_Departments FOREIGN KEY (DepartmentId) REFERENCES Departments(Id)
);

CREATE TABLE Lectures (
    Id INT IDENTITY(1,1) NOT NULL,
    DayOfWeek INT NOT NULL,
    LectureRoom NVARCHAR(MAX) NOT NULL,
    SubjectId INT NOT NULL,
    TeacherId INT NOT NULL,
    CONSTRAINT PK_Lectures PRIMARY KEY (Id),
    CONSTRAINT CHK_Lectures_DayOfWeek CHECK (DayOfWeek BETWEEN 1 AND 7),
    CONSTRAINT CHK_Lectures_LectureRoom CHECK (LectureRoom <> ''),
    CONSTRAINT FK_Lectures_Subjects FOREIGN KEY (SubjectId) REFERENCES Subjects(Id),
    CONSTRAINT FK_Lectures_Teachers FOREIGN KEY (TeacherId) REFERENCES Teachers(Id)
);

CREATE TABLE GroupsLectures (
    Id INT IDENTITY(1,1) NOT NULL,
    GroupId INT NOT NULL,
    LectureId INT NOT NULL,
    CONSTRAINT PK_GroupsLectures PRIMARY KEY (Id),
    CONSTRAINT FK_GroupsLectures_Groups FOREIGN KEY (GroupId) REFERENCES Groups(Id),
    CONSTRAINT FK_GroupsLectures_Lectures FOREIGN KEY (LectureId) REFERENCES Lectures(Id)
);
