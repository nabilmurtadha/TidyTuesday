#' **carregando a base**
tuesdata <- tidytuesdayR::tt_load(2021, week = 27)
animal_rescues <- tuesdata$animal_rescues

#' **Padronizando nomes**
janitor::clean_names(animal_rescues)

#' Pacotes
library(tidyverse)
library(ggplot2)
library(lubridate)

#' **Natureza dos dados**
glimpse(animal_rescues)

#' **Selecionando variaveis de interesse**
var <- animal_rescues %>% select(date_time_of_call,
                                 animal_group_parent)

#' **Colocando em formato de `dmy_hm` do pacote `lubridate`**
var <- var %>% mutate(date_time = lubridate::dmy_hm(date_time_of_call))




#' **Estratificando por %m/%Y**
tab1 <- var %>%
        group_by(mes = lubridate::floor_date(date_time, "month"),
                 animal = animal_group_parent) %>%
        summarise(n = n())

#' **Plotando**
