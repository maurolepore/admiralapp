library(dverse)
# maurolepore/admiralverse
library(admiralverse)
library(dplyr)

admiralverse <- c(
  "admiral",
  "admiraldev",
  "admiralonco",
  "admiralophtha",
  "admiralpeds",
  "admiralvaccine"
)
template <- "https://pharmaverse.github.io/{package}/reference/{topic}.html"
docs <- dverse::document_universe(admiralverse, template)

online <- docs |> filter(dverse::is_online(topic))

articles <- online |>
  filter(type == "vignette") |>
  mutate(type = "article") |>
  distinct(package, type, topic, title)

datasets <- online |>
  filter(keyword == "datasets") |>
  mutate(type = "dataset") |>
  distinct(package, type, topic, title)

internal <- online |>
  filter(keyword == "internal") |>
  mutate(type = "internal") |>
  distinct(package, type, topic, title)

functions <- online |>
  anti_join(online |> filter(type == "article")) |>
  anti_join(online |> filter(type == "dataset")) |>
  anti_join(online |> filter(type == "internal")) |>
  mutate(type = "function") |>
  distinct(package, type, topic, title)

public <- bind_rows(articles, datasets, functions, internal)

usethis::use_data(public, overwrite = TRUE)
