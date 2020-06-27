DROP TABLE IF EXISTS DataModel.CustomerSpecialPrices;
GO

CREATE TABLE DataModel.CustomerSpecialPrices
(
    CustomerSpecialPriceKey int NOT NULL
        CONSTRAINT PK_DataModel_CustomerSpecialPrices PRIMARY KEY
        CONSTRAINT DF_DataModel_CustomerSpecialPrices_CustomerSpecialPriceKey
            DEFAULT (NEXT VALUE FOR DataModel.CustomerSpecialPriceKey),
    CustomerKey int NOT NULL,
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
