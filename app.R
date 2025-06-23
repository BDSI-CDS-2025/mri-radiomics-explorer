# app.R
# *single* entry-point that sources modules
#
# to run:

# getting started: https://mastering-shiny.org/basic-app.html

library(shiny)

ui <- fluidPage()

server <- function(input, output, session) {
    db <- data_loader_server("loaddata") # loaddata is the ID for this server
    mod_overview_server("ovw", db)
}

shinyApp(ui, server)