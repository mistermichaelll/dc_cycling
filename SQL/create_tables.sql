CREATE TABLE IF NOT EXISTS dc_open_data_raw.vision_zero (
  object_id INT, 
  global_id VARCHAR,
  request_id INT, 
  request_type VARCHAR, 
  request_date TIMESTAMP,
  status VARCHAR,
  street_seg_id INT, 
  comments VARCHAR, 
  user_type VARCHAR
);

CREATE TABLE IF NOT EXISTS dc_open_data_raw.crashes (
  object_id INT, 
  crime_id INT, 
  ccn INT, 
  report_date TIMESTAMP, 
  route_id VARCHAR, 
  measure DECIMAL, 
  "offset" DECIMAL, 
  street_seg_id INT, 
  roadway_seg_id INT, 
  from_date TIMESTAMP, 
  address VARCHAR, 
  latitude DECIMAL, 
  longitude DECIMAL,
  x_coord DECIMAL, 
  y_coord DECIMAL, 
  ward VARCHAR, 
  event_id VARCHAR, 
  mar_address VARCHAR, 
  mar_score DECIMAL, 
  major_injuries__bicyclist INT, 
  minor_injuries__bicyclist INT,
  unknown_injuries__bicyclist INT,
  fatal__bicyclist INT, 
  major_injuries__driver INT, 
  minor_injuries__driver INT, 
  unknown_injuries__driver INT, 
  fatal__driver INT, 
  major_injuries__pedestrian INT, 
  minor_injuries__pedestrian INT, 
  unknown_injuries__pedestrian INT,
  major_injuries__passenger INT, 
  minor_injuries__passenger INT, 
  unknown_injuries__passenger INT, 
  fatal__passenger INT, 
  total_vehicles INT, 
  total_bicycles INT, 
  total_pedestrians INT, 
  total_taxis INT, 
  total_government INT,
  pedestrians_impaired INT,
  bicyclists_impaired INT, 
  drivers_impaired INT,
  speeding_involved INT,
  nearest_int_route_id VARCHAR, 
  nearest_int_street_name VARCHAR, 
  off_intersection DECIMAL,
  int_approach_direction VARCHAR, 
  mar_id INT, 
  location_error VARCHAR,
  last_update_date TIMESTAMP, 
  mpd_latitude DECIMAL, 
  mpd_longitude DECIMAL, 
  mpd_geo_x DECIMAL, 
  mpd_geo_y DECIMAL
)