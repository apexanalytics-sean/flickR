USE [MacAnalyticsDev]
GO

/****** Object:  Table [dbo].[sample_file]    Script Date: 07/09/2022 15:08:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE auxiliary.input_file_status (
	id int not null,
	file_status int,
	[description] [varchar](255) NOT NULL,
	[type_code_used] [varchar](5) NOT NULL
	PRIMARY KEY (id)
) ON [PRIMARY]
GO