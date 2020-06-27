CREATE OR ALTER FUNCTION SDU_Tools.DateDimensionPeriodColumns
(
    @Date date,
    @FiscalYearStartMonth int,
    @Today date
)
RETURNS TABLE
AS
-- Adapted from SDU_Tools v19

-- Function:      Returns a table (single row) of date dimension period columns
-- Parameters:    @Date date => date to process
--                @FiscalYearStartMonth int => month number when the financial year starts
--                @Today date => the current day (or the target day)
-- Action:        Returns a single row table with date dimension period columns
-- Return:        Single row rowset with date dimension period columns
-- Refer to this video: https://youtu.be/pcoaHYK70nU
--
-- Test examples: 
/*

SELECT * FROM SDU_Tools.DateDimensionPeriodColumns('20200131', 7, SYSDATETIME());

SELECT db.DateValue, ddpc.* 
FROM SDU_Tools.DatesBetween('20190201', '20200420') AS db
CROSS APPLY SDU_Tools.DateDimensionPeriodColumns(db.DateValue, 7, SYSDATETIME()) AS ddpc
ORDER BY db.DateValue;

SELECT ddc.*, ddpc.* 
FROM SDU_Tools.DatesBetween('20200201', '20200401') AS db
CROSS APPLY SDU_Tools.DateDimensionColumns(db.DateValue, 7) AS ddc
CROSS APPLY SDU_Tools.DateDimensionPeriodColumns(db.DateValue, 7, SYSDATETIME()) AS ddpc
ORDER BY db.DateValue;

*/
RETURN 

WITH FiscalYearDates
AS
(
    SELECT CASE WHEN MONTH(@Today) >= @FiscalYearStartMonth
                THEN CAST(CAST(YEAR(@Today) AS varchar(4)) 
                               + RIGHT('00' + CAST(@FiscalYearStartMonth AS varchar(2)), 2)
                               + '01' AS date)
                ELSE CAST(CAST(YEAR(@Today) - 1AS varchar(4)) 
                               + RIGHT('00' + CAST(@FiscalYearStartMonth AS varchar(2)), 2)
                               + '01' AS date)
           END AS StartOfFiscalYear,
           DATEADD(day, -1, 
                   DATEADD(year, 1, 
                           CASE WHEN MONTH(@Today) >= @FiscalYearStartMonth
                                THEN CAST(CAST(YEAR(@Today) AS varchar(4)) 
                                          + RIGHT('00' + CAST(@FiscalYearStartMonth AS varchar(2)), 2)
                                          + '01' AS date)
                                ELSE CAST(CAST(YEAR(@Today) - 1AS varchar(4)) 
                                          + RIGHT('00' + CAST(@FiscalYearStartMonth AS varchar(2)), 2)
                                          + '01' AS date)
           END)) AS EndOfFiscalYear
)
SELECT CASE WHEN @Date = @Today 
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsToday,
       CASE WHEN @Date = DATEADD(day, -1, @Today)
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsYesterday,
       CASE WHEN @Date = DATEADD(day, 1, @Today)
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsTomorrow,
       CASE WHEN @Date > @Today 
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsFuture,
       CASE WHEN DATEPART(weekday, @Date) 
                 NOT IN (DATEPART(weekday, '19000106'), -- Saturday
                         DATEPART(weekday, '19000107')) -- Sunday
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsWorkingDay,
       CASE WHEN @Date = CASE WHEN DATEPART(weekday, @Today) = DATEPART(weekday, '19000108') -- Monday
                              THEN DATEADD(day, -3, @Today)
                              ELSE DATEADD(day, -1, @Today)
                         END 
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsLastWorkingDay,
       CASE WHEN @Date = CASE WHEN DATEPART(weekday, @Today) = DATEPART(weekday, '19000105') -- Friday
                              THEN DATEADD(day, 3, @Today)
                              ELSE DATEADD(day, 1, @Today)
                         END 
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsNextWorkingDay,
       CASE WHEN DATEPART(weekday, @Date) 
                 IN (DATEPART(weekday, '19000106'), -- Saturday
                     DATEPART(weekday, '19000107')) -- Sunday
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsWeekend,
       CASE WHEN MONTH(@Date) = MONTH(@Today) AND YEAR(@Date) = YEAR(@Today)
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsSameMonth,
       CASE WHEN MONTH(@Date) = MONTH(@Today) AND YEAR(@Date) = YEAR(@Today)
                                              AND DAY(@Date) BETWEEN 1 AND DAY(@Today)
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsMonthToDate,
       CASE WHEN MONTH(@Date) = MONTH(@Today) AND YEAR(@Date) = (YEAR(@Today) - 1)
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsSameMonthLastYear,
       CASE WHEN MONTH(@Date) = MONTH(@Today) AND YEAR(@Date) = (YEAR(@Today) - 1)
                                              AND DAY(@Date) BETWEEN 1 AND DAY(@Today)
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsMonthToDateLastYear,
       CASE WHEN YEAR(@Date) = YEAR(@Today)
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsSameCalendarYear,
       CASE WHEN @Date BETWEEN CAST(CAST(YEAR(@Today) AS varchar(4)) + '0101' AS date)
                       AND @Today 
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsCalendarYearToDate,
       CASE WHEN YEAR(@Date) = (YEAR(@Today) - 1)
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsLastCalendarYear,
       CASE WHEN @Date BETWEEN CAST(CAST(YEAR(@Today) - 1 AS varchar(4)) + '0101' AS date)
                       AND DATEADD(year, -1, @Today) 
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsLastCalendarYearToDate,
       CASE WHEN @Date BETWEEN fyd.StartOfFiscalYear AND fyd.EndOfFiscalYear 
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsSameFiscalYear,
       CASE WHEN @Date BETWEEN fyd.StartOfFiscalYear AND @Date  
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsSameFiscalYearToDate,
       CASE WHEN @Date BETWEEN DATEADD(year, -1, fyd.StartOfFiscalYear) 
                       AND DATEADD(year, -1, fyd.EndOfFiscalYear)
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsLastFiscalYear,
       CASE WHEN @Date BETWEEN DATEADD(year, -1, fyd.StartOfFiscalYear) 
                       AND DATEADD(year, -1, @Date)  
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsLastFiscalYearToDate,
       CASE WHEN @Date = DATEADD(day, 1 - DAY(@Today), @Today)
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsStartOfMonth,
       CASE WHEN @Date = DATEADD(day, -1, DATEADD(month, 1, DATEADD(day, 1 - DAY(@Today), @Today)))
            THEN CAST(1 AS bit)       -- Change to use of EOMONTH when 2012 is minimum
            ELSE CAST(0 AS bit)
       END AS IsEndOfMonth,
       CASE WHEN @Date BETWEEN CAST(CAST(YEAR(@Today) AS varchar(4)) + '0101' AS date)
                           AND DATEADD(day, -1, DATEADD(month, 3, CAST(CAST(YEAR(@Today) AS varchar(4)) + '0101' AS date)))
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END IsCalendarQuarter1,
       CASE WHEN @Date = CAST(CAST(YEAR(@Today) AS varchar(4)) + '0101' AS date)
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsStartOfCalendarQuarter1,
       CASE WHEN @Date = DATEADD(day, -1, DATEADD(month, 3, CAST(CAST(YEAR(@Today) AS varchar(4)) + '0101' AS date)))
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsEndOfCalendarQuarter1,
       CASE WHEN @Date BETWEEN DATEADD(month, 3, CAST(CAST(YEAR(@Today) AS varchar(4)) + '0101' AS date))
                           AND DATEADD(day, -1, DATEADD(month, 6, CAST(CAST(YEAR(@Today) AS varchar(4)) + '0101' AS date)))
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END IsCalendarQuarter2,
       CASE WHEN @Date = DATEADD(month, 3, CAST(CAST(YEAR(@Today) AS varchar(4)) + '0101' AS date))
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsStartOfCalendarQuarter2,
       CASE WHEN @Date = DATEADD(day, -1, DATEADD(month, 6, CAST(CAST(YEAR(@Today) AS varchar(4)) + '0101' AS date)))
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsEndOfCalendarQuarter2,
       CASE WHEN @Date BETWEEN DATEADD(month, 6, CAST(CAST(YEAR(@Today) AS varchar(4)) + '0101' AS date))
                           AND DATEADD(day, -1, DATEADD(month, 9, CAST(CAST(YEAR(@Today) AS varchar(4)) + '0101' AS date)))
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END IsCalendarQuarter3,
       CASE WHEN @Date = DATEADD(month, 6, CAST(CAST(YEAR(@Today) AS varchar(4)) + '0101' AS date))
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsStartOfCalendarQuarter3,
       CASE WHEN @Date = DATEADD(day, -1, DATEADD(month, 9, CAST(CAST(YEAR(@Today) AS varchar(4)) + '0101' AS date)))
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsEndOfCalendarQuarter3,
       CASE WHEN @Date BETWEEN DATEADD(month, 9, CAST(CAST(YEAR(@Today) AS varchar(4)) + '0101' AS date))
                           AND DATEADD(day, -1, DATEADD(month, 12, CAST(CAST(YEAR(@Today) AS varchar(4)) + '0101' AS date)))
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END IsCalendarQuarter4,
       CASE WHEN @Date = DATEADD(month, 9, CAST(CAST(YEAR(@Today) AS varchar(4)) + '0101' AS date))
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsStartOfCalendarQuarter4,
       CASE WHEN @Date = DATEADD(day, -1, DATEADD(month, 12, CAST(CAST(YEAR(@Today) AS varchar(4)) + '0101' AS date)))
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsEndOfCalendarQuarter4,
       CASE WHEN @Date = CAST(CAST(YEAR(@Today) AS varchar(4)) + '0101' AS date)
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsStartOfCalendarYear,
       CASE WHEN @Date = DATEADD(day, -1, CAST(CAST(YEAR(@Today) + 1 AS varchar(4)) + '0101' AS date))
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsEndOfCalendarYear,
       CASE WHEN @Date BETWEEN fyd.StartOfFiscalYear
                           AND DATEADD(day, -1, DATEADD(month, 3, fyd.StartOfFiscalYear))
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsFiscalQuarter1,
       CASE WHEN @Date = fyd.StartOfFiscalYear
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsStartOfFiscalQuarter1,
       CASE WHEN @Date = DATEADD(day, -1, DATEADD(month, 3, fyd.StartOfFiscalYear))
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsEndOfFiscalQuarter1,
       CASE WHEN @Date BETWEEN DATEADD(month, 3, fyd.StartOfFiscalYear)
                           AND DATEADD(day, -1, DATEADD(month, 6, fyd.StartOfFiscalYear))
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsFiscalQuarter2,
       CASE WHEN @Date = DATEADD(month, 3, fyd.StartOfFiscalYear)
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsStartOfFiscalQuarter2,
       CASE WHEN @Date = DATEADD(day, -1, DATEADD(month, 6, fyd.StartOfFiscalYear))
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsEndOfFiscalQuarter2,
       CASE WHEN @Date BETWEEN DATEADD(month, 6, fyd.StartOfFiscalYear)
                           AND DATEADD(day, -1, DATEADD(month, 9, fyd.StartOfFiscalYear))
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsFiscalQuarter3,
       CASE WHEN @Date = DATEADD(month, 6, fyd.StartOfFiscalYear)
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsStartOfFiscalQuarter3,
       CASE WHEN @Date = DATEADD(day, -1, DATEADD(month, 9, fyd.StartOfFiscalYear))
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsEndOfFiscalQuarter3,
       CASE WHEN @Date BETWEEN DATEADD(month, 9, fyd.StartOfFiscalYear)
                           AND DATEADD(day, -1, DATEADD(month, 12, fyd.StartOfFiscalYear))
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsFiscalQuarter4,
       CASE WHEN @Date = DATEADD(month, 9, fyd.StartOfFiscalYear)
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsStartOfFiscalQuarter4,
       CASE WHEN @Date = DATEADD(day, -1, DATEADD(month, 12, fyd.StartOfFiscalYear))
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsEndOfFiscalQuarter4,
       CASE WHEN @Date = fyd.StartOfFiscalYear 
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsStartOfFiscalYear,
       CASE WHEN @Date = fyd.EndOfFiscalYear 
            THEN CAST(1 AS bit)
            ELSE CAST(0 AS bit)
       END AS IsEndOfFiscalYear
FROM FiscalYearDates AS fyd;
GO
