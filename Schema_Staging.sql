IF NOT EXISTS (SELECT 1 FROM sys.schemas AS s WHERE s.[name]= N'Staging')
BEGIN
    DECLARE @SQL nvarchar(max) = N'CREATE SCHEMA Staging AUTHORIZATION dbo;';
    EXEC (@SQL);
END;
GO