# load the sample_file.csv to a SQL table in the localhost DB using the localhost ODBC connector, overwriting the previous table version
#rm(list=ls())

#file_path <- '.\\Other\\sample_csv\\sample_file.csv'
#folder <- '.\\Other\\sample_csv'
#odbc <- 'localhost_sqlsrv'
#tablename <- 'sample_file'
#schema <- 'stage'
#file_type_code <- 'test'
#path <- '.\\Other\\sample_csv'

#library(devtools)
#install_github("apexanalytics/flickR")
#flick_csv(file_path = '.\\Other\\sample_file.csv', odbc = 'localhost', tablename = 'sample_file', schema = 'stage', overwrite = TRUE, append = FALSE)
#flick_csv_folder(folder = '.\\Other\\sample_csv\\', odbc = 'localhost', tablename = 'multiple_sample_file', schema = 'stage')

### WIP for deciding between SQL Server, MySQL, PGSQL and possibly SQLite (need to set up MySQL and PGSQL instances to test)
#odbc <- 'localhost_sqlsrv'
#con <- dbConnect(odbc(), odbc)
#drvr <- odbcListDataSources()[ odbcListDataSources()$name == odbc, "description" ]
