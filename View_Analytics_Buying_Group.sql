CREATE OR ALTER VIEW Analytics.[Buying Group]
AS
SELECT BuyingGroupKey,
       BuyingGroupCode AS [Buying Group Code],
       BuyingGroup AS [Buying Group]
FROM DataModel.BuyingGroups;
GO
