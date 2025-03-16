#' Run the app
#'
#' @returns Called for its side effect.
#' @export
#'
#' @examplesIf interactive()
#' run_app()
run_app <- function() {
  app <- init(
    data = teal_data(reference = admiralapp::public),
    modules = modules(
      # Example creating a module
      "Reference" |>
        module(
          server = function(input, output, session, data) {
            output$ref <- DT::renderDT({
              DT::datatable(data()[["reference"]], escape = FALSE)
            })
          },
          ui = function(id, ...) {
            ns <- shiny::NS(id)
            DT::DTOutput(ns("ref"))
          }
        ),
      # Example reusing a module
      "Raw" |> teal::example_module()
    )
  ) |>
    modify_title("admiralverse") |>
    modify_header(tags$p("The toy ", maurolepore("admiralverse"))) |>
    modify_footer(tags$p("Created with love and ", maurolepore("dverse")))

  shiny::shinyApp(app$ui, app$server)
}

maurolepore <- function(x) {
  tags$a(href = sprintf("https://maurolepore.github.io/%s/", x), x)
}
