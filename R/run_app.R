#' Run the app
#'
#' @returns Called for its side effect.
#' @export
#'
#' @examplesIf interactive()
#' run_app()
run_app <- function() {
  link <- function(x) {
    shiny::tags$a(href = sprintf("https://maurolepore.github.io/%s/", x) , x)
  }

  app <- init(
    data = teal_data(admiralverse = admiralapp::public),
    modules = modules(
      "Documantation" |> module(
        server = function(input, output, session, data) {
          output$documentation <- renderDataTable({
            DT::datatable(data()[["admiralverse"]], escape = FALSE)
          })
        },
        ui = function(id, ...) {
          ns <- shiny::NS(id)
          shiny::dataTableOutput(ns("documentation"))
        }
      ),
      "Raw" |> teal::example_module()
    )
  ) |>
    modify_title("admiralverse") |>
    modify_header(h3(link("admiralverse"))) |>
    modify_footer(link("dverse"))

  shiny::shinyApp(app$ui, app$server)
}

