source("pull_data.R")
source("utils.R")

conn |> 
  write_to_db(
    table_name = "crashes", 
    dc_crashes_clean_names, 
    overwrite = TRUE
  )

conn |> 
  write_to_db(
    table_name = "vision_zero", 
    vision_zero_clean_names, 
    overwrite = TRUE
  )
