#'---
#'title: "#TidyTuesday"
#'subtitle: "Week 29"
#'author: "Nabil Murtadha"
#'---

#' **Carregando a base da semana**
#' A semana 29 trás variáveis sobre os episódios do Scooby-Doo.
## ---- base , message = FALSE, warning = FALSE ------
library(magrittr)

tuesdata <- tidytuesdayR::tt_load('2021-07-13')
tuesdata <- tidytuesdayR::tt_load(2021, week = 29)

scoobydoo <- tuesdata$scoobydoo

dplyr::glimpse(scoobydoo)

