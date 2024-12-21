CREATE PROCEDURE [dbo].[StateSelectAll]
AS

SELECT [dbo].[State].[StateID],
    [dbo].[State].[StateName],
    [dbo].[State].[StateCode],
    [dbo].[Country].[CountryName],
    [dbo].[State].[Created],
    [dbo].[State].[Modified]
FROM [dbo].[State]
    INNER JOIN [dbo].[Country] ON [dbo].[State].[CountryID] = [dbo].[Country].[CountryID]
ORDER BY [dbo].[State].[StateName]

----------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[StateSelectByID]
    @StateID INT
AS

SELECT [dbo].[State].[StateID],
    [dbo].[State].[StateName],
    [dbo].[State].[StateCode],
    [dbo].[State].[CountryID],
    [dbo].[State].[Created],
    [dbo].[State].[Modified]
FROM [dbo].[State]
WHERE [dbo].[State].[StateID] = @StateID

----------------------------------------------------------------------------

CREATE or alter PROCEDURE [dbo].[StateInsert]
    @StateName NVARCHAR(100),
    @StateCode NVARCHAR(10),
    @CountryID INT
AS

INSERT INTO [dbo].[State]
    (StateName, StateCode, CountryID, Created, Modified)
VALUES
    (@StateName, @StateCode, @CountryID, GETDATE(), GETDATE())

----------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[StateUpdate]
    @StateID INT,
    @StateName NVARCHAR(100),
    @StateCode NVARCHAR(10),
    @CountryID INT
AS

UPDATE [dbo].[State]
SET StateName = @StateName,
    StateCode = @StateCode,
    CountryID = @CountryID,
    Modified = GETDATE()
WHERE StateID = @StateID

----------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[StateDelete]
    @StateID INT
AS

DELETE FROM [dbo].[State]
WHERE StateID = @StateID

----------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[State_DropDown]
AS
BEGIN
    SELECT
        [dbo].[State].[StateID],
        [dbo].[State].[StateName]
    FROM
        [dbo].[State]
END

----------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE StateFilter
    @CountryID INT= NULL,
    @StateName VARCHAR(100) = NULL,
    @StateCode VARCHAR(10) = NULL
AS
BEGIN
    SELECT
        StateID,
        StateName,
        StateCode,
        Country.CountryName,
        [State].Created,
        [State].Modified
    FROM
        State
        
    INNER JOIN 
        Country ON [State].CountryID = Country.CountryID
    WHERE 
        (@CountryID IS NULL OR State.CountryID = @CountryID)
        AND (@StateName IS NULL OR StateName LIKE '%' + @StateName + '%')
        AND (@StateCode IS NULL OR StateCode LIKE '%' + @StateCode + '%')
END