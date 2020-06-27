DROP TABLE IF EXISTS DataModel.SupplierOrderLines;
GO

CREATE TABLE DataModel.SupplierOrderLines
(
    SupplierOrderLineKey int NOT NULL
        CONSTRAINT PK_DataModel_SupplierOrderLines PRIMARY KEY
        CONSTRAINT DF_DataModel_SupplierOrderLines_SupplierOrderLineKey
            DEFAULT (NEXT VALUE FOR DataModel.SupplierOrderLineKey),
    SupplierOrderKey int NOT NULL,
    OrderLineNumber int NOT NULL,
    StockItemKey int NOT NULL,
    SupplierStockCode nvarchar(20) NOT NULL,
    OrderItemDescription nvarchar(50) NOT NULL,
    OrderedQuantity int NOT NULL,
    ReceivedQuantity int NOT NULL,
    SellingPackage nvarchar(35) NOT NULL,
    UnitPrice decimal(18, 2) NOT NULL,
    DiscountPercentage decimal(18, 3) NOT NULL,
    DiscountAmount decimal(18, 2) NOT NULL,
    TaxRate decimal(18, 3) NOT NULL
);
GO
