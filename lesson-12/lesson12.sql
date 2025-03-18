use lesson12;

---- Programmable objects 

-- declaring variable 
--- declare @variable_name type = value
begin
declare @var int = 112
print @var
end

declare @num int =1
while @num <1000
begin
   print @num
   set @num = @num*2
end
--------
select *from INFORMATION_SCHEMA.TABLES
Create table db_names (
   name varchar(max) )
insert into db_names 
	select name from sys.databases
	where name not in ('master','tempdb','model','msdb');
select 
   TABLE_CATALOG as Database_name,
   TABLE_SCHEMA as Schema_name,
   TABLE_NAME as table_name,
   COLUMN_NAME ,
   DATA_TYPE

from TSQLV6.INFORMATION_SCHEMA.COLUMNS