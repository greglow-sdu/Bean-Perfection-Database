DROP TABLE IF EXISTS DataModel.CustomerTransactions;
GO

CREATE TABLE DataModel.CustomerTransactions
(
    CustomerTransactionKey int NOT NULL
        CONSTRAINT PK_DataModel_CustomerTransactions PRIMARY KEY
        CONSTRAINT DF_DataModel_CustomerTransactions_CustomerTransactionKey
            DEFAULT (NEXT VALUE FOR DataModel.CustomerTransactionKey),
    CustomerKey int NOT NULL,
    TransactionNumber int NOT NULL,
    TransactionDate date NOT NULL,
    TransactionType nvarchar(20) NOT NULL,
    TotalExcludingTax decimal(18, 2) NOT NULL,
    TaxAmount decimal(18, 2) NOT NULL,
    TotalIncludingTax decimal(18, 2) NOT NULL,
    ReferenceNumber nvarchar(20) NOT NULL,
    DueByDate date NOT NULL,
    CompletedDate date NOT NULL,
    CustomerPurchaseOrderNumber nvarchar(20) NULL
);
GO
