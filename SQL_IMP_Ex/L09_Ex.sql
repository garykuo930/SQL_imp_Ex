----------------------------------------------------------------------------------------------------------------------------------------
--ミStored Procedures
----------------------------------------------------------------------------------------------------------------------------------------
--礚把计SP(繰篈よ猭)
----------------------------------------------------------------------------------------------------------------------------------------
use ClassNorthwind
Go
Create proc FiveMostExpensiveProducts 
as
select Top 5 ProductName,UnitPrice
from Products
Order by UnitPrice Desc
Go

exec FiveMostExpensiveProducts

exec sp_helptext FiveMostExpensiveProducts
----------------------------------------------------------------------------------------------------------------
--Τ把计SP
----------------------------------------------------------------------------------------------------------------
use ClassNorthwind
Go
create proc UpdateEmpPhone
@NewNumber nvarchar(24),@Who int
as
update [dbo].[Employees]
set [HomePhone] = @NewNumber
where [EmployeeID] = @Who
Go

exec UpdateEmpPhone '(02) 22345678',1		 --沮把计竚

exec UpdateEmpPhone										  	 --沮跑计嘿
	@NewNumber = '(206) 555-9857',
	@Who = 1

select * from [dbo].[Employees]
----------------------------------------------------------------------------------------------------------------
--岿粇癟
----------------------------------------------------------------------------------------------------------------
exec sp_addmessage 50001,10,'Update Complete',English,true,replace
exec sp_addmessage 50001,10,'эЧΘ',羉砰いゅ,true,replace

SELECT @@LANGUAGE AS 'Language Name';  

select * from [sys].[sysmessages]
order by error
Go
----------------------------------------------------------------------------------------------------------------
--SPいRaiserror粂猭
----------------------------------------------------------------------------------------------------------------
ALTER proc [dbo].[UpdateEmpPhone]
@NewNumber nvarchar(24),@Who int
as
update [dbo].[Employees]
set [HomePhone] = @NewNumber
where [EmployeeID] = @Who
raiserror (50001,11,1)  --Raiserror粂猭
GO
----------------------------------------------------------------------------------------------------------------
--Executing Extended Stored Procedures
--Example
--This example executes a command that displays a list of files and 
--subdirectories.
----------------------------------------------------------------------------------------------------------------
sp_configure 'show advanced options', 1
RECONFIGURE
sp_configure 'xp_cmdshell', 1
RECONFIGURE
EXEC master..xp_cmdshell 'dir c:\'
GO
----------------------------------------------------------------------------------------------------------------