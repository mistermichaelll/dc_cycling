SELECT 
  *
FROM {{ source("dc_open_data_raw", "vision_zero") }}
