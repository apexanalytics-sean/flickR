USE [MacAnalyticsDev]
GO

/****** Object:  Table [dbo].[sample_file]    Script Date: 07/09/2022 15:08:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE auxiliary.input_file (
	id int,
	file_type_code [varchar](255),
	file_path [varchar](255),
	file_status int,
	file_hash [varchar](255),
	[date_added] DATETIME,
	[date_loaded] DATETIME, 
	[destination_table] [varchar](255),
	[message] [varchar](255),
	[type_code_used] [varchar](5)
	PRIMARY KEY (id)
) ON [PRIMARY]
GO



