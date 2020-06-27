CREATE OR ALTER VIEW Analytics.[Business Category]
AS
SELECT BusinessCategoryKey,
       BusinessCategoryCode AS [Business Category Code],
       BusinessCategory AS [Business Category]
FROM DataModel.BusinessCategories;
GO
