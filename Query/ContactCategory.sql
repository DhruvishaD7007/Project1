CREATE PROCEDURE [dbo].[ContactCategorySelectAll]
AS

SELECT [dbo].[ContactCategory].[ContactCategoryID],
    [dbo].[ContactCategory].[ContactCategoryName]
FROM [dbo].[ContactCategory]
ORDER BY [dbo].[ContactCategory].[ContactCategoryName]

----------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[ContactCategorySelectByID]
    @ContactCategoryID INT
AS

SELECT [dbo].[ContactCategory].[ContactCategoryID],
    [dbo].[ContactCategory].[ContactCategoryName]
FROM [dbo].[ContactCategory]
WHERE [dbo].[ContactCategory].[ContactCategoryID] = @ContactCategoryID

----------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[ContactCategoryInsert]
    @ContactCategoryName NVARCHAR(100)
AS

INSERT INTO [dbo].[ContactCategory]
    (ContactCategoryName)
VALUES
    (@ContactCategoryName)

----------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[ContactCategoryUpdate]
    @ContactCategoryID INT,
    @ContactCategoryName NVARCHAR(100)
AS

UPDATE [dbo].[ContactCategory]
SET ContactCategoryName = @ContactCategoryName
WHERE ContactCategoryID = @ContactCategoryID

----------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[ContactCategoryDelete]
    @ContactCategoryID INT
AS

DELETE FROM [dbo].[ContactCategory]
WHERE ContactCategoryID = @ContactCategoryID

----------------------------------------------------------------------------

CREATE or ALTER PROCEDURE [dbo].[ContactCategory_DropDown]
AS
BEGIN
    SELECT
        [dbo].[ContactCategory].[ContactCategoryID],
        [dbo].[ContactCategory].[ContactCategoryName]
    FROM
        [dbo].[ContactCategory]
END

----------------------------------------------------------------------------

CREATE or alter PROCEDURE [dbo].[ContactCategoryFilter]

    @ContactCategoryName VARCHAR(100) = NULL
As
SELECT [dbo].[ContactCategory].[ContactCategoryID],
    [dbo].[ContactCategory].[ContactCategoryName]
FROM 
    [dbo].[ContactCategory]
Where 
    (@ContactCategoryName IS NULL OR [ContactCategoryName] LIKE CONCAT ('%',@ContactCategoryName,'%'))
ORDER BY [dbo].[ContactCategory].[ContactCategoryName]
