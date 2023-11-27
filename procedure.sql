
CREATE OR ALTER PROCEDURE employeeList

    @search nvarchar(max),
    @city nvarchar(max),
    @gender nvarchar(max),
    @department nvarchar(max)

AS
BEGIN
    DECLARE @s nvarchar(max) = ' 1 = 1';
    
    IF @search IS NOT NULL
    BEGIN
    SET @s = @s + N' and (
        city LIKE ''%'+@search+'%''
        OR CONCAT(first_name, '' '', last_name) LIKE ''%'+@search+'%''
        OR gender LIKE ''%'+@search+'%''
        OR department LIKE ''%'+@search+'%''
    )';
    
    END;
    IF @city IS NOT NULL
    BEGIN
        SET @s = @s + N' and city = ''' + @city + '''';
    END;
    
    IF @department IS NOT NULL
    BEGIN
        SET @s = @s + N' and department = ''' + @department + '''';
    END;
    
    IF @gender IS NOT NULL
    BEGIN
        SET @s = @s + N' and gender = ''' + @gender + '''';
    END;
    
    DECLARE @query1 nvarchar(max) = 'SELECT * FROM employee WHERE ' + @s;
    --select @query1  as q
    EXEC sp_executesql @query1;
END;

EXEC employeeList @search = null,@city='Stockholm' , @gender=null , @department=null;

GO

create or alter procedure getEmployeeCountInEveryCity
as 
Begin
	select e.city , count(e.id) as c
	from employee e
	group by city 
	order by c desc
End ;
GO

exec getEmployeeCountInEveryCity