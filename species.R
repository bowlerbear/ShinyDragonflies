

library(tidyverse)


img_dir <- "images"

ts_plots_dir <- "data/ts_plots"

estimate_maps_dir <- "data/spatial_maps/estimate"

error_maps_dir <- "data/spatial_maps/error"


species_names <- gsub("_ts.png", "", list.files(ts_plots_dir))


Datafile_1_Traits_and_trends <- readr::read_csv("data/Datafile_1_Traits_and_trends.csv")
Datafile_1_Traits_and_trends$trend_classification <- ifelse(
  Datafile_1_Traits_and_trends$Trend < 0, "Decreasing", "Increasing"
)



# for the language option https://github.com/datasketch/shi18ny/
#devtools::install_github("datasketch/shi18ny")








# iDiv_colors <- readRDS("iDiv_colors.rds")

