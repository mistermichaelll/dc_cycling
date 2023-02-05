library(dplyr)
library(httr)
library(purrr)
library(jsonlite, include.only = "parse_json")

get_dc_crashes_data <- function (rate_limit = 1000, offset = 0) {
  if (rate_limit > 1000) {
    warning(
      sprintf("A limit value of %s exceeeds the allowed rate limit. Defaulting to maximum of 1000.", limit)
    )
    rate_limit = 1000
  }
  
  url <- "https://maps2.dcgis.dc.gov/dcgis/rest/services/DCGIS_DATA/Public_Safety_WebMercator/MapServer/24/query?outFields=*&where=1%3D1&f=geojson"
  
  results_list <- list()
  n_responses <- rate_limit
  
  while (n_responses > 0) {
    resp <- GET(
      url, 
      query = list(
        resultOffset = offset, 
        resultRecordCount = rate_limit
      )
    )
    
    if (status_code(resp) != 200) {
      error("Bad request.")
    }
    
    json_resp <- resp |> parse_json()
    
    results_list <- append(results_list, json_resp[["features"]])
    
    n_responses <- length(json_resp[["features"]])
    
    offset <- offset + n_responses
  }
  
  results_list |> 
    map_dfr(
      ~pluck(.x, "properties")
    ) |> 
    mutate(
      REPORTDATE = lubridate::as_datetime(
        (REPORTDATE / 1000) - (6 * 60 * 60), tz = "UTC"
      ), 
      FROMDATE = lubridate::as_datetime(
        (FROMDATE / 1000) - (6 * 60 * 60), tz = "UTC"
      ), 
      LASTUPDATEDATE = lubridate::as_datetime(
        (LASTUPDATEDATE / 1000) - (6 * 60 * 60), tz = "UTC"
      )
    )
}
