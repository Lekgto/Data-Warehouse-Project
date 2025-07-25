USE [CSID6853_LekgethoK]
GO
/****** Object:  StoredProcedure [dbo].[spCreateDM]    Script Date: 6/1/2025 3:12:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure  [dbo].[spCreateDM]
as begin

 drop table Country_Stage; drop table FactManufacturing; drop table FactInventory; drop table DimMachine; drop table DimMachineType; drop table DimPlant; drop table DimCountry;
drop table DimBatch; drop table DimProduct; drop table DimProductSubtype; drop table DimDate; drop table DimMaterial; drop table DimProductType; 

IF not EXISTS (
    SELECT * 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_SCHEMA = 'dbo' 
      AND TABLE_NAME = 'Country_Stage'
) 
begin
CREATE TABLE  Country_Stage (COUNTRY_ID numeric, COUNTRY nvarchar(50), COUNTRY_PARENT numeric, COUNTRY_TYPE nvarchar(1))
end 

create table DimProductType (ProductTypeCode int Primary Key, ProductTypeName nvarchar(50));

create table DimMaterial (MaterialKey int identity(1,1) Primary Key , Material nvarchar(50));

create table DimDate( Date date primary key, Year int, Quarter int, Month int, MonthName nvarchar(50), YearMonth nvarchar(50), YearQuarter nvarchar(50));

create table DimProductSubtype ( ProductSubtypeCode int identity(1,1) Primary Key, ProductSubtypeName nvarchar(50), ProductTypeCode int,
								foreign key (ProductTypeCode) references DimProductType(ProductTypeCode));

create table DimProduct (ProductCode int  identity(1,1) Primary Key, ProductName nvarchar(50), ProductSubtypeCode int,
							foreign key (ProductSubtypeCode) references DimProductSubtype(ProductSubtypeCode));

create table DimBatch (BatchNumber int identity(1,1)  primary key,  BatchName nvarchar(50));

create table DimCountry (CountryKey int  identity(1,1) primary key, CountryCode nchar(2), CountryName nvarchar(50), Region nvarchar(50), Account nvarchar(50));

create table DimPlant (PlantNumber int identity(1,1)  primary key, PlantName nvarchar(50), CountryKey int,
						foreign key (CountryKey) references DimCountry(CountryKey));

create table DimMachineType (MachineTypeKey int identity(1,1)  primary key, MachineType nvarchar(50), MaterialKey int)

create table DimMachine (MachineNumber int identity(1,1)  primary key, MachineName nvarchar(50), MachineTypeKey int, PlantNumber int, Manufacturer nvarchar(50), DateOfPurchase date,
							foreign key (MachineTypeKey) references DimMachineType(MachineTypeKey));

Create table FactInventory (InventoryLevel int, NumberOnBackOrder int, DateOfInventory date, ProductCode int, MaterialKey int,
							foreign key (DateOfInventory) references DimDate(Date),
							foreign key (ProductCode) references DimProduct(ProductCode),
							foreign key (MaterialKey) references DimMaterial(MaterialKey));

Create table FactManufacturing (AcceptedProducts int, RejectedProducts int, ElapsedTimeForManufacture nvarchar(50), DateOfManufacture date, ProductCode int, 
								BatchNumber int, MachineNumber int,
								foreign key (DateOfManufacture) references DimDate(Date),
								foreign key (ProductCode) references DimProduct(ProductCode),
								foreign key (BatchNumber) references DimBatch(BatchNumber),
								foreign key (MachineNumber) references DimMachine(MachineNumber));

end;


