IF NOT EXISTS (SELECT 1 FROM sys.schemas AS s WHERE s.[name]= N'DataModel')
BEGIN
    DECLARE @SQL nvarchar(max) = N'CREATE SCHEMA DataModel AUTHORIZATION dbo;';
    EXEC (@SQL);
END;
GO