CREATE OR ALTER FUNCTION SDU_Tools.ProperCase
(
    @InputString nvarchar(max)
)
RETURNS nvarchar(max)
AS
BEGIN

-- Function:      Apply Proper Casing to a string
-- Parameters:    @InputString varchar(max)
-- Action:        Apply Proper Casing to a string
-- Return:        varchar(max)
-- Refer to this video: https://youtu.be/OZ-ozo7R9eU
--
-- Test examples: 
/*

SELECT SDU_Tools.ProperCase(N'the  quick   brown fox consumed a macrib at mcdonalds');
SELECT SDU_Tools.ProperCase(N'janet mcdermott');
SELECT SDU_Tools.ProperCase(N'the curly-Haired  company');
SELECT SDU_Tools.ProperCase(N'po Box 1086');
SELECT SDU_Tools.ProperCase(N'now is the time for a bbq folks');

*/
    DECLARE @Response nvarchar(max) = N'';
    DECLARE @StringToProcess nvarchar(max);
    DECLARE @CharacterCounter int = 0;
    DECLARE @WordCounter int = 0;
    DECLARE @Character nchar(1);
    DECLARE @InAWord bit;
    DECLARE @CurrentWord nvarchar(max);
    DECLARE @ModifiedWord nvarchar(max);
    DECLARE @NumberOfWords int;
    
    DECLARE @Words TABLE
    (
        WordNumber int IDENTITY(1,1),
        Word nvarchar(max)
    );
    
    SET @StringToProcess = LOWER(LTRIM(RTRIM(@InputString)));
    SET @InAWord = 0;
    SET @CurrentWord = N'';
    
    WHILE @CharacterCounter < LEN(@StringToProcess)
    BEGIN
        SET @CharacterCounter += 1;
        SET @Character = SUBSTRING(@StringToProcess, @CharacterCounter, 1);
        IF @Character IN (N' ', NCHAR(9), N'(', N')') -- whitespace
        BEGIN
            IF @InAWord <> 0
            BEGIN
                SET @InAWord = 0;
                INSERT @Words VALUES (@CurrentWord);
                SET @CurrentWord = N'';
            END;
        END ELSE BEGIN -- not whitespace
            IF @InAWord = 0 -- start of a word
            BEGIN
                SET @InAWord = 1;
                SET @CurrentWord = @Character;
            END ELSE BEGIN -- part of a word
                SET @CurrentWord += @Character;
            END;
        END;
    END;
    IF @InAWord <> 0 
    BEGIN
        INSERT @Words VALUES (@CurrentWord);
    END;
    
    SET @NumberOfWords = (SELECT COUNT(*) FROM @Words);
    SET @WordCounter = 0;
    
    WHILE @WordCounter < @NumberOfWords
    BEGIN
        SET @WordCounter += 1;
        SET @CurrentWord = (SELECT Word FROM @Words WHERE WordNumber = @WordCounter);

        IF @CurrentWord IN ('ACT', 'ABC', 'BBQ', 'NSW', 'QLD', 'TAS', 'VIC')
           OR (LEN(@CurrentWord) <= 2 AND @CurrentWord NOT IN ('CO', 'DO'))
        BEGIN
            SET @ModifiedWord = UPPER(@CurrentWord);
        END ELSE BEGIN
            SET @ModifiedWord = UPPER(SUBSTRING(@CurrentWord, 1, 1)) + SUBSTRING(@CurrentWord, 2, LEN(@CurrentWord) - 1);
        END;
        IF LEFT(@CurrentWord, 2) = N'mc' AND LEN(@CurrentWord) >= 3
        BEGIN
            SET @ModifiedWord = N'Mc' + UPPER(SUBSTRING(@CurrentWord, 3, 1)) + SUBSTRING(@CurrentWord, 4, LEN(@CurrentWord) - 3);
        END;
        IF LEFT(@CurrentWord, 3) = N'mac' AND LEN(@CurrentWord) >= 4
        BEGIN
            SET @ModifiedWord = N'Mac' + UPPER(SUBSTRING(@CurrentWord, 4, 1)) + SUBSTRING(@CurrentWord, 5, LEN(@CurrentWord) - 4);
        END;
        
        SET @CharacterCounter = 0;
        WHILE @CharacterCounter <= LEN(@ModifiedWord)
        BEGIN
            SET @CharacterCounter += 1;
            SET @Character = SUBSTRING(@ModifiedWord, @CharacterCounter, 1);
            IF @Character IN (N'.', N'-', N';', N':', N'&', N'$', N'#', N'@', N'!', N'*', N'%', N'(', N')', N'/')
            BEGIN
                IF LEN(@ModifiedWord) > @CharacterCounter 
                BEGIN
                    SET @ModifiedWord = SUBSTRING(@ModifiedWord, 1, @CharacterCounter)
                                      + UPPER(SUBSTRING(@ModifiedWord, @CharacterCounter + 1, 1))
                                      + SUBSTRING(@ModifiedWord, @CharacterCounter + 2, LEN(@ModifiedWord) - @CharacterCounter - 1);
                END;
            END;
        END;
        
        SET @Response += @ModifiedWord;
        IF @WordCounter < @NumberOfWords SET @Response += N' ';
    END;
    
    RETURN @Response;
END;
GO