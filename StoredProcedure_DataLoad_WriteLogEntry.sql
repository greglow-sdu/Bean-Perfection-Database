CREATE OR ALTER PROCEDURE DataLoad.WriteLogEntry
@ProcedureName sysname,
@Details varchar(1000)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    INSERT DataLoad.LogEntries 
    (
        ProcedureName, Details
    )
    SELECT @ProcedureName, @Details;
END;
GO
