----------------------------------------------------------------------------------------------
--Default ��������GRegion�w�]��'NY'
----------------------------------------------------------------------------------------------
use ClassNorthwind

insert [dbo].[Employees]([LastName],[FirstName]) values ('Kafuu','Chino')

select * from [dbo].[Employees]

exec sp_helpconstraint '[dbo].[Employees]' --�d�߱������
exec sp_help DF_Employees_Region

delete [dbo].[Employees] where EmployeeID = 11

dbcc checkident ('[dbo].[Employees]',reseed,9)

----------------------------------------------------------------------------------------------
--Check ��������G�ͤ� < ������
----------------------------------------------------------------------------------------------
update [dbo].[Employees] set BirthDate = (getdate()+1) where EmployeeID = 10
