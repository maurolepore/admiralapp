library(shiny)
library(teal)
library(tibble)

app <- init(
  data = teal_data(faithful = tibble(faithful)),
  modules = modules(
    "Data" |> example_module(),
    "Plot" |>
      module(
        server = function(input, output, session, data) {
          output$plot <- renderPlot({
            df <- data()[["faithful"]]
            plot(df, main = "waiting time")
          })
        },
        ui = function(id, ...) {
          ns <- NS(id)
          plotOutput(ns("plot"))
        }
      )
  )
)

shiny::shinyApp(app$ui, app$server)
