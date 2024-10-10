/*
TSQL - Transact Structured Query Language
1 - DDL
2 - DML
3 - DCL
*/

-- DDL

Create Database FirstDB

Create Database CreateSampleDB
On Primary
(
	Name = "CreateSampleDB_1",
	FileName = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\CreateSampleDB_1.mdf' , -- N unicode için
	Size = 64MB,
	FILEGROWTH = 32MB,
	MAXSIZE = UNLIMITED
),
(
	Name = "CreateSampleDB_2",
	FileName = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\CreateSampleDB_2.ndf' , -- N unicode için
	Size = 64MB,
	FILEGROWTH = 32MB,
	MAXSIZE = UNLIMITED
)
LOG ON
(
	Name = "CreateSampleDB_log_1",
	FileName = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\CreateSampleDB_log_1.ldf' , -- N unicode için
	Size = 16MB,
	FILEGROWTH = 16MB,
	MAXSIZE = UNLIMITED
),
(
	Name = "CreateSampleDB_log_2",
	FileName = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\CreateSampleDB_log_2.ldf' , -- N unicode için
	Size = 16MB,
	FILEGROWTH = 16MB,
	MAXSIZE = UNLIMITED
)

use [CreateSampleDB]

Create Table Person
(
	PersonID int Identity(1,1) NOT NULL,
	FirstName nvarchar(50) NOT NULL,
	LastName nvarchar(50) NOT NULL,
	[Address] nvarchar(200) NULL,
	City nvarchar(100) NULL,
)

-- Primary Key and Default Constraints
Create Table Student
(
	StudentID int identity(1, 1) Primary Key NOT NULL,
	FirstName nvarchar(50) NOT NULL,
	LastName nvarchar(50) NOT NULL,
	Gender bit NOT NULL Default(0),
	Age int NOT NULL
)

Create Table Product
(
	ProductID int identity(1, 1) NOT NULL,
	ProductName nvarchar(200) NOT NULL,
	[Description] nvarchar(500), -- Default NULL olur
	Price decimal(18, 2) NOT NULL,
	[State] bit NOT NULL Default(1),
	Primary Key(ProductID) -- Virgül koyup diðer columnlarý ekleyebilirsin
)

Create Table Category
(
	CategoryID int identity(1, 1) NOT NULL,
	CategoryName nvarchar(100) NOT NULL,
	CategoryDescription nvarchar(300) NOT NULL,
	[State] bit NOT NULL,
	Constraint PK_CategoryID primary key(CategoryID) 
	-- Constraint PK_CategoryID primary key(CategoryID, CategoryName) 
)

-- Unique Constraint
Create Table Supplier 
(
	SupplierID int identity(1, 1),
	SupplierName nvarchar(200) NOT NULL,
	Unique(SupplierID), -- 1st way
)

Create Table Supplier_2 
(
	SupplierID int identity(1, 1) UNIQUE, -- 2nd way
	SupplierName nvarchar(200) NOT NULL,
)

Create Table Supplier_3 
(
	SupplierID int identity(1, 1),
	SupplierName nvarchar(200) NOT NULL,
	Constraint UQ_SupplierID UNIQUE(SupplierID), -- 3rd way (naming bana ait)
)

truncate table [dbo].[Student] -- Verinin hepsini siler, Id yeniden 1'den baþlar

-- New Column ekleme
ALTER TABLE [dbo].[Person]
ADD Email nvarchar(100) NOT NULL

-- Column'un datatype'ýný deðiþtirme
ALTER TABLE [dbo].[Person]
ALTER COLUMN Email nvarchar(200) NULL

-- Column silme
ALTER TABLE [dbo].[Person]
DROP COLUMN Email 

-- Sonrada PK ekleme (Create edilmiþ table fakat PK eklemeyi unuttuk)
ALTER TABLE [dbo].[Person]
ADD PRIMARY KEY(PersonID)

-- Bu PK'yi silmek istedim:
ALTER TABLE [dbo].[Person]
DROP CONSTRAINT [PK__Person__AA2FFB85AF49F272]

-- Kendim isim vermek istediðim bir PK eklemek için
ALTER TABLE [dbo].[Person]
ADD CONSTRAINT PK_Person PRIMARY KEY(PersonID)

-- Check Constraint
ALTER TABLE [dbo].[Student]
ADD CONSTRAINT CK_Age CHECK(Age > 0 AND Age < 120) -- Koþulu deðiþtirmek için ya silip yeniden oluþturacaksýn ya da Designer'den yapacaksýn

-- Table silmek:
DROP TABLE [dbo].[Person]

-- Database silmek:
-- DROP DATABASE [CreateSampleDB]
