CREATE OR ALTER VIEW Analytics.[Customer Special Price]
AS
SELECT CustomerSpecialPriceKey,
       CustomerKey,
       StockItemKey,
       DiscountPercentage AS [Discount Percentage],
       DiscountAmount AS [Discount Amount],
       EstablishedDate AS [Established Date],
       CostAtTime AS [Cost at Time],
       IsPriceOverride AS [Is Price Override],
       PromotionStartDate AS [Promotion Start Date],
       PromotionEndDate AS [Promotion End Date]
FROM DataModel.CustomerSpecialPrices;
GO
