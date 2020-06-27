CREATE OR ALTER VIEW Analytics.[Customer Invoice]
AS
SELECT CustomerInvoiceKey,
       CustomerOrderID AS [Customer Order ID],
       CustomerInvoiceID AS [Customer Invoice ID],
       CustomerKey,
       InvoiceDate AS [Invoice Date],
       CustomerPurchaseOrderNumber AS [Customer Purchase Order Number],
       Comments1 AS [Comments 1],
       Comments2 AS [Comments 2],
       Comments3 AS [Comments 3],
       Comments4 AS [Comments 4],
       ExpectedDeliveryDate AS [Expected Delivery Date],
       DeliveryInstruction1 AS [Delivery Instruction 1],
       DeliveryInstruction2 AS [Delivery Instruction 2],
       DeliveryInstruction3 AS [Delivery Instruction 3],
       DeliveryRunCode AS [Delivery Run Code],
       DeliveryRunPosition AS [Delivery Run Position],
       TransportCompanySupplierKey,
       OrderingStaffMemberKey,
       PickingStaffMemberKey
FROM DataModel.CustomerInvoices;
GO
