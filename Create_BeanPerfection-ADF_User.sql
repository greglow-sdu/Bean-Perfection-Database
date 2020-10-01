-- Note: must be run from an AD-connected connection

IF NOT EXISTS (SELECT 1 FROM sys.sysusers WHERE [name] = N'beanperfection-adf')
BEGIN
    CREATE USER [beanperfection-adf] FROM EXTERNAL PROVIDER;
    ALTER ROLE db_owner ADD MEMBER [beanperfection-adf];
END;