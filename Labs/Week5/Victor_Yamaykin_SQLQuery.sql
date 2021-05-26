/*
Author  : Victor Yamaykin
Title   : Lab 05
Course  : IST659  M407
Term    : April,  2021
*/ 

-- Drop tables 

DROP TABLE IF EXISTS vc_UserTagList
DROP TABLE IF EXISTS vc_VidCastTagList
DROP TABLE IF EXISTS vc_VidCast
DROP TABLE IF EXISTS vc_Status
DROP TABLE IF EXISTS vc_Tag
DROP TABLE IF EXISTS vc_FollowerList
DROP TABLE IF EXISTS vc_UserLogin
DROP TABLE IF EXISTS vc_User



-- Creating the User table
CREATE TABLE vc_User (
	-- Columns for the User table
	vc_UserID int identity
	, UserName varchar(20) not null
	, EmailAddress varchar(50) not null
	, UserDescription varchar(200)
	, WebSiteURL varchar(50)
	, UserRegisteredDate datetime not null default GetDate()
	, 
	-- Constraints on the User table
	CONSTRAINT PK_vc_User PRIMARY KEY (vc_UserID)
	, CONSTRAINT U1_vc_User UNIQUE(Username)
	, CONSTRAINT U2_vc_User UNIQUE(EmailAddress)
)
-- End Creating the User table

-- Creating the UserLogin table
CREATE TABLE vc_UserLogin (
-- Columns for the UserLogin table
	vc_UserLoginID int identity
	, vc_UserID int not null
	, UserLoginTimestamp datetime not null default GetDate()
	, LoginLOcation varchar(50) not null
	,
	-- Constraints on the User Login table
	CONSTRAINT PK_vc_UserLogin PRIMARY KEY (vc_UserLoginID)
	, CONSTRAINT FK1_vc_UserLogin FOREIGN KEY (vc_UserID) REFERENCES vc_User(vc_UserID)
)
-- End Creating the User Login table

-- Adding Data to the User table
INSERT INTO vc_User(UserName, EmailAddress, UserDescription)
	VALUES 
		('RDwight', 'rdwight@nodomain.xyz', 'Piano Teacher')
		, ('SaulHudson', 'slash@nodomain.xyz', 'I like Les Paul guitars')
		, ('Gordon', 'sumner@nodomain.xyz', 'Former cop')

SELECT * FROM vc_User

-- Creating the FollowerList table
CREATE TABLE vc_FollowerList (
-- Columns for the FollowerList table
	vc_FollowerListID int identity
	, FollowerID int not null
	, FollowedID int not null
	, FollowerSince datetime not null default GetDate()
	, LoginLOcation varchar(50) not null
	,
	-- Constraints on the User Login table
	CONSTRAINT PK_vc_FollowerList PRIMARY KEY (vc_FollowerListID)
	, CONSTRAINT U1_vc_FollowerList UNIQUE (FollowerID, FollowedID)
	, CONSTRAINT FK1_vc_FollowerList FOREIGN KEY (FollowerID) REFERENCES vc_User(vc_UserID)
	, CONSTRAINT FK2_vc_FollowerList FOREIGN KEY (FollowedID) REFERENCES vc_User(vc_UserID)
)
-- End Creating the User Login table

-- Creating the Tag table
CREATE TABLE vc_Tag (
-- Columns for the Tag table
	vc_TagID int identity
	, TagText varchar(20) not null
	, TagDescription varchar(100)
	,
	-- Constraints on the Tag table
	CONSTRAINT PK_vc_Tag PRIMARY KEY (vc_TagID)
	, CONSTRAINT U1_vc_Tag UNIQUE (TagText)
)
-- End Creating the Tag table

-- Creating the Status table 
CREATE TABLE vc_Status (
-- Columns for the Status table
	vc_StatusID int identity
	, StatusText varchar(20)
	,
	-- Constraints on the Status table
	CONSTRAINT PK_vc_Status PRIMARY KEY (vc_StatusID)
	, CONSTRAINT U1_vc_Status UNIQUE (StatusText)
)
-- End Creating the Status table

-- Creating the VidCast table 
CREATE TABLE vc_VidCast (
-- Columns for the VidCast table
	vc_VidCastID int identity
	, VidCastTitle varchar(50) NOT NULL 
	, StartDateTime datetime
	, EndDateTime datetime
	, ScheduledDurationMinutes int
	, RecordingURL varchar(50)
	, vc_UserID int NOT NULL
	, vc_StatusID int NOT NULL
	,
	-- Constraints on the VidCast table
	CONSTRAINT PK_vc_VidCast PRIMARY KEY (vc_VidCastID)
	, CONSTRAINT FK1_vc_VidCast FOREIGN KEY (vc_UserID) REFERENCES vc_User(vc_UserID)
	, CONSTRAINT FK2_vc_VidCast FOREIGN KEY (vc_StatusID) REFERENCES vc_Status(vc_StatusID)

)

-- End Creating the VidCast table

-- Creating the VidCastTagList table 
CREATE TABLE vc_VidCastTagList (
-- Columns for the VidCastTagList table
	vc_VidCastTagListID int identity 
	, vc_TagID int
	, vc_VidCastID int 
	-- Constraints for the VidCastTagList table
	CONSTRAINT PK_vc_VidcastTagList PRIMARY KEY (vc_VidCastTagListID)
	, CONSTRAINT U1_vc_VidcastTagList UNIQUE (vc_TagID, vc_VidCastID)
	, CONSTRAINT FK1_vc_VidcastTagList FOREIGN KEY (vc_TagID) REFERENCES vc_Tag(vc_TagID)
	, CONSTRAINT FK2_vc_VidcastTagList FOREIGN KEY (vc_VidCastID) REFERENCES vc_VidCast(vc_VidCastID)
)
-- End Creating the VidCastTagList table

-- Creating the UserTagList table 
CREATE TABLE vc_UserTagList (
-- Columns for the UserTagList table
	vc_UserTagListID int identity 
	, vc_TagID int
	, vc_UserID int 
	-- Constraints for the UserTagList table
	CONSTRAINT PK_vc_UserTagList PRIMARY KEY (vc_UserTagListID)
	, CONSTRAINT U1_vc_UserTagList UNIQUE (vc_TagID, vc_UserID)
	, CONSTRAINT FK1_vc_UserTagList FOREIGN KEY (vc_TagID) REFERENCES vc_Tag(vc_TagID)
	, CONSTRAINT FK2_vc_UserTagList FOREIGN KEY (vc_UserID) REFERENCES vc_User(vc_UserID)
)
-- End Creating the UserTagList table
