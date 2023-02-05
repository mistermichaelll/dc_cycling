SELECT 
  *
FROM {{ source("dc_open_data_raw", "crashes") }}
