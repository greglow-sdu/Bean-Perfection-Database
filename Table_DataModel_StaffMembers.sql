DROP TABLE IF EXISTS DataModel.StaffMembers;
GO

CREATE TABLE DataModel.StaffMembers
(
    StaffMemberKey int NOT NULL
        CONSTRAINT PK_DataModel_StaffMembers PRIMARY KEY
        CONSTRAINT DF_DataModel_StaffMembers_StaffMemberKey 
            DEFAULT (NEXT VALUE FOR DataModel.StaffMemberKey),
    LogonName nvarchar(8) NOT NULL,
    StaffMemberName nvarchar(30) NOT NULL,
    IsSalesperson bit NOT NULL
);
GO
