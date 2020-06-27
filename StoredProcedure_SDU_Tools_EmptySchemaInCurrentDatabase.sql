CREATE OR ALTER PROCEDURE SDU_Tools.EmptySchemaInCurrentDatabase
@SchemaName sysname
AS
BEGIN

-- Note: adapted from standard EmptySchema tool to work only in the current database

    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    DECLARE @SQL nvarchar(max) = 
N'  DECLARE @SchemaName sysname = N''' + @SchemaName + N''';
    DECLARE @SQL nvarchar(max);
    DECLARE @ReturnValue int = 0;
    DECLARE @SchemaID int = SCHEMA_ID(@SchemaName);
    
    IF @SchemaID IS NULL OR @SchemaName IN (N''sys'', N''dbo'', N''SDU_Tools'')
    BEGIN
        RAISERROR (''Selected schema is not present in the current database'', 16, 1);
        SET @ReturnValue = -1;
    END
    ELSE 
    BEGIN -- drop all existing objects in the schema
        DECLARE @ObjectCounter as int = 1;
        DECLARE @ObjectName sysname;
        DECLARE @TableName sysname;
        DECLARE @ObjectTypeCode varchar(10);
        DECLARE @IsExternalTable bit;

        DECLARE @ObjectsToRemove TABLE
        ( 
            ObjectRemovalOrder int IDENTITY(1,1) NOT NULL,
            ObjectTypeCode varchar(10) NOT NULL,
            ObjectName sysname NOT NULL,
            TableName sysname NULL,
            IsExternalTable bit 
        );
        
        INSERT @ObjectsToRemove (ObjectTypeCode, ObjectName, TableName, IsExternalTable)
        SELECT o.[type], COALESCE(tt.[name], o.[name]), t.[name], COALESCE(tab.is_external, 0)
        FROM sys.objects AS o 
        LEFT OUTER JOIN sys.objects AS t
            ON o.parent_object_id = t.[object_id]
        LEFT OUTER JOIN sys.table_types AS tt
            ON tt.type_table_object_id = o.object_id
        LEFT OUTER JOIN sys.tables AS tab
            ON tab.object_id = o.object_id
        WHERE COALESCE(tt.[schema_id], o.[schema_id]) = @SchemaID
        AND o.[type] NOT IN (''PK'', ''UQ'', ''C'', ''F'') 
        AND ISNULL(t.[type], ''U'') = ''U''
        ORDER BY CASE o.[type] WHEN ''V'' THEN 1    -- view
                               WHEN ''P'' THEN 2    -- stored procedure
                               WHEN ''PC'' THEN 3   -- clr stored procedure
                               WHEN ''FN'' THEN 4   -- scalar function
                               WHEN ''FS'' THEN 5   -- clr scalar function
                               WHEN ''AF'' THEN 6   -- clr aggregate
                               WHEN ''FT'' THEN 7   -- clr table-valued function
                               WHEN ''TF'' THEN 8   -- table-valued function
                               WHEN ''IF'' THEN 9   -- inline table-valued function
                               WHEN ''TR'' THEN 10  -- trigger
                               WHEN ''TA'' THEN 11  -- clr trigger
                               WHEN ''D'' THEN 12   -- default
                               WHEN ''F'' THEN 13
                               WHEN ''C'' THEN 14   -- check constraint
                               WHEN ''UQ'' THEN 15  -- unique constraint
                               WHEN ''PK'' THEN 16  -- primary key constraint
                               WHEN ''U'' THEN 17   -- table
                               WHEN ''TT'' THEN 18  -- table type
                               WHEN ''SO'' THEN 19  -- sequence
                 END;

        WHILE @ObjectCounter <= (SELECT MAX(ObjectRemovalOrder) FROM @ObjectsToRemove)
        BEGIN
            SELECT @ObjectTypeCode = otr.ObjectTypeCode,
                   @ObjectName = otr.ObjectName,
                   @TableName = otr.TableName,
                   @IsExternalTable = otr.IsExternalTable
            FROM @ObjectsToRemove AS otr 
            WHERE otr.ObjectRemovalOrder = @ObjectCounter;
    
            SET @SQL = CASE WHEN @ObjectTypeCode = ''V'' 
                            THEN N''DROP VIEW '' + QUOTENAME(@SchemaName) + N''.'' + QUOTENAME(@ObjectName) + N'';''
                            WHEN @ObjectTypeCode IN (''P'' , ''PC'')
                            THEN N''DROP PROCEDURE '' + QUOTENAME(@SchemaName) + N''.'' + QUOTENAME(@ObjectName) + N'';''
                            WHEN @ObjectTypeCode IN (''FN'', ''FS'', ''FT'', ''TF'', ''IF'')
                            THEN N''DROP FUNCTION '' + QUOTENAME(@SchemaName) + N''.'' + QUOTENAME(@ObjectName) + N'';''
                            WHEN @ObjectTypeCode IN (''TR'', ''TA'')
                            THEN N''DROP TRIGGER '' + QUOTENAME(@SchemaName) + N''.'' + QUOTENAME(@ObjectName) + N'';''
                            WHEN @ObjectTypeCode IN (''C'', ''D'', ''F'', ''PK'', ''UQ'')
                            THEN N''ALTER TABLE '' + QUOTENAME(@SchemaName) + N''.'' + QUOTENAME(@TableName) 
                                 + N'' DROP CONSTRAINT '' + QUOTENAME(@ObjectName) + N'';''
                            WHEN @ObjectTypeCode = ''U'' AND @IsExternalTable = 0
                            THEN N''DROP TABLE '' + QUOTENAME(@SchemaName) + N''.'' + QUOTENAME(@ObjectName) + N'';''
                            WHEN @ObjectTypeCode = ''U'' AND @IsExternalTable <> 0
                            THEN N''DROP EXTERNAL TABLE '' + QUOTENAME(@SchemaName) + N''.'' + QUOTENAME(@ObjectName) + N'';''
                            WHEN @ObjectTypeCode = ''AF''
                            THEN N''DROP AGGREGATE '' + QUOTENAME(@SchemaName) + N''.'' + QUOTENAME(@ObjectName) + N'';''
                            WHEN @ObjectTypeCode = ''TT''
                            THEN N''DROP TYPE '' + QUOTENAME(@SchemaName) + N''.'' + QUOTENAME(@ObjectName) + N'';''
                            WHEN @ObjectTypeCode = ''SO''
                            THEN N''DROP SEQUENCE '' + QUOTENAME(@SchemaName) + N''.'' + QUOTENAME(@ObjectName) + N'';''
                       END;
    
                IF @SQL IS NOT NULL
                BEGIN
                    EXECUTE(@SQL);
                END;
    
            SET @ObjectCounter += 1;
        END;
    END;';
    EXECUTE (@SQL);
END;
GO
