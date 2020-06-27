DROP TABLE IF EXISTS DataModel.BuyingGroups;
GO

CREATE TABLE DataModel.BuyingGroups
(
    BuyingGroupKey int NOT NULL
        CONSTRAINT PK_DataModel_BuyingGroups PRIMARY KEY
        CONSTRAINT DF_DataModel_BuyingGroups_BuyingGroupKey
            DEFAULT (NEXT VALUE FOR DataModel.BuyingGroupKey),
    BuyingGroupCode nvarchar(8) NOT NULL,
    BuyingGroup nvarchar(35) NOT NULL
);
GO
