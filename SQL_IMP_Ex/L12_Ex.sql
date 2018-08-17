----------------------------------------------------------------------------------------------------------------
--Starts a transaction to read the record of 
--customer Great Lakes Food Market and update the contact name. 
--Second select shows the uncommitted update. 
--@@trancount shows the number of open transactions.
----------------------------------------------------------------------------------------------------------------
USE ClassNorthwind

BEGIN TRAN
  PRINT 'trancount value:'
  SELECT @@trancount
  PRINT 'Before update:'
  SELECT ContactName FROM Customers WHERE CustomerID = 'GREAL'
  UPDATE Customers SET ContactName = 'Howard Snyder_Updated' WHERE CustomerID ='GREAL'
  PRINT 'After update:'
  SELECT ContactName FROM Customers WHERE CustomerID = 'GREAL'
  PRINT 'trancount value:'
  SELECT @@trancount
--COMMIT TRANSACTION
Rollback

SELECT ContactName FROM Customers WHERE CustomerID = 'GREAL'
----------------------------------------------------------------------------------------------------------------
--Set Transaction Isolation Level
-- 1. Read Uncommitted
-- 2. Read Committed
-- 3. Repeatable Read
-- 4. Serializable
-- 5. Snapshot

--alter database [db_name]
--set allow_snapshot_isolation on
----------------------------------------------------------------------------------------------------------------
Set transaction isolation level read committed

SELECT ContactName FROM Customers WHERE CustomerID = 'GREAL'
----------------------------------------------------------------------------------------------------------------
--查詢鎖定情形
----------------------------------------------------------------------------------------------------------------
exec sp_lock
----------------------------------------------------------------------------------------------------------------
--Set Lock Timeout
----------------------------------------------------------------------------------------------------------------
set lock_timeout 3000
----------------------------------------------------------------------------------------------------------------
--Cancel Lock Timeout
----------------------------------------------------------------------------------------------------------------
set lock_timeout -1
----------------------------------------------------------------------------------------------------------------