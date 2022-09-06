# load the sample_file.csv to a SQL table in the localhost DB, overwriting the previous table version
flick_adhoc_csv(path = '.\\sample_file.csv', odbc = 'localhost', overwrite = TRUE, append = FALSE)
