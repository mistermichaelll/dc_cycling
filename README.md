# DC Open Data
This repository has some code I'm using to work with DC's Open Data portal. Currently, this includes:
1) R scripts used to pull data from the API and push this to a local postgres database
2) a dbt project to clean up data in the database
3) any SQL used to generate schemas, queries, etc. from the local postgres database
# Motivation
Working with data from the API can be cumbersome - especially when there are hundreds of thousands of records and a rate limit of 1000. My solution to this was to spin up a local postgres server, collect the data + do a bit of name cleanup in R, populate the postgres database, then use dbt to test the raw data + clean it up for analysis. 

Having this local SQL server means that I can update it when new data is available and avoid making thousands of API calls before doing any kind of analysis.
