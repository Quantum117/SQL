use lesson12 ;

----Write an SQL query to retrieve the database name, schema name, table name, column name, and column data type
----for all tables across all databases in a SQL Server instance. 
----Ensure that system databases (master, tempdb, model, msdb) are excluded from the results.


---- Getting names of all the databases on sql server
drop table if exists db_names;
Create table db_names (
   name varchar(max) )
insert into db_names 
	select name from sys.databases
	where name not in ('master','tempdb','model','msdb');

---- using dynamic sql to retrieve metadata
declare @query1 varchar(max) ='
select 
   TABLE_CATALOG as Database_name,
   TABLE_SCHEMA as Schema_name,
   TABLE_NAME as table_name,
   COLUMN_NAME ,
   concat(
			DATA_TYPE,''(''+ 
				case when cast(CHARACTER_MAXIMUM_LENGTH as varchar) = ''-1''
				then ''max''
				else cast(CHARACTER_MAXIMUM_LENGTH as varchar) end
			+'')''
		) as DataType

from '
declare @query2 varchar(max) ='
.INFORMATION_SCHEMA.COLUMNS;'
DECLARE @name NVARCHAR(255);
DECLARE @row INT = 1;
DECLARE @rowCount INT;

-- Temporary table with an identity column for iteration
SELECT name, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS row_num 
INTO #TempNames
FROM db_names;

-- Get total row count
SELECT @rowCount = COUNT(*) FROM #TempNames;

-- Loop through each row
WHILE @row <= @rowCount
BEGIN
    -- Get name for the current row
    SELECT @name = name FROM #TempNames WHERE row_num = @row;
    
	DECLARE @finalQuery NVARCHAR(MAX);
	SET @finalQuery = @query1 + @name + @query2;
    exec(@finalQuery)
    
    SET @row = @row + 1; -- Move to the next row
END;

-- Clean up
DROP TABLE #TempNames;

---- Task2 
go
CREATE PROCEDURE GetProceduresAndFunctions
    @db_name SYSNAME = NULL -- Optional parameter (NULL means all databases)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @sql NVARCHAR(MAX);

    -- Build dynamic SQL
    SET @sql = N'
    DECLARE @Results TABLE (
        DatabaseName SYSNAME,
        SchemaName SYSNAME,
        ObjectName SYSNAME,
        ObjectType NVARCHAR(20),
        ParameterName SYSNAME,
        DataType NVARCHAR(50),
        MaxLength INT
    );

    -- Cursor to loop through all databases if @db_name is NULL
    DECLARE @CurrentDB SYSNAME;
    DECLARE db_cursor CURSOR FOR
    SELECT name FROM sys.databases 
    WHERE state_desc = ''ONLINE'' ' + 
    CASE WHEN @db_name IS NOT NULL THEN ' AND name = QUOTENAME(@db_name)' ELSE '' END + 
    N';

    OPEN db_cursor;
    FETCH NEXT FROM db_cursor INTO @CurrentDB;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE @query NVARCHAR(MAX);

        SET @query = N''INSERT INTO @Results
        SELECT 
            '''''' + @CurrentDB + N'''''' AS DatabaseName,
            s.name AS SchemaName,
            o.name AS ObjectName,
            CASE WHEN o.type IN (''P'', ''PC'') THEN ''Procedure'' ELSE ''Function'' END AS ObjectType,
            p.name AS ParameterName,
            t.name AS DataType,
            p.max_length AS MaxLength
        FROM ' + QUOTENAME(@CurrentDB) + N'.sys.objects o
        JOIN ' + QUOTENAME(@CurrentDB) + N'.sys.schemas s ON o.schema_id = s.schema_id
        LEFT JOIN ' + QUOTENAME(@CurrentDB) + N'.sys.parameters p ON o.object_id = p.object_id
        LEFT JOIN ' + QUOTENAME(@CurrentDB) + N'.sys.types t ON p.system_type_id = t.system_type_id
        WHERE o.type IN (''P'', ''PC'', ''FN'', ''IF'', ''TF'')'';';

        -- Execute dynamic SQL for each database
        EXEC sp_executesql @query;

        FETCH NEXT FROM db_cursor INTO @CurrentDB;
    END;

    CLOSE db_cursor;
    DEALLOCATE db_cursor;

    -- Select final results
    SELECT * FROM @Results;
    ';

    -- Execute the final query
    EXEC sp_executesql @sql, N'@db_name SYSNAME', @db_name;
END;
