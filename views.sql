Create or Alter View QuestionsWithUsers
AS 
	select 
	Top 100
	Posts.Id,
	OwnerUserId,
	Users.DisplayName,
	Posts.CreationDate,
	Body
	from Posts 
	join Users on Users.AccountId = Posts.OwnerUserId
	where PostTypeId = 1
	order by Posts.id DESC
Go

select * from QuestionsWithUsers


