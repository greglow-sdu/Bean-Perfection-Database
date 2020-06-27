DROP TABLE IF EXISTS DataModel.SupplierTransactions;
GO

CREATE TABLE DataModel.SupplierTransactions
(
    SupplierTransactionKey int NOT NULL
        CONSTRAINT PK_DataModel_SupplierTransactions PRIMARY KEY
        CONSTRAINT DF_DataModel_SupplierTransactions_SupplierTransactionKey
            DEFAULT (NEXT VALUE FOR DataModel.SupplierTransactionKey),
    SupplierKey int NOT NULL,
    TransactionNumber int NOT NULL,
    TransactionDate date NOT NULL,
    TransactionType nvarchar(20) NOT NULL,
    TotalExcludingTax decimal(18, 2) NOT NULL,
    TaxAmount decimal(18, 2) NOT NULL,
    TotalIncludingTax decimal(18, 2) NOT NULL,
    ReferenceNumber nvarchar(20) NOT NULL,
    DueByDate date NOT NULL,
    CompletedDate date NOT NULL
);
GO
