use Northwind
execute sp_help [Categories]

select USER_NAME() as '使用者名稱'										--預設帶出USER_NAME(1)
select SUSER_NAME() as '登入者名稱'									--預設帶出SUSER_NAME(1)
select * from sys.sysusers															--使用者清單
select * from INFORMATION_SCHEMA.TABLES					--顯示資料庫中所有資料表