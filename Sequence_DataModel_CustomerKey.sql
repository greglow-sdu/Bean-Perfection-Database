IF NOT EXISTS (SELECT 1 FROM sys.sequences AS seq
                        INNER JOIN sys.schemas AS sch
                        ON sch.schema_id = seq.schema_id 
                        WHERE sch.[name] = N'DataModel'
                        AND seq.[name] = N'CustomerKey')
BEGIN
    DECLARE @SQL nvarchar(max) = N'CREATE SEQUENCE DataModel.CustomerKey AS int START WITH 1;';
    EXEC (@SQL);
END;
GO

