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
      "Reference" |> reference_data_table_module(),
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
