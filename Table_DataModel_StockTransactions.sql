DROP TABLE IF EXISTS DataModel.StockTransactions;
GO

CREATE TABLE DataModel.StockTransactions
(
    StockTransactionKey int NOT NULL
        CONSTRAINT PK_DataModel_StockTransactions PRIMARY KEY
        CONSTRAINT DF_DataModel_StockTransactions_StockTransactionKey
            DEFAULT (NEXT VALUE FOR DataModel.StockTransactionKey),
    TransactionNumber int NULL,
    TransactionDate date NOT NULL,
    StockItemKey int NOT NULL,
    Quantity int NOT NULL,
    UnitPrice decimal(18, 2) NOT NULL,
    CustomerKey int NULL,
    CustomerInvoiceLineKey int NULL,
    SupplierKey int NULL,
    SupplierOrderLineKey int NULL,
    IsStocktakeAdjustment bit NOT NULL
);
GO
