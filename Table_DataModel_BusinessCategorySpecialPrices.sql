DROP TABLE IF EXISTS DataModel.BusinessCategorySpecialPrices;
GO

CREATE TABLE DataModel.BusinessCategorySpecialPrices
(
    BusinessCategorySpecialPriceKey int NOT NULL
        CONSTRAINT PK_DataModel_BusinessCategorySpecialPrices PRIMARY KEY
        CONSTRAINT DF_DataModel_BusinessCategorySpecialPrices_BusinessCategorySpecialPriceKey
            DEFAULT (NEXT VALUE FOR DataModel.BusinessCategorySpecialPriceKey),
    BusinessCategoryKey int NOT NULL,
    StockKey int NOT NULL,
    DiscountPercentage decimal(18, 3) NOT NULL,
    DiscountAmount decimal(18, 2) NOT NULL,
    EstablishedDate date NOT NULL,
    CostAtTime decimal(18, 2) NOT NULL,
    IsPriceOverride bit NOT NULL,
    PromotionStartDate date NOT NULL,
    PromotionEndDate date NOT NULL
);
GO
