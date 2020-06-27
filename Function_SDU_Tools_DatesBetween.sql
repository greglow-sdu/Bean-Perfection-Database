CREATE OR ALTER FUNCTION SDU_Tools.DatesBetween
(
    @StartDate date,
    @EndDate date 
)
RETURNS @Dates TABLE
(
    DateNumber int IDENTITY(1,1) PRIMARY KEY,
    DateValue date
)
AS
BEGIN
    DECLARE @CurrentValue date = @StartDate;

    WHILE @CurrentValue <= @EndDate 
    BEGIN
        INSERT @Dates (DateValue) VALUES (@CurrentValue);
        SET @CurrentValue = DATEADD(day, 1, @CurrentValue);
    END;

    RETURN;
END;
GO