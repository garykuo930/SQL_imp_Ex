select * from [dbo].[Employees]
select * from [dbo].[EmployeeTerritories]
exec sp_helpconstraint '[dbo].[EmployeeTerritories]'

use ClassNorthwind

alter table [dbo].[Employees]
add constraint PK_Employees
	Primary key nonclustered (EmployeeID)

alter table [dbo].[EmployeeTerritories]
add constraint FK_EmployeeTerritories
	foreign key ([EmployeeID])
	references [dbo].[Employees]([EmployeeID])
	on update cascade

update [dbo].[Employees] set EmployeeID = 11 where EmployeeID = 1