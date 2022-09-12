#' init_aux_tables
#'
#' Set up the auxiliary metadata tables in the specified
#' database / server specified in the ODBC connector.
#'
#' An ODBC connector must be setup, and the schema passed to the schema
#' parameter must exist in the destination database
#' @export
#' @import DBI
#' @import odbc
#' @import utils
#' @import tools
#' @param odbc ODBC connector containing destination database details

init_aux_tables  <- function(odbc) {
  con <- dbConnect(odbc(), odbc)
  ## do I want to create auxiliary schema if it doesn't exist as well???
print('Creating input_file table')
  dbSendQuery(con, "
CREATE TABLE auxiliary.input_file (
	id int IDENTITY(1,1) PRIMARY KEY,
	file_type_code [varchar](255),
	file_path [varchar](255),
	file_status int,
	file_hash [varchar](255),
	[date_added] DATETIME,
	[date_loaded] DATETIME,
	[destination_table] [varchar](255),
	[message] [varchar](255),
	[type_code_used] [varchar](5)
) ON [PRIMARY]")
print('Creating input_file_status table')
  dbSendQuery(con, "
CREATE TABLE auxiliary.input_file_status (
	id int not null,
	file_status int,
	[description] [varchar](255) NOT NULL,
	[type_code_used] [varchar](5) NOT NULL
	PRIMARY KEY (id)
) ON [PRIMARY]")
print('Creating input_file_type table')
  dbSendQuery(con, "
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
  ) ON [PRIMARY]")
  print(paste0('The 3 auxiliary tables were created successfully using the ', odbc, ' odbc connector connection'))
  dbDisconnect(con)
}
