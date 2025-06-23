# _helpers.R

# packages everyone will need
global_libs <- c(
  "shiny", "shinydashboard", "dplyr", "heatmaply",
  "plotly", "DT", "janitor"
)

# apply the require function over global_libs
# will output warnings if the libraries are not installed
lapply(global_libs, require, character.only = TRUE)

# path to processed data
DATA_PATH <- "data/processed/duke_cleaned.rds"

# custom ggplot theme
theme_app <- ggplot2::theme_minimal(base_family = "Helvetica")

# helper to detect numeric radiomic columns (for later tabs)
radiomic_cols <- function(df) {
    # searches through names(df)
    # ^f\\d|_tumor$|_tissue matches any column that starts with f followed by a digit, 
    # ends with _tumor, or contains _tissue anqyere
    # VALUE = TRUE returns the column names and not positions
  grep("^f\\d|_tumor$|_tissue", names(df), value = TRUE)
}