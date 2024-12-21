CREATE PROCEDURE [dbo].[CountrySelectAll]
AS

SELECT [dbo].[Country].[CountryID],
    [dbo].[Country].[CountryName],
    [dbo].[Country].[CountryCode],
    [dbo].[Country].[Created],
    [dbo].[Country].[Modified]
FROM [dbo].[Country]
ORDER BY [dbo].[Country].[CountryName]

----------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[CountrySelectByID]
    @CountryID INT
AS

SELECT [dbo].[Country].[CountryID],
    [dbo].[Country].[CountryName],
    [dbo].[Country].[CountryCode],
    [dbo].[Country].[Created],
    [dbo].[Country].[Modified]
FROM [dbo].[Country]
WHERE [dbo].[Country].[CountryID] = @CountryID

----------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[CountryInsert]
    @CountryName NVARCHAR(100),
    @CountryCode NVARCHAR(10)
AS

INSERT INTO [dbo].[Country]
    (CountryName, CountryCode, Created, Modified)
VALUES
    (@CountryName, @CountryCode, GETDATE(), GETDATE())

----------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[CountryUpdate]
    @CountryID INT,
    @CountryName NVARCHAR(100),
    @CountryCode NVARCHAR(10)
AS

UPDATE [dbo].[Country]
SET CountryName = @CountryName,
    CountryCode = @CountryCode,
    Modified = GETDATE()
WHERE CountryID = @CountryID

----------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[CountryDelete]
    @CountryID INT
AS

DELETE FROM [dbo].[Country]
WHERE CountryID = @CountryID

----------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[Country_DropDown]
AS
BEGIN
    SELECT
        [dbo].[Country].[CountryID],
        [dbo].[Country].[CountryName]
    FROM
        [dbo].[Country]
END

----------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE [dbo].[CountryFilter]

    @CountryName VARCHAR(100) = NULL,
    @CountryCode VARCHAR(100) = NULL

As
SELECT [dbo].[Country].[CountryID],
    [dbo].[Country].[CountryName],
    [dbo].[Country].[CountryCode],
    [dbo].[Country].[Created],
    [dbo].[Country].[Modified]
FROM 
    [dbo].[Country]

Where 
    (@CountryName IS NULL OR [CountryName] LIKE CONCAT ('%',@CountryName,'%')) AND
    (@CountryCode IS NULL OR [CountryCode] LIKE CONCAT('%',@CountryCode,'%'))

ORDER BY [dbo].[Country].[CountryName]