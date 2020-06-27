IF NOT EXISTS (SELECT 1 FROM sys.sequences AS seq
                        INNER JOIN sys.schemas AS sch
                        ON sch.schema_id = seq.schema_id 
                        WHERE sch.[name] = N'DataLoad'
                        AND seq.[name] = N'LogEntryID')
BEGIN
    DECLARE @SQL nvarchar(max) = N'CREATE SEQUENCE DataLoad.LogEntryID AS bigint START WITH 1;';
    EXEC (@SQL);
END;
GO