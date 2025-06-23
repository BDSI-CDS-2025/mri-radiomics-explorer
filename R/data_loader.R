# data_loader.R
# reactive data module: defines pair of Shiny module functions for loading data
#
# the basic parts of a shiny app: https://shiny.posit.co/r/articles/start/basics/
# each page of a shiny app will contain a server and ui

library(shiny)

# define ui logic
data_loader_ui <- function(id) {
  ns <- NS(id) # creates a namespace
  # https://shiny.posit.co/r/reference/shiny/0.14/ns.html
  # used for shiny modules to avoid name collisions
  # shiny applications use IDs to identify inputs and outputs
  # these IDs need to be unique within an application
  
  # no UI yet
  tagList() # will return the UI elements
}

# define servier-side logic
data_loader_server <- function(id) {
  moduleServer(id, function(input, output, session) {
    # read once, then cache in a reactive
    raw <- readRDS(DATA_PATH) # load the R object constructed in scripts/data_prep.R
    reactive(raw) # will allow the file to adjust to future changes
  })
}