options("teal.bs_theme" = bslib::bs_theme(version = "3", bootswatch = "united"))

# ShinyApp
pkgload::load_all()
run_app()
