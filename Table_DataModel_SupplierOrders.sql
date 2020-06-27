DROP TABLE IF EXISTS DataModel.SupplierOrders;
GO

CREATE TABLE DataModel.SupplierOrders
(
    SupplierOrderKey int NOT NULL
        CONSTRAINT PK_DataModel_SupplierOrders PRIMARY KEY
        CONSTRAINT DF_DataModel_SupplierOrders_SupplierOrderKey
            DEFAULT (NEXT VALUE FOR DataModel.SupplierOrderKey),
    SupplierOrderID int NOT NULL,
    SupplierKey int NOT NULL,
    OrderDate date NOT NULL,
    PurchaseOrderNumber nvarchar(20) NOT NULL,
    OrderContact nvarchar(35) NOT NULL,
    Comments1 nvarchar(35) NULL,
    Comments2 nvarchar(35) NULL,
    Comments3 nvarchar(35) NULL,
    Comments4 nvarchar(35) NULL,
    ExpectedDeliveryDate date NULL,
    DeliveryInstruction1 nvarchar(35) NULL,
    DeliveryInstruction2 nvarchar(35) NULL,
    DeliveryInstruction3 nvarchar(35) NULL,
    TransportCompanySupplierKey int NULL,
    OrderingStaffMemberKey int NOT NULL,
    IsOrderComplete bit NOT NULL
);
GO
