use ClassNorthwind
Go
Create proc usp_updateshippeddate
@newdate datetime,@id int
as
update [dbo].[Orders]
set [ShippedDate] = @newdate
where [OrderID] = @id
Go

exec usp_updateshippeddate [1996-08-16],10248

select top 10 * from [dbo].[Orders]