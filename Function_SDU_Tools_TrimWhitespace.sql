CREATE OR ALTER FUNCTION SDU_Tools.TrimWhitespace
( 
    @InputString nvarchar(max)
)
RETURNS nvarchar(max)
AS
BEGIN

-- Function:      Trims all whitespace around a string
-- Parameters:    @InputString nvarchar(max)
-- Action:        Removes any leading or trailing space, tab, carriage return, 
--                linefeed characters.
-- Return:        nvarchar(max)
-- Refer to this video: https://youtu.be/cYaUC053Elo
--
-- Test examples: 
/*

SELECT '-->' + SDU_Tools.TrimWhitespace('Test String') + '<--';
SELECT '-->' + SDU_Tools.TrimWhitespace('  Test String     ') + '<--';
SELECT '-->' + SDU_Tools.TrimWhitespace('  Test String  ' + char(13) + char(10) + ' ' + char(9) + '   ') + '<--';
SELECT '-->' + SDU_Tools.TrimWhitespace(N'  Test String  ' + nchar(13) + nchar(10) + N' ' + nchar(8232) + N'   ') + N'<--';

*/

    DECLARE @NonWhitespaceCharacterPattern nvarchar(30) 
      = N'%[^'
      + NCHAR(9) + NCHAR(10) + NCHAR(11) + NCHAR(12) + NCHAR(13) 
      + NCHAR(32) + NCHAR(133) + NCHAR(160) + NCHAR(5760) + NCHAR(8192) 
      + NCHAR(8193) + NCHAR(8194) + NCHAR(8195) + NCHAR(8196) 
      + NCHAR(8197) + NCHAR(8198) + NCHAR(8199) + NCHAR(8200) 
      + NCHAR(8201) + NCHAR(8202) + NCHAR(8232) + NCHAR(8233) 
      + NCHAR(8239) + NCHAR(8287) + NCHAR(12288)
      + N']%';

    DECLARE @StartCharacter int = PATINDEX(@NonWhitespaceCharacterPattern, @InputString);
    DECLARE @LastCharacter int = PATINDEX(@NonWhitespaceCharacterPattern, REVERSE(@InputString));

    RETURN CASE WHEN @StartCharacter = 0 THEN N''
                ELSE SUBSTRING(@InputString, @StartCharacter, DATALENGTH(@InputString) / 2 + 2 - @StartCharacter - @LastCharacter)
           END;
END;
GO

