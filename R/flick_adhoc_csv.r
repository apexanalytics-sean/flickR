# flick_adhoc_csv
#
# Load any CSV file to a SQL table in the stage schema of the
# requested database / server.
#
# The table name assigned is the file name.
#

flick_adhoc_csv  <- function(path, overwrite, append, odbc) {
odbc <- 'localhost'
df <- read.csv(path)
file_name_path <- strsplit(path, split = '\\', fixed = TRUE)
file_name <- tail(file_name_path[[1]], 1)
file_name <- gsub(".csv", "", file_name)
df$file_name <- file_name
con <- dbConnect(odbc(), odbc)
options(scipen=999)
dbWriteTable(con, Id(schema = "stage", table = file_name), df, overwrite = overwrite, append = append)
rows <- dbGetQuery(con, statement = paste0("select * from ", file_name, '')) ## want to query the number of records that were loaded and to what table / DB / Server
msg  <- paste0('File Loaded Successfully. ', rows, ' rows were loaded to the ', file_name, ' table to the ', database, ' database on the ', server, ' server.')
 }
