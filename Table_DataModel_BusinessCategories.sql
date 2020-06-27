DROP TABLE IF EXISTS DataModel.BusinessCategories;
GO

CREATE TABLE DataModel.BusinessCategories
(
    BusinessCategoryKey int NOT NULL
        CONSTRAINT PK_DataModel_BusinessCategories PRIMARY KEY
        CONSTRAINT DF_DataModel_BusinessCategories_BusinessCategoryKey
            DEFAULT (NEXT VALUE FOR DataModel.BusinessCategoryKey),
    BusinessCategoryCode nvarchar(8) NOT NULL,
    BusinessCategory nvarchar(35) NOT NULL
);
GO
