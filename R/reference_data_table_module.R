reference_data_table_module <- function(label = "Reference") {
    module(
      label = label,
      server = reference_data_table_server,
      ui = reference_data_table_ui,
      datanames = "reference"
    )
}
reference_data_table_server <- function(id, data) {
  shiny::moduleServer(id, function(input, output, session) {
    output$ref <- DT::renderDT({
      DT::datatable(data()[["reference"]], escape = FALSE)
    })
  })
}

reference_data_table_ui <- function(id) {
  ns <- shiny::NS(id)
  DT::DTOutput(ns("ref"))
}
