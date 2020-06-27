CREATE OR ALTER VIEW Analytics.[Supplier Order Line]
AS
SELECT SupplierOrderLineKey,
       SupplierOrderKey,
       OrderLineNumber AS [Order Line Number],
       StockItemKey,
       SupplierStockCode AS [Supplier Stock Code],
       OrderItemDescription AS [Order Item Description],
       OrderedQuantity AS [Ordered Quantity],
       ReceivedQuantity AS [Received Quantity],
       SellingPackage AS [Selling Package],
       UnitPrice AS [Unit Price],
       DiscountPercentage AS [Discount Percentage],
       DiscountAmount AS [Discount Amount],
       TaxRate AS [Tax Rate]
FROM DataModel.SupplierOrderLines;
GO
