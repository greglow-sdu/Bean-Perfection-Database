CREATE OR ALTER PROCEDURE DataLoad.RefreshExternalAndStagingObjects
AS
BEGIN
    SET XACT_ABORT ON;
    SET NOCOUNT ON;

    DECLARE @SOURCE_DB_SCHEMA_NAME sysname = N'AquSell';

    DECLARE @ProcedureName sysname = OBJECT_NAME(@@PROCID);
    EXEC DataLoad.WriteLogEntry @ProcedureName, 'Starting';

    DECLARE @SQL nvarchar(max);
    DECLARE @StagingProcedure nvarchar(max);

    DECLARE @SourceServerName sysname;
    DECLARE @SourceDatabaseName sysname;

    SELECT @SourceServerName = sc.AquSellSQLServerName,
           @SourceDatabaseName = sc.AquSellSQLDatabaseName
    FROM DataLoad.SystemConfiguration AS sc 
    WHERE sc.SystemConfigurationID = 1;

    DECLARE @CRLF nchar(2) = NCHAR(13) + NCHAR(10);

    DECLARE @ExternalTables TABLE
    (
        ExternalTableID int IDENTITY(1,1) PRIMARY KEY,
        SourceSchemaName sysname NOT NULL,
        SourceTableName sysname NOT NULL,
        ExternalTableName sysname NOT NULL,
        PrimaryKeyColumns nvarchar(1000) NOT NULL,
        SourceColumnList nvarchar(max)
    );

    DECLARE @DataModelTables TABLE
    (
        DataModelTableID int IDENTITY(1,1) PRIMARY KEY,
        DataModelTableName sysname NOT NULL
    );

    DECLARE @StagingIndexes TABLE
    (
        StagingIndexID int IDENTITY(1,1) PRIMARY KEY,
        StagingTableName sysname NOT NULL,
        IndexName sysname NOT NULL,
        KeyColumns nvarchar(max) NOT NULL,
        IncludedColumns nvarchar(max) NULL
    );

    INSERT @ExternalTables 
    (
        SourceSchemaName, SourceTableName, ExternalTableName, 
        PrimaryKeyColumns, SourceColumnList
    )
    SELECT SourceSchemaName, SourceTableName, ExternalTableName, 
           PrimaryKeyColumns, SourceColumnList
    FROM DataLoad.ExternalTables;

    INSERT @DataModelTables 
    (
        DataModelTableName
    )
    SELECT TableName
    FROM DataLoad.LoadingQueries
    WHERE SchemaName = N'DataModel'
    ORDER BY LoadingOrder;

    INSERT @StagingIndexes 
    (
        StagingTableName, IndexName, KeyColumns, IncludedColumns
    )
    SELECT StagingTableName, IndexName, KeyColumns, IncludedColumns
    FROM DataLoad.StagingIndexes
    ORDER BY StagingTableName, IndexName;

    DECLARE @SourceSchemaName sysname;
    DECLARE @SourceTableName sysname;
    DECLARE @ExternalTableName sysname;
    DECLARE @PrimaryKeyColumns nvarchar(1000);
    DECLARE @SourceColumnList nvarchar(max);
    DECLARE @CorrectedSourceColumnList nvarchar(max);
    DECLARE @DataModelTableName sysname;
    DECLARE @StagingTableName sysname;
    DECLARE @IndexName sysname;
    DECLARE @KeyColumns nvarchar(max);
    DECLARE @IncludedColumns nvarchar(max);

    DECLARE @SiteCounter int;
    DECLARE @ExternalTableCounter int;
    DECLARE @DataModelTableCounter int;
    DECLARE @IndexCounter int;
    DECLARE @SelectColumnList nvarchar(max);

    SET @StagingProcedure 
        = N'CREATE OR ALTER PROCEDURE DataLoad.StageSourceSystemData' + @CRLF
        + N'AS' + @CRLF 
        + N'BEGIN' + @CRLF + @CRLF 
        + N'    -- WARNING - this procedure is auto-generated by DataLoad.RefreshExternalAndStagingObjects' + @CRLF 
        + N'    --         - do not edit it directly' + @CRLF + @CRLF 
        + N'    SET NOCOUNT ON;' + @CRLF 
        + N'    SET XACT_ABORT ON;' + @CRLF + @CRLF
        + N'    DECLARE @ProcedureName sysname = OBJECT_NAME(@@PROCID);' + @CRLF 
        + N'    DECLARE @LogMessage varchar(1000) = N''Starting'';' + @CRLF 
        + N'    EXEC DataLoad.WriteLogEntry @ProcedureName, @LogMessage;'+ @CRLF + @CRLF
        + N'    DECLARE @SelectSQL nvarchar(max);' + @CRLF + @CRLF;

    -- recreate staging schema
    
    IF EXISTS (SELECT 1 FROM sys.schemas WHERE [name] = N'Staging')
    BEGIN
        EXEC SDU_Tools.EmptySchemaInCurrentDatabase N'Staging';
        SET @SQL = N'DROP SCHEMA Staging;';
        EXEC(@SQL);
    END;
    SET @SQL = N'CREATE SCHEMA Staging AUTHORIZATION dbo;';
    EXEC(@SQL);

    -- recreate SourceDB schema
    
    IF EXISTS (SELECT 1 FROM sys.schemas WHERE [name] = @SOURCE_DB_SCHEMA_NAME)
    BEGIN
        EXEC SDU_Tools.EmptySchemaInCurrentDatabase @SOURCE_DB_SCHEMA_NAME;
        SET @SQL = N'DROP SCHEMA ' + QUOTENAME(@SOURCE_DB_SCHEMA_NAME) + N';';
        EXEC(@SQL);
    END;
    SET @SQL = N'CREATE SCHEMA ' + QUOTENAME(@SOURCE_DB_SCHEMA_NAME) 
             + N' AUTHORIZATION dbo;';
    EXEC(@SQL);
    
    -- create external data source
    
    IF EXISTS (SELECT 1 FROM sys.external_data_sources
                        WHERE [name] = @SOURCE_DB_SCHEMA_NAME + N'_DatabaseServer')
    BEGIN
        SET @SQL = N'DROP EXTERNAL DATA SOURCE '
                 + @SOURCE_DB_SCHEMA_NAME + N'_DatabaseServer;';
        EXEC(@SQL);
    END;
    
    SET @SQL = N'CREATE EXTERNAL DATA SOURCE ' + @SOURCE_DB_SCHEMA_NAME
             + N'_DatabaseServer '
             + N'WITH ( TYPE=RDBMS, LOCATION = ''' + @SourceServerName + ''','
             + N' DATABASE_NAME=''' + @SourceDatabaseName + N''','
             + N' CREDENTIAL=AquSell );';
    EXEC(@SQL);

    -- now process each external table

    SET @ExternalTableCounter = 1;

    WHILE @ExternalTableCounter <= (SELECT MAX(ExternalTableID) FROM @ExternalTables)
    BEGIN

        SELECT @SourceSchemaName = SourceSchemaName,
               @SourceTableName = SourceTableName,
               @ExternalTableName = ExternalTableName,
               @PrimaryKeyColumns = PrimaryKeyColumns, 
               @SourceColumnList = SourceColumnList
        FROM @ExternalTables 
        WHERE ExternalTableID = @ExternalTableCounter;

        SET @SQL = N'CREATE TABLE Staging.' + QUOTENAME(@ExternalTableName) + @CRLF 
                 + N'(' + @CRLF 
                 + N'    ' + @SourceColumnList + N',' + @CRLF
                 + N'    CONSTRAINT PK_Staging_' + @ExternalTableName 
                 + N' PRIMARY KEY (' + @PrimaryKeyColumns + N')' + @CRLF
                 + N');';
        EXEC(@SQL);

        SET @IndexCounter = 1;

        WHILE @IndexCounter <= (SELECT MAX(StagingIndexID) FROM @StagingIndexes)
        BEGIN
            SELECT @StagingTableName = si.StagingTableName,
                   @IndexName = si.IndexName,
                   @KeyColumns = si.KeyColumns,
                   @IncludedColumns = si.IncludedColumns 
            FROM @StagingIndexes AS si
            WHERE si.StagingIndexID = @IndexCounter;

            IF @StagingTableName = @ExternalTableName 
            BEGIN
                SET @SQL = N'CREATE INDEX ' + QUOTENAME(@IndexName) + @CRLF 
                         + N'ON Staging.' + QUOTENAME(@ExternalTableName) 
                         + N' (' + @KeyColumns + N')' 
                         + CASE WHEN @IncludedColumns IS NOT NULL
                                THEN @CRLF + N'INCLUDE (' + @IncludedColumns + N')'
                                ELSE N''
                           END + N';' + @CRLF;
                EXEC(@SQL);
            END;

            SET @IndexCounter += 1;
        END;

        SET @SelectColumnList = (SELECT STRING_AGG(QUOTENAME(c.[name]), N', ') 
                                        WITHIN GROUP (ORDER BY c.column_id) 
                                 FROM sys.columns AS c
                                 INNER JOIN sys.tables AS t
                                 ON t.object_id = c.object_id 
                                 INNER JOIN sys.schemas AS s
                                 ON s.schema_id = t.schema_id 
                                 WHERE s.[name] = N'Staging'
                                 AND t.[name] = @ExternalTableName
                                 AND c.is_computed = 0);

        SET @StagingProcedure += N'    EXEC DataLoad.WriteLogEntry @ProcedureName, ''' + @ExternalTableName + N' Starting'';'+ @CRLF
                               + N'    TRUNCATE TABLE Staging.' + QUOTENAME(@ExternalTableName) + N';' + @CRLF + @CRLF
                               + N'    SET @SelectSQL = N''SELECT ' 
                               + @SelectColumnList 
                               + N' FROM ' + QUOTENAME(@SOURCE_DB_SCHEMA_NAME) 
                               + N'.' + QUOTENAME(@ExternalTableName) + N'''' + @CRLF 
                               + N'    INSERT Staging.' + QUOTENAME(@ExternalTableName) + @CRLF 
                               + N'    (' + @CRLF 
                               + N'        ' + @SelectColumnList + @CRLF
                               + N'    )' + @CRLF 
                               + N'    EXEC (@SelectSQL);' + @CRLF + @CRLF; 

        -- drop if already existing
        
        IF EXISTS (SELECT 1 FROM sys.tables AS t
                            INNER JOIN sys.schemas AS s
                            ON t.schema_id = s.schema_id
                            WHERE s.[name] = @SOURCE_DB_SCHEMA_NAME 
                            AND t.[name] = @ExternalTableName)
        BEGIN
            SET @SQL = N'DROP EXTERNAL TABLE ' 
                       + @SOURCE_DB_SCHEMA_NAME + N'.' + @ExternalTableName + N';';
            EXEC(@SQL);
        END;

        -- exceptions for inconsistent definitions -> check for exceptions in @SelectColumnList also

        SET @CorrectedSourceColumnList = @SourceColumnList;

        -- create the exernal tables
        
        SET @SQL = N'CREATE EXTERNAL TABLE ' 
                 + @SOURCE_DB_SCHEMA_NAME + N'.' + @ExternalTableName
                 + N'('
                 + @CorrectedSourceColumnList
             + N') WITH ( DATA_SOURCE = ' + @SOURCE_DB_SCHEMA_NAME + N'_DatabaseServer,'
             + N' SCHEMA_NAME = N''' + @SourceSchemaName + N''','
             + N' OBJECT_NAME = N''' + @SourceTableName + N''' );';
        EXEC(@SQL);

        SET @ExternalTableCounter += 1;
    END;
 
    SET @StagingProcedure += N'    SET @LogMessage = N''Completed'';' + @CRLF 
                           + N'    EXEC DataLoad.WriteLogEntry @ProcedureName, @LogMessage;' + @CRLF + @CRLF         
                           + N'END;';

    --EXEC SDU_Tools.ExecuteOrPrint @StagingProcedure, 1;
    EXEC(@StagingProcedure);

    EXEC DataLoad.WriteLogEntry @ProcedureName, 'Completed';

END;
GO
