DROP TABLE IF EXISTS DataModel.StockItems;
GO

CREATE TABLE DataModel.StockItems
(
    StockItemKey int NOT NULL
        CONSTRAINT PK_DataModel_StockItems PRIMARY KEY
        CONSTRAINT DF_DataModel_StockItems_StockItemKey
            DEFAULT (NEXT VALUE FOR DataModel.StockItemKey),
    StockCode nvarchar(8) NOT NULL,
    StockItemDescription nvarchar(50) NOT NULL,
    Size nvarchar(20) NULL,
    SellingPackage nvarchar(35) NOT NULL,
    WeightPerUnit decimal(18, 3) NOT NULL,
    StockCategoryKey int NOT NULL,
    BarCode nvarchar(20) NULL,
    TaxRate decimal(18, 3) NOT NULL,
    IsStocktakeItem bit NOT NULL,
    UnitPrice decimal(18, 2) NOT NULL,
    OuterPrice decimal(18, 2) NOT NULL,
    WholesalePrice decimal(18, 2) NOT NULL,
    AgentPrice decimal(18, 2) NOT NULL,
    RecommendedRetailPrice decimal(18, 2) NOT NULL,
    PromotionalPrice decimal(18, 2) NULL,
    PromotionStartDate date NULL,
    PromotionEndDate date NULL,
    QuantityPerShipper int NOT NULL,
    QuantityPerCarton int NOT NULL,
    QuantityPerPallet int NOT NULL,
    IsShownOnPriceList bit NOT NULL,
    AddedDate date NOT NULL,
    LastPriceChangeDateTime datetime NOT NULL,
    Brand nvarchar(15) NOT NULL,
    OrderingPackage nvarchar(35) NOT NULL,
    QuantityOnHand int NOT NULL,
    QuantityAtLastStocktake int NULL,
    ReorderLevel int NOT NULL,
    TypicalLeadTimeDays int NOT NULL,
    IsRecentlyActive bit NOT NULL,
    LatestCostPrice decimal(18, 2) NULL,
    Comments nvarchar(4000) NULL,
    PrimarySupplierKey int NULL,
    AlternateSupplierKey int NULL,
    PrimarySupplierStockCode nvarchar(20) NULL,
    AlternateSupplierStockCode nvarchar(20) NULL
);
GO
