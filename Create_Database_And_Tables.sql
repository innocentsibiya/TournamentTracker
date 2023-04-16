--Please note that this file is for creating the database for our application along with the tables use by it.


--Creating the database for our tournament application
Create Database Tournaments;

--creating tables

--Prize table
USE [Tournaments]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Prizes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PlaceNumber] [int] NOT NULL,
	[PlaceName] [nvarchar](50) NOT NULL,
	[PrizeAmount] [money] NOT NULL,
	[PrizePercentage] [float] NOT NULL,
 CONSTRAINT [PK_Prizes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Prizes] ADD  CONSTRAINT [DF_Prizes_PrizeAmount]  DEFAULT ((0)) FOR [PrizeAmount]
GO

ALTER TABLE [dbo].[Prizes] ADD  CONSTRAINT [DF_Prizes_PrizePercentage]  DEFAULT ((0)) FOR [PrizePercentage]
GO


--People table


USE [Tournaments]
GO

/****** Object:  Table [dbo].[People]    Script Date: 2023/04/15 18:49:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[People](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[EmailAddress] [nvarchar](100) NOT NULL,
	[CellphoneNumber] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_People] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



--Teams table



USE [Tournaments]
GO

/****** Object:  Table [dbo].[Teams]    Script Date: 2023/04/15 18:51:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Teams](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TeamName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Teams] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



--Tournaments table



USE [Tournaments]
GO

/****** Object:  Table [dbo].[Tournaments]    Script Date: 2023/04/15 18:51:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Tournaments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TournamentName] [nvarchar](200) NOT NULL,
	[EntryFee] [money] NOT NULL,
	[Active] [int] NOT NULL,
 CONSTRAINT [PK_Tournaments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



--TournamentPrizes table



USE [Tournaments]
GO

/****** Object:  Table [dbo].[TournamentPrizes]    Script Date: 2023/04/15 18:52:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TournamentPrizes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TournamentId] [int] NOT NULL,
	[PrizeId] [int] NOT NULL,
 CONSTRAINT [PK_TournamentProzes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TournamentPrizes]  WITH CHECK ADD  CONSTRAINT [FK_TournamentPrizes_PrizeId] FOREIGN KEY([PrizeId])
REFERENCES [dbo].[Prizes] ([Id])
GO

ALTER TABLE [dbo].[TournamentPrizes] CHECK CONSTRAINT [FK_TournamentPrizes_PrizeId]
GO

ALTER TABLE [dbo].[TournamentPrizes]  WITH CHECK ADD  CONSTRAINT [FK_TournamentPrizes_TournamentId] FOREIGN KEY([TournamentId])
REFERENCES [dbo].[Tournaments] ([Id])
GO

ALTER TABLE [dbo].[TournamentPrizes] CHECK CONSTRAINT [FK_TournamentPrizes_TournamentId]
GO



--TournamentEntries table



USE [Tournaments]
GO

/****** Object:  Table [dbo].[TournamentEntries]    Script Date: 2023/04/15 18:53:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TournamentEntries](
	[Id] [int] NOT NULL,
	[TournamentId] [int] NOT NULL,
	[TeamId] [int] NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TournamentEntries]  WITH CHECK ADD  CONSTRAINT [FK_TournamentEntries_TeamId] FOREIGN KEY([TeamId])
REFERENCES [dbo].[Teams] ([Id])
GO

ALTER TABLE [dbo].[TournamentEntries] CHECK CONSTRAINT [FK_TournamentEntries_TeamId]
GO

ALTER TABLE [dbo].[TournamentEntries]  WITH CHECK ADD  CONSTRAINT [FK_TournamentEntries_TournamentId] FOREIGN KEY([TournamentId])
REFERENCES [dbo].[Tournaments] ([Id])
GO

ALTER TABLE [dbo].[TournamentEntries] CHECK CONSTRAINT [FK_TournamentEntries_TournamentId]
GO



--TeamMembers table



USE [Tournaments]
GO

/****** Object:  Table [dbo].[TeamMembers]    Script Date: 2023/04/15 18:53:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TeamMembers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TeamId] [int] NOT NULL,
	[PersonId] [int] NOT NULL,
 CONSTRAINT [PK_TeamMembers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TeamMembers]  WITH CHECK ADD  CONSTRAINT [FK_TeamMembers_PersonId] FOREIGN KEY([PersonId])
REFERENCES [dbo].[People] ([Id])
GO

ALTER TABLE [dbo].[TeamMembers] CHECK CONSTRAINT [FK_TeamMembers_PersonId]
GO

ALTER TABLE [dbo].[TeamMembers]  WITH CHECK ADD  CONSTRAINT [FK_TeamMembers_TeamId] FOREIGN KEY([TeamId])
REFERENCES [dbo].[Teams] ([Id])
GO

ALTER TABLE [dbo].[TeamMembers] CHECK CONSTRAINT [FK_TeamMembers_TeamId]
GO



--Matchups table



USE [Tournaments]
GO

/****** Object:  Table [dbo].[Matchups]    Script Date: 2023/04/15 18:54:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Matchups](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TournamentId] [int] NOT NULL,
	[WinnerId] [int] NULL,
	[MatchupRound] [int] NOT NULL,
 CONSTRAINT [PK_Matchups] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Matchups]  WITH CHECK ADD  CONSTRAINT [FK_Matchups_TeamId] FOREIGN KEY([WinnerId])
REFERENCES [dbo].[Teams] ([Id])
GO

ALTER TABLE [dbo].[Matchups] CHECK CONSTRAINT [FK_Matchups_TeamId]
GO

ALTER TABLE [dbo].[Matchups]  WITH CHECK ADD  CONSTRAINT [FK_Matchups_TournamentId] FOREIGN KEY([TournamentId])
REFERENCES [dbo].[Tournaments] ([Id])
GO

ALTER TABLE [dbo].[Matchups] CHECK CONSTRAINT [FK_Matchups_TournamentId]
GO



--MatchupEntries table



USE [Tournaments]
GO

/****** Object:  Table [dbo].[MatchupEntries]    Script Date: 2023/04/15 18:54:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MatchupEntries](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MatchupId] [int] NOT NULL,
	[ParentMatchupId] [int] NULL,
	[TeamCompetingId] [int] NULL,
	[Score] [float] NULL,
 CONSTRAINT [PK_MatchupEntries] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MatchupEntries]  WITH CHECK ADD  CONSTRAINT [FK_MatchupEntries_Matchups] FOREIGN KEY([MatchupId])
REFERENCES [dbo].[Matchups] ([Id])
GO

ALTER TABLE [dbo].[MatchupEntries] CHECK CONSTRAINT [FK_MatchupEntries_Matchups]
GO

ALTER TABLE [dbo].[MatchupEntries]  WITH CHECK ADD  CONSTRAINT [FK_MatchupEntries_ParentMatchupId] FOREIGN KEY([ParentMatchupId])
REFERENCES [dbo].[MatchupEntries] ([Id])
GO

ALTER TABLE [dbo].[MatchupEntries] CHECK CONSTRAINT [FK_MatchupEntries_ParentMatchupId]
GO

ALTER TABLE [dbo].[MatchupEntries]  WITH CHECK ADD  CONSTRAINT [FK_MatchupEntries_Teams] FOREIGN KEY([TeamCompetingId])
REFERENCES [dbo].[Teams] ([Id])
GO

ALTER TABLE [dbo].[MatchupEntries] CHECK CONSTRAINT [FK_MatchupEntries_Teams]
GO



/*End of File*/