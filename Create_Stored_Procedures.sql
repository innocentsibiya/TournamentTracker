--Please note that this file is for creating the stored procedures used in the application logic

--Stored procedure dbo.spPrizes_Insert which stores the tournaments prizes



CREATE PROCEDURE dbo.spPrizes_Insert
	@PlaceNumber int,
	@PlaceName nvarchar(50),
	@PrizeAmount money,
	@PrizePercentage float,
	@Id int = 0 output

AS
BEGIN

	SET NOCOUNT ON;

    insert into dbo.Prizes (PlaceNumber,PlaceName,PrizeAmount,PrizePercentage)
	values (@PlaceNumber,@PlaceName,@PrizeAmount,@PrizePercentage);

	select @Id = SCOPE_IDENTITY();

END
GO



--Stored procedure dbo.spPeople_Insert which stores the tournaments people




CREATE PROCEDURE dbo.spPeople_Insert
     @FirstName nvarchar(100),
	 @LastName nvarchar(100),
	 @EmailAddress nvarchar(100),
	 @CellphoneNumber varchar(20),
	 @Id int = 0 output

AS
BEGIN

	SET NOCOUNT ON;

    insert into dbo.People(FirstName,LastName,EmailAddress,CellphoneNumber)
	values (@FirstName,@LastName,@EmailAddress,@CellphoneNumber);

	select @Id = SCOPE_IDENTITY();
END
GO



--Stored procedure dbo.spPeople_GetAll which returns all the people



CREATE PROCEDURE dbo.spPeople_GetAll
AS
BEGIN
	select *
	  from dbo.People;
END
GO



--Stored procedure dbo.spTeam_Insert which stores the tournaments teams



CREATE PROCEDURE dbo.spTeam_Insert
	@TeamName nvarchar(100),
	@Id int = 0 output
AS
BEGIN
	insert into dbo.Teams(TeamName)
	values (@TeamName);

	select @Id = SCOPE_IDENTITY();
END
GO



--Stored procedure dbo.spTeam_Insert which stores the team Members



CREATE PROCEDURE dbo.spTeamMembers_Insert
	@TeamId int,
	@PersonId int,
	@Id int = 0 output
AS
BEGIN
	insert into dbo.TeamMembers(TeamId,PersonId)
	values (@TeamId,@PersonId);

	select @Id = SCOPE_IDENTITY();
END
GO
