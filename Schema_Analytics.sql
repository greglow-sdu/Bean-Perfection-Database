IF NOT EXISTS (SELECT 1 FROM sys.schemas AS s WHERE s.[name]= N'Analytics')
BEGIN
    DECLARE @SQL nvarchar(max) = N'CREATE SCHEMA Analytics AUTHORIZATION dbo;';
    EXEC (@SQL);
END;
GO