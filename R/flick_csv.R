#' flick_csv
#'
#' Load any single CSV file to a SQL table in the specified schema of the
#' database / server specified in the ODBC connector.
#'
#' The table name assigned is the file name.
#' An ODBC connector must be setup, and the schema passed to the schema
#' parameter must exist in the destination database
#' @export
#' @import DBI
#' @import odbc
#' @import utils
#' @param file_path Path to the file you want to load
#' @param odbc ODBC connector containing destination database details
#' @param tablename Table in the destination database that you want to load the data to
#' @param schema Schema in the destination database that you want to load the data to
#' @param overwrite Overwrite existing table
#' @param append Append data to table

flick_csv  <- function(file_path, odbc, tablename, schema, overwrite, append) {
  df <- read.csv(file_path)
  file_name_path <- strsplit(file_path, split = '\\', fixed = TRUE)
  file_name <- tail(file_name_path[[1]], 1)
  file_name <- gsub(".csv", "", file_name)
  df$file_name <- file_name
  con <- dbConnect(odbc(), odbc)
  options(scipen=999)
  dbWriteTable(con, Id(schema = schema, table = tablename), df, overwrite = overwrite, append = append)
  rows <- dbGetQuery(con, statement = paste0("select count(*) from", schema,'.', tablename, '')) ## want to query the number of records that were loaded and to what table / DB / Server
  confmsg  <- paste0(file_name, ' File Loaded Successfully. ', rows, ' rows have been loaded to the ', schema, '.', tablename, ' using the ', odbc, ' ODBC connector')
  print(confmsg)
  dbDisconnect(con)
}
