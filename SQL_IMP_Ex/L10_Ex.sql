----------------------------------------------------------------------------------------------------------------
--Create Function
----------------------------------------------------------------------------------------------------------------
use ClassNorthwind
Go
Alter function fn_TaxRate
(@ProductID int)
Returns numeric(3,2)
Begin
Return
(
SELECT 
   --ProductID, CategoryID,
   CASE CategoryID 
      WHEN 1 THEN 1.10
      WHEN 2 THEN 1
      WHEN 3 THEN 1.10
      WHEN 4 THEN 1.05
      WHEN 5 THEN 1
      WHEN 6 THEN 1.05
      WHEN 7 THEN 1
      WHEN 8 THEN 1.05
   END --AS TaxRate
FROM Products  
where ProductID = @ProductID
)
End
Go
----------------------------------------------------------------------------------------------------------------
--Use Function
----------------------------------------------------------------------------------------------------------------
use ClassNorthwind
Go

select *, [dbo].[fn_TaxRate](ProductID) as TaxRate from Products
----------------------------------------------------------------------------------------------------------------
--Muti-Statement Table-values Function
----------------------------------------------------------------------------------------------------------------
USE ClassNorthwind
GO

/*
**  As a multi-statement table-valued user-defined
**  function it starts with the function name,
**  input parameter definition and defines the output
**  table.
*/
Alter FUNCTION fn_FindReports (@InEmployeeID char(5))
RETURNS @reports TABLE
		(EmployeeID char(5) PRIMARY KEY,
		Name nvarchar(40) NOT NULL,
		Title nvarchar(30),
		MgrEmployeeID int,
		processed tinyint default 0)

-- Returns a result set that lists all the employees who 
-- report to a given employee directly or indirectly

AS
BEGIN
	DECLARE @RowsAdded int

	-- Initialize @reports with direct reports of the given employee
	INSERT @reports
		SELECT EmployeeID, Name = FirstName + ' ' + LastName, Title, ReportsTo, 1
		FROM EMPLOYEES
		WHERE ReportsTo = @InEmployeeID

	SET @RowsAdded = @@rowcount

	-- While new employees were added in the previous iteration
	WHILE @RowsAdded > 0
	BEGIN
		-- Mark all employee records whose direct reports are going to be
		-- found in this iteration
		--UPDATE @reports
		--SET processed = 1
		--WHERE processed = 0
		
		-- Insert employees who report to employees marked 1
		INSERT @reports
			SELECT e.EmployeeID, Name = FirstName + ' ' + LastName , e.Title, e.ReportsTo, 1
			FROM employees e
			Join @reports r
			on  e.ReportsTo = r.EmployeeID
			AND r.processed = 1

		SET @RowsAdded = @@rowcount

		-- Mark all employee records whose direct reports had been
		-- found in this iteration
		UPDATE @reports
		SET processed = 2
		WHERE processed = 1
	END

RETURN -- Provides the value of @reports as the result
END
GO

select * from fn_FindReports(2)
----------------------------------------------------------------------------------------------------------------
--In-line Table-values Function
----------------------------------------------------------------------------------------------------------------
use ClassNorthwind
Go

Create Function fn_LargeFreight
(@FreightAmt money)
Returns Table
as
return
(
SELECT S.ShipperID, S.CompanyName,
   O.OrderID, O.ShippedDate, O.Freight
FROM Shippers AS S JOIN Orders AS O
   ON S.ShipperID = O.ShipVia
WHERE O.Freight > @FreightAmt
)
Go

select * from fn_LargeFreight (500)
----------------------------------------------------------------------------------------------------------------