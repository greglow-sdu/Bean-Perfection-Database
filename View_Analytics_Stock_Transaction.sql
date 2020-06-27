CREATE OR ALTER VIEW Analytics.[Stock Transaction]
AS
SELECT StockTransactionKey,
       TransactionNumber AS [Transaction Number],
       TransactionDate AS [Transaction Date],
       StockItemKey,
       Quantity,
       UnitPrice AS [Unit Price],
       CustomerKey,
       CustomerInvoiceLineKey,
       SupplierKey,
       SupplierOrderLineKey,
       IsStocktakeAdjustment AS [Is Stocktake Adjustment]
FROM DataModel.StockTransactions;
GO
