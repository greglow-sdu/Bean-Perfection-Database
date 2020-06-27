IF NOT EXISTS (SELECT 1 FROM sys.database_principals 
                        WHERE [name] = N'BeanPerfection_BIUser')
BEGIN
    DECLARE @SQL nvarchar(max) = N'
        CREATE USER BeanPerfection_BIUser
	    WITH PASSWORD = ''2308SDFSkdjls!!'';';
    EXEC (@SQL);
END;
GO

IF NOT EXISTS (SELECT 1 FROM sys.database_principals
                        WHERE [name] = N'BI_Access'
                        AND [type] = N'R')
BEGIN
    DECLARE @SQL nvarchar(max) = N'CREATE ROLE BI_Access AUTHORIZATION dbo;';
    EXEC (@SQL);
END;
GO

GRANT SELECT, EXECUTE, VIEW DEFINITION
ON SCHEMA::Analytics
TO BI_Access;
GO

ALTER ROLE BI_Access 
ADD MEMBER BeanPerfection_BIUser;
GO