CREATE PROCEDURE [dbo].[CitySelectAll]
AS

SELECT [dbo].[City].[CityID],
    [dbo].[City].[CityName],
    [dbo].[City].[CityCode],
    [dbo].[State].[StateName],
    [dbo].[Country].[CountryName],
    [dbo].[City].[Created],
    [dbo].[City].[Modified]
FROM [dbo].[City]
    INNER JOIN [dbo].[State] ON [dbo].[City].[StateID] = [dbo].[State].[StateID]
    INNER JOIN [dbo].[Country] ON [dbo].[City].[CountryID] = [dbo].[Country].[CountryID]
ORDER BY [dbo].[City].[CityName]

----------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[CitySelectByID]
    @CityID INT
AS

SELECT [dbo].[City].[CityID],
    [dbo].[City].[CityName],
    [dbo].[City].[CityCode],
    [dbo].[City].[StateID],
    [dbo].[City].[CountryID],
    [dbo].[City].[Created],
    [dbo].[City].[Modified]
FROM [dbo].[City]
WHERE [dbo].[City].[CityID] = @CityID

----------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[CityInsert]
    @CityName NVARCHAR(100),
    @CityCode NVARCHAR(10),
    @StateID INT,
    @CountryID INT
AS

INSERT INTO [dbo].[City]
    (CityName, CityCode, StateID, CountryID, Created, Modified)
VALUES
    (@CityName, @CityCode, @StateID, @CountryID, GETDATE(), GETDATE())

----------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[CityUpdate]
    @CityID INT,
    @CityName NVARCHAR(100),
    @CityCode NVARCHAR(10),
    @StateID INT,
    @CountryID INT
AS

UPDATE [dbo].[City]
SET CityName = @CityName,
    CityCode = @CityCode,
    StateID = @StateID,
    CountryID = @CountryID,
    Modified = GETDATE()
WHERE CityID = @CityID

----------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[CityDelete]
    @CityID INT
AS

DELETE FROM [dbo].[City]
WHERE CityID = @CityID

----------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[City_DropDown]
AS
BEGIN
    SELECT
        [dbo].[City].[CityId],
        [dbo].[City].[CityName]
    FROM
        [dbo].[City]
END;
----------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE [dbo].[CityFilter]

    @CityName VARCHAR(100) = NULL,
    @CityCode VARCHAR(100) = NULL,
    @StateID INT = NULL,
    @CountryID INT = NULL

AS
BEGIN
    SELECT
        CityID,
        CityName,
        CityCode,
        State.StateName,
        Country.CountryName,
        [State].Created,
        [State].Modified

    FROM
        City

    INNER JOIN 
        State ON [City].StateID = State.StateID

    INNER JOIN 
        Country ON [City].CountryID = Country.CountryID

    WHERE 
        (@StateID IS NULL OR City.StateID = @StateID)
        AND (@CountryID IS NULL OR City.CountryID = @CountryID)
        AND (@CityName IS NULL OR CityName LIKE '%' + @CityName + '%')
        AND (@CityCode IS NULL OR CityCode LIKE '%' + @CityCode + '%')
END;
