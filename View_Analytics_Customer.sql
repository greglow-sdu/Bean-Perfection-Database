CREATE OR ALTER VIEW Analytics.Customer
AS
SELECT CustomerKey,
       CustomerCode AS [Customer Code],
       Customer,
       PrimaryContact AS [Primary Contact],
       AlternateContact AS [Alternate Contact],
       PrimaryPhoneNumber AS [Primary Phone Number],
       AlternatePhoneNumber AS [Alternate Phone Number],
       FaxNumber AS [Fax Number],
       MobileNumber AS [Mobile Number],
       EmailAddress AS [Email Address],
       StreetAddress1 AS [Street Address 1],
       StreetAddress2 AS [Street Address 2],
       StreetSuburb AS [Street Suburb],
       StreetPostalCode AS [Street Postal Code],
       Country,
       MailingAddress1 AS [Mailing Address 1],
       MailingAddress2 AS [Mailing Address 2],
       MailingSuburb AS [Mailing Suburb],
       MailingPostalCode AS [Mailing Postal Code],
       MailingCountry AS [Mailing Country],
       SalesTerritory AS [Sales Territory],
       BusinessCategoryKey,
       BuyingGroupKey,
       WebsiteURL AS [Website URL],
       CreditLimit AS [Credit Limit],
       BillToCustomerKey,
       AccountOpenedDate AS [Account Opened Date],
       StandardDiscountPercentage AS [Standard Discount Percentage],
       PaymentDaysFromInvoice AS [Payment Days From Invoice],
       IsRecentlyActive AS [Is Recently Active],
       Comments,
       PreferedTransportCompanySupplierKey,
       StreetAddressMapURL AS [Street Address Map URL],
       IsOnCreditHold AS [Is On Credit Hold],
       HasBackordersCreated AS [Has Backorders Created]
FROM DataModel.Customers;
GO