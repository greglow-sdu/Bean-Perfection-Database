IF NOT EXISTS (SELECT 1 FROM sys.schemas AS s WHERE s.[name]= N'DataLoad')
BEGIN
    DECLARE @SQL nvarchar(max) = N'CREATE SCHEMA DataLoad AUTHORIZATION dbo;';
    EXEC (@SQL);
END;
GO