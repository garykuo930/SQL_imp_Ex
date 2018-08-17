----------------------------------------------------------------------------------------------------------------
--Create Insert Trigger
----------------------------------------------------------------------------------------------------------------
use ClassNorthwind
Go

alter TRIGGER OrdDet_Insert
ON [Order Details]
FOR INSERT
AS
UPDATE P SET 
UnitsInStock = (P.UnitsInStock - I.Quantity)
FROM Products AS P INNER JOIN inserted AS I
ON P.ProductID = I.ProductID
GO

create Trigger OrdDet_Delete
on [dbo].[Order Details]
for delete
as
update Products set
UnitsInStock = Products.UnitsInStock+deleted.Quantity
from Products
join deleted
on Products.ProductID = deleted.ProductID
Go
----------------------------------------------------------------------------------------------------------------
--Testing Trigger
----------------------------------------------------------------------------------------------------------------
SELECT * FROM Products WHERE ProductID = 22

INSERT [Order Details]
(OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (11077, 22, 21.00, 50, 0.0)
GO

delete [Order Details] where OrderID = 11077
Go
----------------------------------------------------------------------------------------------------------------
--Create Delete Trigger
----------------------------------------------------------------------------------------------------------------
CREATE TRIGGER Category_Delete
   ON NewCategories
   FOR DELETE
AS
   UPDATE P SET Discontinued = 1
   FROM NewProducts AS P INNER JOIN Deleted AS d
   ON P.CategoryID = D.CategoryID
----------------------------------------------------------------------------------------------------------------
--Testing Trigger
----------------------------------------------------------------------------------------------------------------
select * from [dbo].[NewProducts] where categoryID = 7

delete [dbo].[NewCategories] where categoryID = 7
----------------------------------------------------------------------------------------------------------------
--Create Update Trigger for Union Views
----------------------------------------------------------------------------------------------------------------
Alter TRIGGER Customers_Update2
ON CustomersView
INSTEAD OF UPDATE AS
DECLARE @Country nvarchar(15)
SET @Country = (SELECT Country FROM Inserted)
IF @Country = 'Germany'
  BEGIN 
   UPDATE CustomersGer
    SET CustomersGer.Phone = Inserted.Phone
    FROM CustomersGer JOIN Inserted 
    ON CustomersGer.CustomerID = Inserted.CustomerID
  END
ELSE 
  IF @Country = 'Mexico' 
  BEGIN
   UPDATE CustomersMex
    SET CustomersMex.Phone = Inserted.Phone
    FROM CustomersMex JOIN Inserted 
    ON CustomersMex.CustomerID = Inserted.CustomerID
  END
----------------------------------------------------------------------------------------------------------------
--Testing Trigger
----------------------------------------------------------------------------------------------------------------
  update [dbo].[CustomersView]
  set Phone = '12346578'
  where CustomerID = 'ALFKI'

  select * from CustomersView
  ----------------------------------------------------------------------------------------------------------------