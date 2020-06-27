DROP TABLE IF EXISTS DataLoad.StagingIndexes;
GO

CREATE TABLE DataLoad.StagingIndexes
(
    StagingIndexID int NOT NULL
        CONSTRAINT PK_DataLoad_StagingIndexes PRIMARY KEY
        CONSTRAINT DF_DataLoad_StagingIndexes_StagingIndexID
            DEFAULT (NEXT VALUE FOR DataLoad.StagingIndexID),
    StagingTableName sysname NOT NULL,
    IndexName sysname NOT NULL,
    KeyColumns nvarchar(max) NOT NULL,
    IncludedColumns nvarchar(max) NULL
);
GO


