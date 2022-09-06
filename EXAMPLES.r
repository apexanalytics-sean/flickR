# load the sample_file.csv to a SQL table in the localhost DB using the localhost ODBC connector, overwriting the previous table version
library(devtools)
install_github("apexanalytics/flickR")
flick_adhoc_csv(path = '.\\sample_file.csv', odbc = 'localhost', overwrite = TRUE, append = FALSE)
