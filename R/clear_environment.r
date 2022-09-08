#' clear_envrionment
#'
#' Clear all objects in the current environment
#' @export

clear_environment  <- function() {
  rm(list=ls())
}
