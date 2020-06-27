CREATE OR ALTER VIEW Analytics.[Customer Transaction]
AS
SELECT CustomerTransactionKey,
       CustomerKey,
       TransactionNumber AS [Transaction Number],
       TransactionDate AS [Transaction Date],
       TransactionType AS [Transaction Type],
       TotalExcludingTax AS [Total Excluding Tax],
       TaxAmount AS [Tax Amount],
       TotalIncludingTax AS [Total Including Tax],
       ReferenceNumber AS [Reference Number],
       DueByDate AS [Due by Date],
       CompletedDate AS [Completed Date],
       CustomerPurchaseOrderNumber AS [Customer Purchase Order Number]
FROM DataModel.CustomerTransactions;
GO
