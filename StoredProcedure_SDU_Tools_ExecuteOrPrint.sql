CREATE OR ALTER PROCEDURE SDU_Tools.ExecuteOrPrint
@StringToExecuteOrPrint nvarchar(max),
@PrintOnly bit = 1,
@NumberOfCrLfBeforeGO int = 0,
@IncludeGO bit = 0,
@NumberOfCrLfAfterGO int = 0,
@BatchSeparator nvarchar(20) = N'GO'
AS BEGIN

-- Function:      Execute or Print One or More SQL Commands in a String
-- Parameters:    @StringToExecuteOrPrint nvarchar(max) -> String containing SQL commands
--                @PrintOnly bit = 1                    -> If set to 1 commands are printed only not executed
--                @NumberOfCrLfBeforeGO int = 0         -> Number of carriage return linefeeds added before the
--                                                         batch separator (normally GO)
--                @IncludeGO bit = 0                    -> If 1 the batch separator (normally GO) will be added
--                @NumberOfCrLfAfterGO int = 0          -> Number of carriage return linefeeds added after the
--                                                         batch separator (normally GO)
--                @BatchSeparator nvarchar(20) = N'GO'  -> Batch separator to use (defaults to GO)
-- Action:        Either prints the SQL code or executes it batch by batch.
-- Return:        int 0 on success
-- Refer to this video: https://youtu.be/cABGotl_yHY
--
-- Test examples: 
/*

DECLARE @SQL nvarchar(max) = N'SELECT ''Hello Greg'';';

EXEC SDU_Tools.ExecuteOrPrint @StringToExecuteOrPrint = @SQL,
                              @IncludeGO = 1,
                              @NumberOfCrLfAfterGO = 1;
SET @SQL = N'SELECT ''Another statement'';';

EXEC SDU_Tools.ExecuteOrPrint @StringToExecuteOrPrint = @SQL,
                              @IncludeGO = 1,
                              @NumberOfCrLfAfterGO = 1;

*/
    SET NOCOUNT ON;

    DECLARE @LineFeed nchar(1) = NCHAR(10);
    DECLARE @CarriageReturn nchar(1) = NCHAR(13);
    DECLARE @CRLF nchar(2) = @CarriageReturn + @LineFeed;
    
    DECLARE @RemainingString nvarchar(max) = REPLACE(SDU_Tools.TrimWhitespace(@StringToExecuteOrPrint), @LineFeed, N'');
    DECLARE @FullLine nvarchar(max);
    DECLARE @TrimmedLine nvarchar(max);
    DECLARE @StringToExecute nvarchar(max) = N'';
    DECLARE @NextLineEnd int;
    DECLARE @Counter int;

    WHILE LEN(@RemainingString) > 0
    BEGIN
        SET @NextLineEnd = CHARINDEX(@CarriageReturn, @RemainingString, 1);
        IF @NextLineEnd <> 0 -- more than one line left
        BEGIN
            SET @FullLine = RTRIM(SUBSTRING(@RemainingString, 1, @NextLineEnd - 1));
            PRINT @FullLine;
            SET @TrimmedLine = SDU_Tools.TrimWhitespace(@FullLine);
            IF @TrimmedLine = @BatchSeparator -- line just contains GO
            BEGIN
                SET @StringToExecute = SDU_Tools.TrimWhitespace(@StringToExecute);
                IF @StringToExecute <> N'' AND @PrintOnly = 0
                BEGIN
                    EXECUTE (@StringToExecute); -- Execute if non-blank
                END;
                SET @StringToExecute = N'';
            END ELSE BEGIN
                SET @StringToExecute += @CRLF + @FullLine;
            END;
            SET @RemainingString = RTRIM(SUBSTRING(@RemainingString, @NextLineEnd + 1, LEN(@RemainingString)));
        END ELSE BEGIN -- on the last line
            SET @FullLine = RTRIM(@RemainingString);
            PRINT @FullLine;
            SET @TrimmedLine = SDU_Tools.TrimWhitespace(@FullLine);
            IF @TrimmedLine <> @BatchSeparator -- not just a line with GO
            BEGIN
                SET @StringToExecute += @CRLF + @FullLine;
                SET @StringToExecute = SDU_Tools.TrimWhitespace(@StringToExecute);
                IF @StringToExecute <> N'' AND @PrintOnly = 0
                BEGIN
                    EXECUTE (@StringToExecute); -- Execute if non-blank
                END;
                SET @StringToExecute = N'';
            END;

            SET @RemainingString = N'';
        END;
    END;

    SET @Counter = 0;
    WHILE @Counter < @NumberOfCrLfBeforeGO
    BEGIN
        PRINT N' ';
        SET @Counter += 1;
    END;
    IF @IncludeGO <> 0 PRINT @BatchSeparator;

    SET @Counter = 0;
    WHILE @Counter < @NumberOfCrLfAfterGO
    BEGIN
        PRINT N' ';
        SET @Counter += 1;
    END;
END;
GO
