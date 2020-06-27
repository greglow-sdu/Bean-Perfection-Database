DROP TABLE IF EXISTS DataModel.CustomerInvoices;
GO

CREATE TABLE DataModel.CustomerInvoices
(
    CustomerInvoiceKey int NOT NULL
        CONSTRAINT PK_DataModel_CustomerInvoices PRIMARY KEY
        CONSTRAINT DF_DataModel_CustomerInvoices_CustomerInvoiceKey
            DEFAULT (NEXT VALUE FOR DataModel.CustomerInvoiceKey),
    CustomerOrderID int NOT NULL,
    CustomerInvoiceID int NOT NULL,
    CustomerKey int NOT NULL,
    InvoiceDate date NOT NULL,
    CustomerPurchaseOrderNumber varchar(20) NULL,
    Comments1 varchar(35) NULL,
    Comments2 varchar(35) NULL,
    Comments3 varchar(35) NULL,
    Comments4 varchar(35) NULL,
    ExpectedDeliveryDate date NULL,
    DeliveryInstruction1 varchar(35) NULL,
    DeliveryInstruction2 varchar(35) NULL,
    DeliveryInstruction3 varchar(35) NULL,
    DeliveryRunCode varchar(8) NULL,
    DeliveryRunPosition int NULL,
    TransportCompanySupplierKey int NULL,
    OrderingStaffMemberKey int NOT NULL,
    PickingStaffMemberKey int NOT NULL
);
GO
