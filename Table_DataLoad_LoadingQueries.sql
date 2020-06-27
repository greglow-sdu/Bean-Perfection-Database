DROP TABLE IF EXISTS DataLoad.LoadingQueries;
GO

CREATE TABLE DataLoad.LoadingQueries
(
    LoadingQueryID int NOT NULL
        CONSTRAINT PK_DataLoad_LoadingQueries PRIMARY KEY
        CONSTRAINT DF_DataLoad_LoadingQueries_LoadingQueryID
            DEFAULT (NEXT VALUE FOR DataLoad.LoadingQueryID),
    LoadingOrder int NOT NULL,
    SchemaName sysname NOT NULL,
    TableName sysname NOT NULL,
    SQLQuery nvarchar(max) NOT NULL,
    CONSTRAINT UQ_DataLoad_LoadingQueries_UniqueQuery
        UNIQUE (SchemaName, TableName)
);
GO