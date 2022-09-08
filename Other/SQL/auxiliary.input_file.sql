USE [MacAnalyticsDev]
GO

/****** Object:  Table [dbo].[sample_file]    Script Date: 07/09/2022 15:08:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE auxiliary.input_file (
	id int not null,
	file_type_code [varchar](255) NOT NULL,
	file_status int,
	file_hash [varchar](255) NOT NULL,
	[date_added] DATETIME NOT NULL DEFAULT (GETDATE()),
	[date_loaded] DATETIME, 
	[message] [varchar](255),
	[type_code_used] [varchar](5) NOT NULL
	PRIMARY KEY (id)
) ON [PRIMARY]
GO



