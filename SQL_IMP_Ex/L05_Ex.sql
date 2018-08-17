----------------------------------------------------------------------------------------------
--Default 條件約束：Region預設為'NY'
----------------------------------------------------------------------------------------------
use ClassNorthwind

insert [dbo].[Employees]([LastName],[FirstName]) values ('Kafuu','Chino')

select * from [dbo].[Employees]

exec sp_helpconstraint '[dbo].[Employees]' --查詢條件約束
exec sp_help DF_Employees_Region

delete [dbo].[Employees] where EmployeeID = 11

dbcc checkident ('[dbo].[Employees]',reseed,9)

----------------------------------------------------------------------------------------------
--Check 條件約束：生日 < 今日日期
----------------------------------------------------------------------------------------------
update [dbo].[Employees] set BirthDate = (getdate()+1) where EmployeeID = 10
