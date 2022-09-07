USE [MacAnalyticsDev]
GO

/****** Object:  Table [dbo].[sample_file]    Script Date: 07/09/2022 15:08:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE auxiliary.input_file_type(
	file_type_code [varchar](255) NOT NULL,
	file_type_description [varchar](255) NULL,
	[file_name] [varchar](255) NOT NULL,
	[file_path] [varchar](255) NOT NULL,
	[file_loading_function] [varchar](255) NOT NULL,
	[destination_table] [varchar](255) NOT NULL,
	[file_overwrite] [varchar](5) NOT NULL,
	[file_append] [varchar](5) NOT NULL,
	[file_initiaton] [varchar](5) NOT NULL,
	[file_active] [varchar](5) NOT NULL,
	[file_type_date_added] DATETIME NOT NULL DEFAULT (GETDATE())
	PRIMARY KEY (file_type_code)
) ON [PRIMARY]
GO



