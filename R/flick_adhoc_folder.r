# flick_adhoc_folder
#
# Load any folder of CSV files to a SQL table in the stage schema of the
# requested database / server.
#
# The table name assigned is the file name.
#

flick_adhoc_folder  <- function(path, overwrite, append, odbc) {
  folder <- ''
  files_in_folder <- as.data.frame(list.files(folder))
  file_path <- pasto0(folder, files_in_folder)
  df <- read.csv(file_path)
  file_name_path <- strsplit(file_path, split = '\\', fixed = TRUE)
  file_name <- tail(file_name_path[[1]], 1)
  file_name <- gsub(".csv", "", file_name)
  df$file_name <- file_name
  con <- dbConnect(odbc(), odbc)
  #  con <- dbConnect(odbc::odbc(), Driver = 'SQL Server', Server = server, Database = database)
  options(scipen=999)
  dbWriteTable(con, Id(schema = "stage", table = file_name), df, overwrite = overwrite, append = append)
  dbGetQuery
}
