#' flash_typecode
#'
#' Check for any waiting files per typecode specified in
#' the input_file_type table and add them to the input_file
#' table
#' @export

flash_typecode  <- function(file_type_code, odbc) {
  ## connect to DB
  con <- dbConnect(odbc(), odbc)
  ## pull folder for typecode from DB table
  path <- dbGetQuery(con, statement = paste0("select [file_path] from auxiliary.input_file_type where file_type_code = '", file_type_code, "'"))
  ## list files in that folder
  files_in_folder <- as.data.frame(list.files(path))
  ## calculate hash of file
  file_hash <- ' '
  ## create df structure so it matches table
  file_status <- 0
  date_added <- Sys.time()
  date_loaded <- NULL
  message <- NULL
  ## id, file_type_code, file_status, file_hash, date_added, date_loaded, message, type_code_used
  flash_df <- cbind.data.frame(file_type_code, file_status, file_hash)

  ## insert records into the input_file table with a file status of 0
  options(scipen=999)
  dbWriteTable(con, Id(schema = 'auxuliary', table = 'input_file'), flash_df, overwrite = FALSE, append = TRUE)

  }
