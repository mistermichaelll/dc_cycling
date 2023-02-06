connect_to_db <- function() {
  host <- "localhost"
  user <- Sys.getenv("DB_USERNAME")
  pass <- Sys.getenv("DB_PASSWORD")
  
  conn <- DBI::dbConnect(
    RPostgres::Postgres(), 
    "postgres",
    host = host, 
    user = user, 
    password = pass
  )
  
  conn
}

query_db <- function(conn, statement) {
  result <- DBI::dbGetQuery(
    conn, 
    statement
  )
  
  tibble::tibble(result)
}

write_to_db <- function(conn, table_name, table, ...) {
  DBI::dbWriteTable(
    conn,
    DBI::Id(schema = "dc_open_data_raw", table = table_name), 
    table, 
    ...
  )
}

find_offset <- function(conn, table_name) {
  result <- DBI::dbGetQuery(
    conn, 
    paste("SELECT COUNT(*) FROM", table_name, sep = " ")
  )
  
  result |> pull()
}
