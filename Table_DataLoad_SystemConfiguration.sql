DROP TABLE IF EXISTS DataLoad.SystemConfiguration;
GO

CREATE TABLE DataLoad.SystemConfiguration
(
    SystemConfigurationID int NOT NULL
        CONSTRAINT PK_DataLoad_SystemConfiguration PRIMARY KEY,
    AquSellSQLServerName sysname NOT NULL,
    AquSellSQLDatabaseName sysname NOT NULL
);
GO

INSERT DataLoad.SystemConfiguration
(
    SystemConfigurationID, AquSellSQLServerName, AquSellSQLDatabaseName
)
VALUES (1, N'sduclassroom.database.windows.net', N'aqusell');
GO