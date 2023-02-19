using DataFrames, DataFramesMeta
using LibPQ
using CairoMakie
using Dates

## connect to the local postgres server that has our data,
##  get the data into a dataframe within Julia.
user = ENV["DB_USER"]
pass = ENV["DB_PASSWORD"]

conn = LibPQ.Connection("dbname=postgres user=$user password=$pass")

crashes = DataFrame(execute(conn, "SELECT * FROM dc_open_data_dev.fct__crashes"))

## how many crashes involving bicycles have occurred all time?
total_bicycle_incidents = @subset(crashes, :total_bicycles .>= 1) |> nrow

## what years have had the most incidents with bikes?
num_incidents_by_year = @chain crashes begin
    @subset (:total_bicycles .>= 1)
    @transform @byrow (:year = year(:report_date))
    @subset @byrow (:year .< 2023)
    groupby(:year)
    @combine (:n_cycling_incidents = length(:crash_id))
end

num_incidents_by_year

## function to create a plot using Makie, applies some formatting to the plot as well.
function plot_line(data, x_axis::Symbol, y_axis::Symbol; title = "", subtitle = "", xlab = "", ylab = "")
    f = Figure(backgroundcolor = :white, resolution = (900, 700), fontsize = 14)

    ax = Axis(
        f[1, 1],
        title = title,
        subtitle = subtitle,
        xlabel = xlab,
        ylabel = ylab
    )

    ## axis formatting
    ax.xtickformat = x -> string.(Int.(round.(x)))
    ax.xgridcolor = :white
    ax.ygridstyle = :dash
    ax.titlealign = :left
    ax.subtitlefont = :italic

    x = data[!, x_axis]
    y = data[!, y_axis]

    lines!(ax, x, y; color = :deepskyblue3, linewidth = 2.5)

    f
end

## make our plot
plot = plot_line(
    num_incidents_by_year,
    :year,
    :n_cycling_incidents;
    title = "Crashes Involving Bicycles Have Declined Since Their Peak in 2017",
    subtitle = "(includes incidents where num. bicycles >= 1)",
    xlab = "Year",
    ylab = "Num. Incidents Involving Bicycles"
)

## save it
save("figure.pdf", plot, px_per_unit = 2)
