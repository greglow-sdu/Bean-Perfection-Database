DROP TABLE IF EXISTS DataModel.CustomerOrderLines;
GO

CREATE TABLE DataModel.CustomerOrderLines
(
    CustomerOrderLineKey int NOT NULL
        CONSTRAINT PK_DataModel_CustomerOrderLines PRIMARY KEY
        CONSTRAINT DF_DataModel_CustomerOrderLines_CustomerOrderLineKey
            DEFAULT (NEXT VALUE FOR DataModel.CustomerOrderLineKey),
    CustomerOrderKey int NOT NULL,
    OrderLineNumber int NOT NULL,
    StockItemKey int NOT NULL,
    OrderItemDescription nvarchar(50) NOT NULL,
    OrderedQuantity int NOT NULL,
    PickedQuantity int NOT NULL,
    SellingPackage nvarchar(35) NOT NULL,
    UnitPrice decimal(18, 2) NOT NULL,
    DiscountPercentage decimal(18, 3) NOT NULL,
    DiscountAmount decimal(18, 2) NOT NULL,
    TaxRate decimal(18, 3) NOT NULL
);
GO
