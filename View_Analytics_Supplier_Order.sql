CREATE OR ALTER VIEW Analytics.[Supplier Order]
AS
SELECT SupplierOrderKey,
       SupplierOrderID AS [Supplier Order ID],
       SupplierKey,
       OrderDate AS [Order Date],
       PurchaseOrderNumber AS [Purchase Order Number],
       OrderContact AS [Order Contact],
       Comments1 AS [Comments 1],
       Comments2 AS [Comments 2],
       Comments3 AS [Comments 3],
       Comments4 AS [Comments 4],
       ExpectedDeliveryDate AS [Expected Delivery Date],
       DeliveryInstruction1 AS [Delivery Instruction 1],
       DeliveryInstruction2 AS [Delivery Instruction 2],
       DeliveryInstruction3 AS [Delivery Instruction 3],
       TransportCompanySupplierKey,
       OrderingStaffMemberKey,
       IsOrderComplete AS [Is Order Complete]
FROM DataModel.SupplierOrders;
GO
