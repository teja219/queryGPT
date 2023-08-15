USE [master]

-- Drop constraints if they exist
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_submarket_properties]') AND type = 'F')
ALTER TABLE [dbo].[submarket] DROP CONSTRAINT [FK_submarket_properties];

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FK_property_sales_properties]') AND type = 'F')
ALTER TABLE [dbo].[property_sales] DROP CONSTRAINT [FK_property_sales_properties];

-- Drop tables if they exist
IF OBJECT_ID('properties', 'U') IS NOT NULL
DROP TABLE properties;

IF OBJECT_ID('property_sales', 'U') IS NOT NULL
DROP TABLE property_sales;

IF OBJECT_ID('submarket', 'U') IS NOT NULL
DROP TABLE submarket;

-- Create tables
CREATE TABLE properties (
                            PropertyID int NOT NULL PRIMARY KEY,
                            Address varchar(255) NULL,
                            City varchar(100) NULL,
                            State varchar(50) NULL,
                            ZipCode varchar(10) NULL,
                            Bedrooms int NULL,
                            Bathrooms float NULL,
                            SquareFeet int NULL
);

CREATE TABLE property_sales (
                                SaleID int NOT NULL PRIMARY KEY,
                                PropertyID int NULL,
                                SaleDate date NULL,
                                SalePrice decimal(10,2) NULL,
                                CONSTRAINT FK_property_sales_properties FOREIGN KEY (PropertyID) REFERENCES properties (PropertyID)
);

CREATE TABLE submarket (
                           SubmarketID int NOT NULL PRIMARY KEY,
                           SubmarketName varchar(100) NULL,
                           PropertyID int NULL,
                           CONSTRAINT FK_submarket_properties FOREIGN KEY (PropertyID) REFERENCES properties (PropertyID)
);

-- Insert sample data into properties
INSERT INTO properties (PropertyID, Address, City, State, ZipCode, Bedrooms, Bathrooms, SquareFeet)
VALUES
    (1, '123 Main St', 'Cityville', 'CA', '12345', 3, 2.5, 2000),
    (2, '456 Elm St', 'Townsburg', 'NY', '67890', 4, 3.0, 2500),
    (3, '789 Oak St', 'Villagetown', 'TX', '54321', 2, 1.5, 1500),
    (4, '555 Pine Ave', 'Cityville', 'CA', '12345', 4, 2.5, 2200),
    (5, '999 Maple Rd', 'Suburbia', 'IL', '98765', 3, 2.0, 1800),
    (6, '111 Cedar Ln', 'Townsburg', 'NY', '67890', 2, 1.0, 1200),
    (7, '222 Elm St', 'Suburbia', 'IL', '98765', 4, 3.5, 2600),
    (8, '333 Oak Ave', 'Cityville', 'CA', '12345', 3, 2.0, 1800),
    (9, '444 Pine St', 'Villagetown', 'TX', '54321', 5, 4.0, 3200),
    (10, '777 Maple Ave', 'Suburbia', 'IL', '98765', 3, 2.5, 2000);

-- Insert sample data into property_sales
INSERT INTO property_sales (SaleID, PropertyID, SaleDate, SalePrice)
VALUES
    (1, 1, '2023-01-15', 350000.00),
    (2, 2, '2023-02-28', 450000.00),
    (3, 3, '2023-03-10', 250000.00),
    (4, 4, '2023-04-05', 500000.00),
    (5, 5, '2023-05-20', 300000.00),
    (6, 6, '2023-06-08', 200000.00),
    (7, 7, '2023-07-15', 420000.00),
    (8, 8, '2023-08-01', 310000.00),
    (9, 9, '2023-09-18', 600000.00),
    (10, 10, '2023-10-30', 380000.00);

-- Insert sample data into submarket
INSERT INTO submarket (SubmarketID, SubmarketName, PropertyID)
VALUES
    (1, 'Downtown', 1),
    (2, 'Suburbia', 2),
    (3, 'Urban', 3),
    (4, 'City Center', 4),
    (5, 'Residential', 5),
    (6, 'Town Center', 6),
    (7, 'Suburban', 7),
    (8, 'Metropolis', 8),
    (9, 'Village', 9),
    (10, 'Neighborhood', 10);
