create or alter function addTwoNumber(@num1 int , @num2 int)
Returns int
Begin
	return (@num1 + @num2)
End


select dbo.addTwoNumber(1,2);



select * from employee


create or alter function employeesINCityAndGender(@city varchar(100), @gender varchar(100))
Returns Table
AS
	
	return (select * from employee where city = @city and gender = @gender)
	
	
GO

select * from dbo.employeesINCityAndGender('Boto' , 'male')




create or alter function searchInEmail(@search varchar(100))
Returns Table
AS
	
	return (
		select * from employee 
		where (
					city like CONCAT('%',@search,'%') 
					or CONCAT(first_name,' ' , last_name) like CONCAT('%',@search,'%')
					or gender like CONCAT('%',@search,'%')
					or department like CONCAT('%',@search,'%')
			  )
	)


	
GO

DECLARE @query1 nvarchar(100) = 'select * from employee';


EXEC sp_executesql @query1;

DECLARE @test1 nvarchar(50) = 'ibrahim';

select @test1 
Go

CREATE OR ALTER PROCEDURE employeeListTest @id varchar(max)
As 
BEGIN

    DECLARE @query1 nvarchar(max) = 'SELECT * FROM employee where id = ' + @id;
    
    EXEC sp_executesql @query1;
END

GO;
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

EXEC employeeList @search = null,@city=null , @gender=null , @department='Sales';






