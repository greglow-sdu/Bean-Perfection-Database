CREATE OR ALTER VIEW Analytics.[Customer Order Line]
AS
SELECT CustomerOrderLineKey,
       CustomerOrderKey,
       OrderLineNumber AS [Order Line Number],
       StockItemKey,
       OrderItemDescription AS [Order Item Description],
       OrderedQuantity AS [Ordered Quantity],
       PickedQuantity AS [Picked Quantity],
       SellingPackage AS [Selling Package],
       UnitPrice AS [UnitPrice],
       DiscountPercentage AS [DiscountPercentage],
       DiscountAmount AS [DiscountAmount],
       TaxRate AS [TaxRate]
FROM DataModel.CustomerOrderLines;
GO
