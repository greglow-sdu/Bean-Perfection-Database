CREATE OR ALTER PROCEDURE DataLoad.GetRecentLogEntries
@NumberOfEntries int = 100
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    SELECT TOP(@NumberOfEntries) *
    FROM DataLoad.LogEntries 
    ORDER BY LogEntryID DESC;
END;
GO
