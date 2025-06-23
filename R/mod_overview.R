# mod_overview.R
# the overview tab module

library(shiny)

mod_overview_ui <- function(id) {
  ns <- NS(id) # use the namespace for this module
  tabItem(
    tabName = "overview", # must correspond to the tabName of a menu item
    
    fluidRow(
      valueBoxOutput(ns("n_patients"), width = 3),
      valueBoxOutput(ns("pct_missing"), width = 3)
    ),

    fluidRow(
      box(
        title = "Missing-value heatmap",
        status = "primary", width = 12,
        plotlyOutput(ns("missmap"), height = 600)
      )
    )
  )
}

mod_overview_server <- function(id, r_data) {
  moduleServer(id, function(input, output, session) {

    # valueBoxes
    output$n_patients <- renderValueBox({
      valueBox(
        value = nrow(r_data()),
        subtitle = "Patients in cohort",
        icon = icon("users"),
        color = "teal"
      )
    })

    output$pct_missing <- renderValueBox({
      pct <- round(mean(is.na(r_data())) * 100, 1)
      valueBox(
        value = paste0(pct, " %"),
        subtitle = "Overall missingness",
        icon = icon("percent"),
        color = ifelse(pct < 5, "green", "orange")
      )
    })

    # heatmaply NA
    output$missmap <- renderPlotly({
      # janitor::remove_empty avoids heatmaply error when a row/col is 100 % NA
      df <- janitor::remove_empty(r_data(), which = c("cols"))
      heatmaply::heatmaply_na(
        df,
        hide_colorbar = TRUE,
        xlab = "Variables",
        ylab = "Patients",
        fontsize_row = 6,
        fontsize_col = 6
      )
    })
  })
}
