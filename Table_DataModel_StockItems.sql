DROP TABLE IF EXISTS DataModel.StockItems;
GO

CREATE TABLE DataModel.StockItems
(
    StockItemKey int NOT NULL
        CONSTRAINT PK_DataModel_StockItems PRIMARY KEY
        CONSTRAINT DF_DataModel_StockItems_StockItemKey
            DEFAULT (NEXT VALUE FOR DataModel.StockItemKey),
    StockCode varchar(8) NOT NULL,
    StockItemDescription varchar(50) NOT NULL,
    Size varchar(20) NULL,
    SellingPackage varchar(35) NOT NULL,
    WeightPerUnit decimal(18, 3) NOT NULL,
    StockCategoryKey int NOT NULL,
    BarCode varchar(20) NULL,
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
    Brand varchar(15) NOT NULL,
    OrderingPackageKey int NOT NULL,
    QuantityOnHand int NOT NULL,
    QuantityAtLastStocktake int NULL,
    ReorderLevel int NOT NULL,
    TypicalLeadTimeDays int NOT NULL,
    IsRecentlyActive bit NOT NULL,
    LatestCostPrice decimal(18, 2) NULL,
    Comments varchar(4000) NULL,
    PrimarySupplierKey int NULL,
    AlternateSupplierKey int NULL,
    PrimarySupplierStockCode varchar(20) NULL,
    AlternateSupplierStockCode varchar(20) NULL
);
GO
