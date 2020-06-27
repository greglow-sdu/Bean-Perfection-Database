DROP TABLE IF EXISTS DataModel.BuyingGroupSpecialPrices;
GO

CREATE TABLE DataModel.BuyingGroupSpecialPrices
(
    BuyingGroupSpecialPriceKey int NOT NULL
        CONSTRAINT PK_DataModel_BuyingGroupSpecialPrices PRIMARY KEY
        CONSTRAINT DF_DataModel_BuyingGroupSpecialPrices_BuyingGroupSpecialPriceKey
            DEFAULT (NEXT VALUE FOR DataModel.BuyingGroupSpecialPriceKey),
    BuyingGroupKey int NOT NULL,
    StockItemKey int NOT NULL,
    DiscountPercentage decimal(18, 3) NOT NULL,
    DiscountAmount decimal(18, 2) NOT NULL,
    EstablishedDate date NOT NULL,
    CostAtTime decimal(18, 2) NOT NULL,
    IsPriceOverride bit NOT NULL,
    PromotionStartDate date NOT NULL,
    PromotionEndDate date NOT NULL
);
GO
