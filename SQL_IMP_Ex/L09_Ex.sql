----------------------------------------------------------------------------------------------------------------------------------------
--�إ�Stored Procedures
----------------------------------------------------------------------------------------------------------------------------------------
--�L�Ѽƪ�SP(�R�A��k)
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
--���Ѽƪ�SP
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

exec UpdateEmpPhone '(02) 22345678',1		 --�ھڰѼƦ�m

exec UpdateEmpPhone										  	 --�ھ��ܼƦW��
	@NewNumber = '(206) 555-9857',
	@Who = 1

select * from [dbo].[Employees]
----------------------------------------------------------------------------------------------------------------
--�[�J���~�T��
----------------------------------------------------------------------------------------------------------------
exec sp_addmessage 50001,10,'Update Complete',English,true,replace
exec sp_addmessage 50001,10,'�ק粒��',�c�餤��,true,replace

SELECT @@LANGUAGE AS 'Language Name';  

select * from [sys].[sysmessages]
order by error
Go
----------------------------------------------------------------------------------------------------------------
--�bSP���[�JRaiserror�y�k
----------------------------------------------------------------------------------------------------------------
ALTER proc [dbo].[UpdateEmpPhone]
@NewNumber nvarchar(24),@Who int
as
update [dbo].[Employees]
set [HomePhone] = @NewNumber
where [EmployeeID] = @Who
raiserror (50001,11,1)  --Raiserror�y�k
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