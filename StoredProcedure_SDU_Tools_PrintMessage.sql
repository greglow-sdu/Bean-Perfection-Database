CREATE OR ALTER PROCEDURE SDU_Tools.PrintMessage
@MessageToPrint nvarchar(max) 
AS
BEGIN

-- Function:      Print a message immediately 
-- Parameters:    @MessageToPrint nvarchar(max) -> The message to be printed
-- Action:        Prints a message immediately rather than waiting for PRINT to be returned
-- Return:        Nil
-- Refer to this video: https://youtu.be/Coabe1oY8Vg
--
-- Test examples: 
/*

EXEC SDU_Tools.PrintMessage N'Hello';

*/
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    RAISERROR (@MessageToPrint, 10, 1) WITH NOWAIT;
END;
GO
