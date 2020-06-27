DROP TABLE IF EXISTS DataModel.Suppliers;
GO

CREATE TABLE DataModel.Suppliers
(
    SupplierKey int NOT NULL
        CONSTRAINT PK_DataModel_Suppliers PRIMARY KEY
        CONSTRAINT DF_DataModel_Suppliers_SupplierKey
            DEFAULT (NEXT VALUE FOR DataModel.SupplierKey),
    SupplierCode nvarchar(8) NOT NULL,
    Supplier nvarchar(35) NOT NULL,
    PrimaryContact nvarchar(35) NULL,
    AlternateContact nvarchar(35) NULL,
    PrimaryPhoneNumber nvarchar(20) NOT NULL,
    AlternatePhoneNumber nvarchar(20) NULL,
    FaxNumber nvarchar(20) NULL,
    MobileNumber nvarchar(20) NULL,
    EmailAddress nvarchar(60) NULL,
    StreetAddress1 nvarchar(35) NOT NULL,
    StreetAddress2 nvarchar(35) NULL,
    StreetSuburb nvarchar(35) NULL,
    StreetPostalCode nvarchar(15) NULL,
    Country nvarchar(50) NULL,
    MailingAddress1 nvarchar(35) NULL,
    MailingAddress2 nvarchar(35) NULL,
    MailingSuburb nvarchar(35) NULL,
    MailingPostalCode nvarchar(15) NULL,
    MailingCountry nvarchar(50) NULL,
    WebsiteURL nvarchar(300) NULL,
    IsATransportCompany bit NOT NULL,
    AccountOpenedDate date NOT NULL,
    SupplierAccountCode varchar(20) NULL,
    IsRecentlyActive bit NOT NULL,
    Comments nvarchar(4000) NULL,
    PreferedTransportCompanySupplierKey int NULL,
    StreetAddressMapURL nvarchar(300) NULL
);
GO
