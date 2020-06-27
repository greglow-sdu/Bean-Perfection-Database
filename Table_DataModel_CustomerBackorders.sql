DROP TABLE IF EXISTS DataModel.CustomerBackorders;
GO

CREATE TABLE DataModel.CustomerBackorders
(
    CustomerBackorderKey int NOT NULL
        CONSTRAINT PK_DataModel_CustomerBackorders PRIMARY KEY
        CONSTRAINT DF_DataModel_CustomerBackorders_CustomerBackorderKey
            DEFAULT (NEXT VALUE FOR DataModel.CustomerBackorderKey),
    CustomerKey int NOT NULL,
    CustomerOrderKey int NOT NULL,
    BackorderDate date NOT NULL,
    StockItemKey int NOT NULL,
    OrderItemDescription nvarchar(50) NOT NULL,
    OrderedQuantity int NOT NULL,
    ReceivedQuantity int NOT NULL,
    UnitPrice decimal(18, 2) NOT NULL
);
GO
