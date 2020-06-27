CREATE OR ALTER VIEW Analytics.[Staff Member]
AS
SELECT StaffMemberKey,
       LogonName AS [Logon Name],
       StaffMember AS [Staff Member],
       IsSalesperson AS [Is Salesperson]
FROM DataModel.StaffMembers;
GO
