# DC Open Data
This repository has some code I'm using to work with [DC's Open Data portal](https://opendata.dc.gov/). Currently, this includes:
1) R scripts used to pull data from the API, clean up some column names, and then push this data to a local postgres database
2) a dbt project to clean up data in the database
3) any SQL used to generate schemas, queries, etc. from the local postgres database

# Motivation
Working with data from the API can be cumbersome - especially when there are hundreds of thousands of records and a rate limit of 1000. My solution to this was to spin up a local postgres server, collect the data + do a bit of name cleanup in R, populate the postgres database, then use dbt to test the raw data + clean it up for analysis. 

Having this local SQL server means that I can update it when new data is available and avoid making thousands of API calls before doing any kind of analysis.

# Example of Use
When my postgres server is running, I can do some pretty quick analysis with SQL–integrated into R this makes it pretty easy to do something like this:

```r
library(ggplot2)

source("utils.R")

## connect to the local postgresDB
conn <- connect_to_db()

## query the DB
conn |> 
  query_db(
    "
    SELECT 
      EXTRACT(YEAR FROM report_date)::Int AS report_year,
      COUNT(*)::INT AS n_crashes
    FROM dc_open_data_dev.raw__crashes
    WHERE report_date IS NOT NULL
      AND EXTRACT(YEAR FROM report_date) < 2023
        AND EXTRACT(YEAR FROM report_date) >= 2010
    GROUP BY EXTRACT(YEAR FROM report_date)
    ORDER BY report_year
    "
  ) |> 
## create a plot from the queried data
  ggplot() +
  aes(x = report_year, y = n_crashes) +
  geom_line(size = 1.5, color = "deepskyblue4") +
  labs(
    x = "\nYear Reported", 
    y = "Num. Reported Crashes", 
    title = "Crashes in Washington, D.C.", 
    subtitle = "sourced from DC's Open Data Portal"
  ) +
  scale_x_continuous(labels = round) +
  theme_minimal() +
  theme(
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    panel.grid.major.y = element_line(color = "grey95", linetype = "dashed"),
    plot.title = element_text(size = 24, face = "bold"), 
    plot.subtitle = element_text(face = "italic")
  )
```

![image](https://user-images.githubusercontent.com/33233019/216847807-65b88056-f6c0-4218-b5d5-b10dfec3b999.png)
