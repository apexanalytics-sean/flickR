# flick_adhoc_csv
#
# Load any CSV file to a SQL table in the stage schema of the
# requested database / server.
#
# The table name assigned is the file name.
#
#path <- 'C:\\Users\\SeanMcNally\\OneDrive - MacAnalytics Limited\\Documents\\Workspaces\\flickR\\sample_file.csv'

overwrite = FALSE
append = FALSE

flick_adhoc_csv  <- function(path, overwrite, append, odbc) {
df <- read.csv(path)
file_name_path <- strsplit(path, split = '\\', fixed = TRUE)
file_name <- tail(file_name_path[[1]], 1)
file_name <- gsub(".csv", "", file_name)
df$file_name <- file_name
odbc <- 'localhost'
con <- dbConnect(odbc(), odbc)
options(scipen=999)
dbWriteTable(con, Id(schema = "stage", table = file_name), df, overwrite = overwrite, append = append)
rows <- dbGetQuery(con, statement = paste0("select count(*) from stage.", file_name, '')) ## want to query the number of records that were loaded and to what table / DB / Server
confmsg  <- paste0('File Loaded Successfully. ', rows, ' rows were loaded to the stage.', file_name, ' using the ', odbc, ' ODBC connector')
print(confmsg)
}
