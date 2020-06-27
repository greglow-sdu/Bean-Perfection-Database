IF NOT EXISTS (SELECT 1 FROM sys.schemas AS s WHERE s.[name]= N'SDU_Tools')
BEGIN
    DECLARE @SQL nvarchar(max) = N'CREATE SCHEMA SDU_Tools AUTHORIZATION dbo;';
    EXEC (@SQL);
END;
GO