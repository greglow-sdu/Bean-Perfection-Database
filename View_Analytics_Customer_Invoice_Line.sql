CREATE OR ALTER VIEW Analytics.[Customer Invoice Line]
AS
SELECT CustomerInvoiceLineKey,
       CustomerInvoiceNumber AS [Customer Invoice Number],
       InvoiceLineNumber AS [Invoice Line Number],
       StockItemKey,
       ItemDescription AS [Item Description],
       OrderedQuantity AS [Ordered Quantity],
       DeliveredQuantity AS [Delivered Quantity],
       BackorderedQuantity AS [Backordered Quantity],
       SellingPackage AS [Selling Package],
       UnitPrice AS [Unit Price],
       DiscountPercentage AS [Discount Percentage],
       DiscountAmount AS [Discount Amount],
       TotalExcludingTax AS [Total Excluding Tax],
       TaxRate AS [Tax Rate],
       TotalIncludingTax AS [Total Including Tax]
FROM DataModel.CustomerInvoiceLines;
GO
