#' flick_csv_folder
#'
#' Load any folder of  CSV files to a SQL table in the specified schema of the
#' database / server specified in the ODBC connector. All files must be the same structure
#'
#' The table name assigned is the file name. of the first file loaded. The file names are also
#' written to the table
#' An ODBC connector must be setup, and the schema that is  passed to the schema
#' parameter must exist in the destination database
#' @export
#' @import DBI
#' @import odbc
#' @import utils
#' @param folder Path to the folder of files you want to load
#' @param odbc ODBC connector containing destination database details
#' @param tablename Table in the destination database that you want to load the data to
#' @param schema Schema in the destination database that you want to load the data to

flick_csv_folder  <- function(folder, odbc, tablename, schema) {
  files_in_folder <- as.data.frame(list.files(folder))
  path1 <- paste0(folder,'\\',files_in_folder[1,])
  flick_csv(file_path = path1, odbc = 'localhost', tablename = tablename, overwrite = TRUE, append = FALSE, schema = schema)
  files_in_folder <- files_in_folder[-1,]
  files_in_folder <- as.data.frame(files_in_folder)
  files_in_folder$folder <- folder
  files_in_folder$path <- paste0(files_in_folder$folder, '\\', files_in_folder$files_in_folder)
  files_to_load <- as.data.frame(files_in_folder$path)
  for (i in 1:nrow(files_to_load)) {
    print('File Started')
    flick_csv(file_path = files_to_load[i,], odbc = 'localhost', tablename = tablename, schema = schema, overwrite = FALSE, append = TRUE)
    #paste0('File Load Done. ', files_to_load[i,], ' loaded successfully')
  }
    file_cnt <- nrow(files_to_load) + 1
    print(file_cnt, 'files loaded successfully.')
}
