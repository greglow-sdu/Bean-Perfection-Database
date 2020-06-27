CREATE OR ALTER FUNCTION SDU_Tools.DateDimensionColumns
(
    @Date date,
    @FiscalYearStartMonth int
)
RETURNS TABLE
AS
RETURN SELECT @Date AS [Date],
              DAY(@Date) AS DayNumber,
              DATENAME(weekday, @Date) AS [DayName],
              LEFT(DATENAME(weekday, @Date), 3) AS ShortDayName,
              CAST(DATENAME(month, @Date) AS nvarchar(10)) AS MonthName,
              CAST(SUBSTRING(DATENAME(month, @Date), 1, 3) AS nvarchar(3)) AS ShortMonthName,
              MONTH(@Date) AS [MonthNumber],
              N'CY' + CAST(YEAR(@Date) AS nvarchar(4)) + N'-' + SUBSTRING(DATENAME(month, @Date), 1, 3) AS MonthLabel,
              (MONTH(@Date) - 1) / 3 + 1 AS QuarterNumber,
              N'CYQ' + CAST((MONTH(@Date) - 1) / 3 + 1 AS nvarchar(10)) AS QuarterLabel,
              YEAR(@Date) AS [Year],
              CAST(N'CY' + CAST(YEAR(@Date) AS nvarchar(4)) AS nvarchar(10)) AS YearLabel,
              DATEPART(dayofyear, @Date) AS DayOfYear,
              CASE WHEN MONTH(@Date) >= @FiscalYearStartMonth
                   THEN MONTH(@Date) - @FiscalYearStartMonth + 1
                   ELSE MONTH(@Date) + 13 - @FiscalYearStartMonth
              END AS FiscalMonthNumber,
              N'FY' + CAST(CASE WHEN MONTH(@Date) >= @FiscalYearStartMonth
                                THEN YEAR(@Date) + 1
                                ELSE YEAR(@Date)
                           END AS nvarchar(4)) + N'-' + SUBSTRING(DATENAME(month, @Date), 1, 3) AS FiscalMonthLabel,
              (CASE WHEN MONTH(@Date) >= @FiscalYearStartMonth
                   THEN MONTH(@Date) - @FiscalYearStartMonth + 1
                   ELSE MONTH(@Date) + 13 - @FiscalYearStartMonth
               END - 1) / 3 + 1 AS FiscalQuarterNumber,
              N'FYQ' + CAST((CASE WHEN MONTH(@Date) >= @FiscalYearStartMonth
                                  THEN MONTH(@Date) - @FiscalYearStartMonth + 1
                                  ELSE MONTH(@Date) + 13 - @FiscalYearStartMonth
                             END - 1) / 3 + 1 AS nvarchar(10)) AS FiscalQuarterLabel,
              CASE WHEN MONTH(@Date) >= @FiscalYearStartMonth
                   THEN YEAR(@Date) + 1
                   ELSE YEAR(@Date)
              END AS FiscalYear,
              N'FY' + CAST(CASE WHEN MONTH(@Date) >= @FiscalYearStartMonth
                                THEN YEAR(@Date) + 1
                                ELSE YEAR(@Date)
                           END AS nvarchar(4)) AS FiscalYearLabel,
              CASE WHEN MONTH(@Date) >= @FiscalYearStartMonth 
                   THEN DATEDIFF(day, 
                                 CAST(CAST(YEAR(@Date) AS nvarchar(4)) 
                                      + RIGHT(N'0' + CAST(@FiscalYearStartMonth AS nvarchar(2)), 2) 
                                      + N'01' AS date),
                                 @Date) + 1
                   ELSE DATEDIFF(day, 
                                 CAST(CAST(YEAR(@Date) - 1 AS nvarchar(4)) 
                                      + RIGHT(N'0' + CAST(@FiscalYearStartMonth AS nvarchar(2)), 2) 
                                      + N'01' AS date),
                                 @Date) + 1
              END AS DayOfFiscalYear,
              DATEPART(ISO_WEEK, @Date) AS ISOWeekNumber,
              DATEFROMPARTS(YEAR(@Date), MONTH(@Date), 1) AS StartOfMonthDate,
              EOMONTH(@Date) AS EndOfMonthDate;
GO


