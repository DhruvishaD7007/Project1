CREATE PROCEDURE [dbo].[ContactSelectAll]
AS

SELECT [dbo].[Contact].[ContactID],
    [dbo].[ContactCategory].[ContactCategoryName],
    [dbo].[City].[CityName],
    [dbo].[State].[StateName],
    [dbo].[Country].[CountryName],
    [dbo].[Contact].[ContactName],
    [dbo].[Contact].[Address],
    [dbo].[Contact].[Mobile],
    [dbo].[Contact].[Email],
    [dbo].[Contact].[BirthDate],
    [dbo].[Contact].[Created],
    [dbo].[Contact].[Modified]
FROM [dbo].[Contact]
    INNER JOIN [dbo].[ContactCategory] ON [dbo].[Contact].[ContactCategoryID] = [dbo].[ContactCategory].[ContactCategoryID]
    INNER JOIN [dbo].[City] ON [dbo].[Contact].[CityID] = [dbo].[City].[CityID]
    INNER JOIN [dbo].[State] ON [dbo].[Contact].[StateID] = [dbo].[State].[StateID]
    INNER JOIN [dbo].[Country] ON [dbo].[Contact].[CountryID] = [dbo].[Country].[CountryID]
ORDER BY [dbo].[Contact].[ContactName]

----------------------------------------------------------------------------

CREATE or alter PROCEDURE [dbo].[ContactSelectByID]
    @ContactID INT
AS

SELECT [dbo].[Contact].[ContactID],
    [dbo].[Contact].[ContactCategoryID],
    [dbo].[Contact].[CityID],
    [dbo].[Contact].[StateID],
    [dbo].[Contact].[CountryID],
    [dbo].[Contact].[ContactName],
    [dbo].[Contact].[Address],
    [dbo].[Contact].[Mobile],
    [dbo].[Contact].[Email],
    [dbo].[Contact].[BirthDate],
    [dbo].[Contact].[Created],
    [dbo].[Contact].[Modified]
FROM [dbo].[Contact]
WHERE [dbo].[Contact].[ContactID] = @ContactID

----------------------------------------------------------------------------

CREATE or alter PROCEDURE [dbo].[ContactInsert]
    @ContactCategoryID INT,
    @CityID INT,
    @StateID INT,
    @CountryID INT,
    @ContactName NVARCHAR(100),
    @Address NVARCHAR(200),
    @Mobile NVARCHAR(15),
    @Email NVARCHAR(100),
    @BirthDate DATE
AS

INSERT INTO [dbo].[Contact]
    (ContactCategoryID, CityID, StateID, CountryID, ContactName, Address, Mobile, Email, BirthDate, Created, Modified)
VALUES
    (@ContactCategoryID, @CityID, @StateID, @CountryID, @ContactName, @Address, @Mobile, @Email, @BirthDate, GETDATE(), GETDATE())

----------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[ContactUpdate]
    @ContactID INT,
    @ContactCategoryID INT,
    @CityID INT,
    @StateID INT,
    @CountryID INT,
    @ContactName NVARCHAR(100),
    @Address NVARCHAR(200),
    @Mobile NVARCHAR(15),
    @Email NVARCHAR(100),
    @BirthDate DATE
AS

UPDATE [dbo].[Contact]
SET ContactCategoryID = @ContactCategoryID,
    CityID = @CityID,
    StateID = @StateID,
    CountryID = @CountryID,
    ContactName = @ContactName,
    Address = @Address,
    Mobile = @Mobile,
    Email = @Email,
    BirthDate = @BirthDate,
    Modified = GETDATE()
WHERE ContactID = @ContactID

----------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[ContactDelete]
    @ContactID INT
AS

DELETE FROM [dbo].[Contact]
WHERE ContactID = @ContactID

----------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[Contact_DropDown]
AS
BEGIN
    SELECT
        [dbo].[Contact].[ContactID],
        [dbo].[Contact].[ContactName]
    FROM
        [dbo].[Contact]
END

----------------------------------------------------------------------------

CREATE OR ALTER PROCEDURE ContactFilter
    @ContactCategoryID INT = NULL,
    @CityID INT = NULL,
    @StateID INT = NULL,
    @CountryID INT = NULL,
    @ContactName VARCHAR(100) = NULL,
    @Address VARCHAR(100) = NULL,
    @Mobile VARCHAR(10) = NULL,
    @Email VARCHAR(100) = NULL,
    @BirthDate VARCHAR(10) = NULL
AS
BEGIN
    SELECT
        ContactID,
        ContactCategory.ContactCategoryName,
        City.CityName,
        State.StateName,
        Country.CountryName,
        ContactName,
        Address,
        Mobile,
        Email,
        BirthDate,
        [Contact].Created,
        [Contact].Modified
    FROM
        Contact
    INNER JOIN 
        ContactCategory ON [Contact].ContactCategoryID = ContactCategory.ContactCategoryID
    INNER JOIN 
        City ON [Contact].CityID = City.CityID
    INNER JOIN 
        State ON [Contact].StateID = State.StateID
    INNER JOIN 
        Country ON [Contact].CountryID = Country.CountryID
    WHERE 
        (@ContactCategoryID IS NULL OR Contact.ContactCategoryID = @ContactCategoryID)
        AND (@CityID IS NULL OR Contact.CityID = @CityID)
        AND (@StateID IS NULL OR Contact.StateID = @StateID)
        AND (@CountryID IS NULL OR Contact.CountryID = @CountryID)
        AND (@ContactName IS NULL OR ContactName LIKE '%' + @ContactName + '%')
        AND (@Address IS NULL OR Address LIKE '%' + @Address + '%')
        AND (@Mobile IS NULL OR Mobile LIKE '%' + @Mobile + '%')
        AND (@Email IS NULL OR Email LIKE '%' + @Email + '%')
        AND (@BirthDate IS NULL OR BirthDate LIKE '%' + @BirthDate + '%');
END;

