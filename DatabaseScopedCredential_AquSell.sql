IF NOT EXISTS (SELECT 1 FROM sys.database_scoped_credentials WHERE [name] = N'AquSell')
BEGIN
    CREATE DATABASE SCOPED CREDENTIAL AquSell
    WITH IDENTITY = N'aqusellbi', SECRET = N'20923Flksldf!!';  
END;
GO
