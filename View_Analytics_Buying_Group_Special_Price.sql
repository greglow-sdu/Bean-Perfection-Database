CREATE OR ALTER VIEW Analytics.[Buying Group Special Price]
AS
SELECT BuyingGroupSpecialPriceKey,
       BuyingGroupKey,
       StockItemKey,
       DiscountPercentage AS [Discount Percentage],
       DiscountAmount AS [Discount Amount],
       EstablishedDate AS [Established Date],
       CostAtTime AS [Cost at Time],
       IsPriceOverride AS [Is Price Override],
       PromotionStartDate AS [Promotion Start Date],
       PromotionEndDate AS [Promotion End Date]
FROM DataModel.BuyingGroupSpecialPrices;
GO
