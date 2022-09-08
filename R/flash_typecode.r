#' flash_typecode
#'
#' Check for any waiting files per typecode specified in
#' the input_file_type table and add them to the input_file
#' table
#' @export
#' @param file_type_code file_type_code of file from input_file_type table
#' @param odbc ODBC connector containing destination database details

flash_typecode  <- function(file_type_code, odbc) {
  con <- dbConnect(odbc(), odbc)
  path <- as.character(dbGetQuery(con, statement = paste0("select distinct [file_path] as path from auxiliary.input_file_type where file_type_code = '", file_type_code, "'")))
  files_in_folder <- as.data.frame(list.files(path))
  files_in_folder$file_name <- files_in_folder$`list.files(path)`
  files_in_folder$`list.files(path)` <- NULL
  files_in_folder$path <- path
  files_in_folder$full_path <- paste0(files_in_folder$path, '\\', files_in_folder$file_name)
  files_in_folder$hashes <- md5sum(files_in_folder$full_path)
  ## create df structure so it matches table
  file_status <- 0
  date_loaded <- as.data.frame(as.Date('1970-01-01 00:00:00'))
  destination_table <- ''
  message <- 'File Waiting to be Loaded'
  type_code_used <- TRUE
  flash_df <- as.data.frame(cbind(file_type_code, files_in_folder$full_path, file_status, files_in_folder$hashes, date_added, date_loaded, destination_table, message, type_code_used))
  flash_df$file_status <- as.numeric(flash_df$file_status)
  colnames(flash_df)[2] <- "file_path"
  colnames(flash_df)[4] <- "file_hash"
  colnames(flash_df)[6] <- "date_loaded"
  flash_df$date_added <- Sys.time()

## need to add check for existing hashes once i have ran a few files through the process
## todo: update file status to 6 if duplicate is identified based on hash
## logic to check if the hashes already exist
## update file_status to 6 if already exists and message to duplicate found

  #ex_hashes <- as.data.frame(dbGetQuery(con, statement = paste0("select distinct file_hash from auxiliary.input_file")))
  #hash_check <- merge(x = ex_hashes, y = flash_df, by = "file_hash", all.x = TRUE)
  options(scipen=999)
  dbWriteTable(con, Id(schema = 'auxiliary', table = 'input_file'), flash_df, overwrite = FALSE, append = TRUE)
  nfiles <- nrow(flash_df)
  print(paste0(nfiles, ' files added to input_file table'))
  }
