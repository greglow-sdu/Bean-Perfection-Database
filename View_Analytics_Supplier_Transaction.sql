CREATE OR ALTER VIEW Analytics.[Supplier Transaction]
AS
SELECT SupplierTransactionKey,
       SupplierKey,
       TransactionNumber AS [Transaction Number],
       TransactionDate AS [Transaction Date],
       TransactionType AS [Transaction Type],
       TotalExcludingTax AS [Total Excluding Tax],
       TaxAmount AS [Tax Amount],
       TotalIncludingTax AS [Total Including Tax],
       ReferenceNumber AS [Reference Number],
       DueByDate AS [Due by Date],
       CompletedDate AS [Completed Date]
FROM DataModel.SupplierTransactions;
GO
