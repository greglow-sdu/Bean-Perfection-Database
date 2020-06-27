DROP TABLE IF EXISTS DataLoad.LogEntries;
GO

CREATE TABLE DataLoad.LogEntries
(
    LogEntryID bigint NOT NULL
        CONSTRAINT PK_DataLoad_LogEntries PRIMARY KEY
        CONSTRAINT DF_DataLoad_LogEntries_LogEntryID
            DEFAULT (NEXT VALUE FOR DataLoad.LogEntryID),
    LogEntryDateTime datetime2(3) NOT NULL
        CONSTRAINT DF_DataLoad_LogEntries_LogEntryDateTime
            DEFAULT (CAST(SYSDATETIMEOFFSET() AT TIME ZONE 'AUS Eastern Standard Time' AS datetime2(3))),
    ProcedureName sysname NULL,
    Details varchar(1000) NULL
);
GO
