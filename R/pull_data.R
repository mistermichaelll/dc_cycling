source("api_scripts/crashes.R")
source("api_scripts/vision_zero.R")
source("utils.R")

conn <- connect_to_db()

dc_crashes_raw <- get_dc_crashes_data(offset = find_offset(conn, "dc_open_data_raw.crashes"))
vision_zero_raw <- get_vision_zero_data(offset = find_offset(conn, "dc_open_data_raw.vision_zero"))

dc_crashes_clean_names <- dc_crashes_raw |> 
  dplyr::select(
    object_id = OBJECTID, 
    crime_id = CRIMEID, 
    ccn = CCN, 
    report_date = REPORTDATE, 
    route_id = ROUTEID, 
    measure = MEASURE, 
    offset = OFFSET, 
    street_seg_id = STREETSEGID, 
    roadway_seg_id = ROADWAYSEGID, 
    from_date = FROMDATE, 
    address = ADDRESS, 
    latitude = LATITUDE, 
    longitude = LONGITUDE,
    x_coord = XCOORD, 
    y_coord = YCOORD, 
    ward = WARD, 
    event_id = EVENTID, 
    mar_address = MAR_ADDRESS, 
    mar_score = MAR_SCORE, 
    major_injuries__bicyclist = MAJORINJURIES_BICYCLIST, 
    minor_injuries__bicyclist = MINORINJURIES_BICYCLIST,
    unknown_injuries__bicyclist = UNKNOWNINJURIES_BICYCLIST,
    fatal__bicyclist = FATAL_BICYCLIST, 
    major_injuries__driver = MAJORINJURIES_DRIVER, 
    minor_injuries__driver = MINORINJURIES_DRIVER, 
    unknown_injuries__driver = UNKNOWNINJURIES_DRIVER, 
    fatal__driver = FATAL_DRIVER, 
    major_injuries__pedestrian = MAJORINJURIES_PEDESTRIAN, 
    minor_injuries__pedestrian = MINORINJURIES_PEDESTRIAN, 
    unknown_injuries__pedestrian = UNKNOWNINJURIES_PEDESTRIAN,
    fatal__pedestrian = FATAL_PEDESTRIAN,
    major_injuries__passenger = MAJORINJURIESPASSENGER, 
    minor_injuries__passenger = MINORINJURIESPASSENGER, 
    unknown_injuries__passenger = UNKNOWNINJURIESPASSENGER, 
    fatal__passenger = FATALPASSENGER, 
    total_vehicles = TOTAL_VEHICLES, 
    total_bicycles = TOTAL_BICYCLES, 
    total_pedestrians = TOTAL_PEDESTRIANS, 
    total_taxis = TOTAL_TAXIS, 
    total_government = TOTAL_GOVERNMENT,
    pedestrians_impaired = PEDESTRIANSIMPAIRED,
    bicyclists_impaired = BICYCLISTSIMPAIRED, 
    drivers_impaired = DRIVERSIMPAIRED,
    speeding_involved = SPEEDING_INVOLVED,
    nearest_int_route_id = NEARESTINTROUTEID, 
    nearest_int_street_name = NEARESTINTSTREETNAME, 
    off_intersection = OFFINTERSECTION,
    int_approach_direction = INTAPPROACHDIRECTION, 
    mar_id = MAR_ID, 
    location_error = LOCATIONERROR,
    last_update_date = LASTUPDATEDATE, 
    mpd_latitude = MPDLATITUDE, 
    mpd_longitude = MPDLONGITUDE, 
    mpd_geo_x = MPDGEOX, 
    mpd_geo_y = MPDGEOY
  )

vision_zero_clean_names <- vision_zero_data_raw |> 
  dplyr::rename(
    object_id = OBJECTID, 
    global_id = GLOBALID, 
    request_id = REQUESTID, 
    request_type = REQUESTTYPE, 
    request_date = REQUESTDATE, 
    status = STATUS, 
    street_seg_id = STREETSEGID,
    comments = COMMENTS, 
    user_type = USERTYPE
  )
