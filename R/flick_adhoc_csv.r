# flick_adhoc_csv
#
# Load any CSV file to a SQL table in the stage schema of the
# requested database / server.
#
# The table name assigned is the file name.
#' @export
#' @param path Path to the file you want to load
#' @param odbc ODBC connector containing destination database details
#' @param overwrite Overwrite existing table
#' @param append Append data to table
flick_adhoc_csv  <- function(file_path, odbc, overwrite, append) {
  df <- read.csv(file_path)
  file_name_path <- strsplit(file_path, split = '\\', fixed = TRUE)
  file_name <- tail(file_name_path[[1]], 1)
  file_name <- gsub(".csv", "", file_name)
  df$file_name <- file_name
  #odbc <- 'localhost'
  con <- dbConnect(odbc(), odbc)
  options(scipen=999)
  dbWriteTable(con, Id(schema = "stage", table = file_name), df, overwrite = overwrite, append = append)
  rows <- dbGetQuery(con, statement = paste0("select count(*) from stage.", file_name, '')) ## want to query the number of records that were loaded and to what table / DB / Server
  confmsg  <- paste0('File Loaded Successfully. ', rows, ' rows were loaded to the stage.', file_name, ' using the ', odbc, ' ODBC connector')
  print(confmsg)
  dbDisconnect(con)
}
