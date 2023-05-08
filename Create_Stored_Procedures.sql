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


--Stored procedure dbo.spTeam_GetAll which get all the tournament team Members


CREATE PROCEDURE dbo.spTeam_GetAll

AS
BEGIN
	select *
	   from dbo.Teams;
END
GO

--Stored procedure dbo.spTeamMembers_GetByTeam get the team members for the passed in team Id


CREATE PROCEDURE dbo.spTeamMembers_GetByTeam
	@TeamId int
AS
BEGIN

	select p.*
	  from dbo.TeamMembers m
	  inner join dbo.People p on m.PersonId = p.Id
	  where m.TeamId = @TeamId;
END
GO

--Stored procedure dbo.spTournaments_Insert which stores the tournaments



CREATE PROCEDURE dbo.spTournaments_Insert
	@TournamentName nvarchar(200),
	@EntryFee money
AS
BEGIN

	SET NOCOUNT ON;

    insert into dbo.Tournaments(TournamentName, EntryFee, Active)
	values (@TournamentName,@EntryFee,1);
END
GO

--altered dbo.spTournaments_Insert to include Id


ALTER PROCEDURE dbo.spTournaments_Insert
	@TournamentName nvarchar(200),
	@EntryFee money,
	@Id int = 0 output
AS
BEGIN

	SET NOCOUNT ON;

    insert into dbo.Tournaments(TournamentName, EntryFee, Active)
	values (@TournamentName,@EntryFee,1);

	select @Id = SCOPE_IDENTITY();
END
GO


--Stored procedure dbo.spTournamentPrizes_Insert which stores the tournament prizes


CREATE PROCEDURE dbo.spTournamentPrizes_Insert
@TournamentId int,
@PrizeId int,
@Id int = 0 output
AS
BEGIN

	SET NOCOUNT ON;

    insert into dbo.TournamentPrizes(TournamentId,PrizeId)
	values(@TournamentId,@PrizeId);

	select @Id = SCOPE_IDENTITY();
END
GO



--Stored procedure dbo.spTournamentPrizes_Insert which stores the tournament entries



CREATE PROCEDURE dbo.spTournamentEntries_Insert
@TournamentId int,
@TeamId int,
@Id int = 0 output
AS
BEGIN

	SET NOCOUNT ON;

    insert into dbo.TournamentEntries(TournamentId,TeamId)
	values(@TournamentId,@TeamId);

	select @Id = SCOPE_IDENTITY();
END
GO



--Stored procedure dbo.spMatchups_Insert which stores the tournament matchups



CREATE PROCEDURE dbo.spMatchups_Insert
@TournamentId int,
@MatchupRound int,
@Id int = 0 output
AS
BEGIN

	SET NOCOUNT ON;

    insert into dbo.Matchups(TournamentId,MatchupRound)
	values(@TournamentId,@MatchupRound);

	select @Id = SCOPE_IDENTITY();
END
GO



--Stored procedure dbo.spMatchupEntries_Insert which stores the tournament matchup entries


CREATE PROCEDURE dbo.spMatchupEntries_Insert
@MatchupId int,
@ParentMatchupId int,
@TeamCompetingId int,
@Id int = 0 output
AS
BEGIN

	SET NOCOUNT ON;

    insert into dbo.MatchupEntries(MatchupId,ParentMatchupId,TeamCompetingId)
	values(@MatchupId,@ParentMatchupId,@TeamCompetingId);

	select @Id = SCOPE_IDENTITY();
END
GO
