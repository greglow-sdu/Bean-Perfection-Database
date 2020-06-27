DROP TABLE IF EXISTS DataModel.CustomerInvoiceLines;
GO

CREATE TABLE DataModel.CustomerInvoiceLines
(
    CustomerInvoiceLineKey int NOT NULL
        CONSTRAINT PK_DataModel_CustomerInvoiceLines PRIMARY KEY
        CONSTRAINT DF_DataModel_CustomerInvoiceLines_CustomerInvoiceLineKey
            DEFAULT (NEXT VALUE FOR DataModel.CustomerInvoiceLineKey),
    CustomerInvoiceNumber int NOT NULL,
    InvoiceLineNumber int NOT NULL,
    StockItemKey int NOT NULL,
    ItemDescription varchar(50) NOT NULL,
    OrderedQuantity int NOT NULL,
    DeliveredQuantity int NOT NULL,
    BackorderedQuantity int NOT NULL,
    SellingPackageKey int NOT NULL,
    UnitPrice decimal(18, 2) NOT NULL,
    DiscountPercentage decimal(18, 3) NOT NULL,
    DiscountAmount decimal(18, 2) NOT NULL,
    TotalExcludingTax decimal(18, 2) NOT NULL,
    TaxRate decimal(18, 3) NOT NULL,
    TotalIncludingTax decimal(18, 2) NOT NULL
);
GO
