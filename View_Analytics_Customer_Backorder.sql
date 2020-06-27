CREATE OR ALTER VIEW Analytics.[Customer Backorder]
AS
SELECT CustomerBackorderKey,
       CustomerKey,
       CustomerOrderKey,
       BackorderDate AS [Backorder Date],
       StockItemKey,
       OrderItemDescription AS [Order Item Description],
       OrderedQuantity AS [Ordered Quantity],
       ReceivedQuantity AS [Received Quantity],
       UnitPrice AS [Unit Price]
FROM DataModel.CustomerBackorders;
GO
