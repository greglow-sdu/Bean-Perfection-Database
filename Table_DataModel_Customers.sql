DROP TABLE IF EXISTS DataModel.Customers;
GO

CREATE TABLE DataModel.Customers
(
    CustomerKey int NOT NULL
        CONSTRAINT PK_DataModel_Customers PRIMARY KEY
        CONSTRAINT DF_DataModel_Customers_CustomerKey
            DEFAULT (NEXT VALUE FOR DataModel.CustomerKey),
    CustomerCode nvarchar(8) NOT NULL,
    CustomerName nvarchar(35) NOT NULL,
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
    SalesTerritory nvarchar(35) NOT NULL,
    BusinessCategoryKey int NOT NULL,
    BuyingGroupKey int NOT NULL,
    WebsiteURL nvarchar(300) NULL,
    CreditLimit decimal(18, 2) NULL,
    BillToCustomerKey int NOT NULL,
    AccountOpenedDate date NOT NULL,
    StandardDiscountPercentage decimal(18, 3) NOT NULL,
    PaymentDaysFromInvoiceDate int NOT NULL,
    IsRecentlyActive bit NOT NULL,
    Comments nvarchar(4000) NULL,
    PreferedTransportCompanySupplierKey int NULL,
    StreetAddressMapURL nvarchar(300) NULL,
    IsOnCreditHold bit NOT NULL,
    HasBackordersCreated bit NOT NULL
);
GO
