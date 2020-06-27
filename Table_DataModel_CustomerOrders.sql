DROP TABLE IF EXISTS DataModel.CustomerOrders;
GO

CREATE TABLE DataModel.CustomerOrders
(
    CustomerOrderKey int NOT NULL
        CONSTRAINT PK_DataModel_CustomerOrders PRIMARY KEY
        CONSTRAINT DF_DataModel_CustomerOrders_CustomerOrderKey
            DEFAULT (NEXT VALUE FOR DataModel.CustomerOrderKey),
    CustomerOrderID int NOT NULL,
    CustomerKey int NOT NULL,
    OrderDate date NOT NULL,
    CustomerPurchaseOrderNumber nvarchar(20) NULL,
    Comments1 nvarchar(35) NULL,
    Comments2 nvarchar(35) NULL,
    Comments3 nvarchar(35) NULL,
    Comments4 nvarchar(35) NULL,
    ExpectedDeliveryDate date NULL,
    DeliveryInstruction1 nvarchar(35) NULL,
    DeliveryInstruction2 nvarchar(35) NULL,
    DeliveryInstruction3 nvarchar(35) NULL,
    DeliveryRunCode nvarchar(8) NULL,
    DeliveryRunPosition int NULL,
    TransportCompanySupplierKey int NOT NULL,
    HasBeenPicked bit NOT NULL,
    OrderingStaffMemberKey int NOT NULL,
    PickingStaffMemberKey int NULL
);
GO
