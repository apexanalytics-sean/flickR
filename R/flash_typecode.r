#' flash_typecode
#'
#' Check for any waiting files per typecode specified in
#' the input_file_type table and add them to the input_file
#' table
#' @export

flash_typecode  <- function() {
  ## connect to DB
  ## pull folder for typecode from DB table
  ## list files in that folder
  ## insert records into the input_file table with a file status of 0
}
