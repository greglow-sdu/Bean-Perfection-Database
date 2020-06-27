CREATE OR ALTER VIEW Analytics.[Customer Order]
AS
SELECT CustomerOrderKey,
       CustomerOrderID AS [Customer Order ID],
       CustomerKey,
       OrderDate AS [Order Date],
       CustomerPurchaseOrderNumber AS [Customer Purchase Order Number],
       Comments1 AS [Comments 1],
       Comments2 AS [Comments 2],
       Comments3 AS [Comments 3],
       Comments4 AS [Comments 4],
       ExpectedDeliveryDate AS [Expected Delivery Date],
       DeliveryInstruction1 AS [Delivery Instruction1],
       DeliveryInstruction2 AS [Delivery Instruction2],
       DeliveryInstruction3 AS [Delivery Instruction3],
       DeliveryRunCode AS [Delivery Run Code],
       DeliveryRunPosition AS [Delivery Run Position],
       TransportCompanySupplierKey,
       HasBeenPicked AS [Has Been Picked],
       OrderingStaffMemberKey,
       PickingStaffMemberKey
FROM DataModel.CustomerOrders;
GO
