# carregando a base
tuesdata <- tidytuesdayR::tt_load(2021, week = 27)
animal_rescues <- tuesdata$animal_rescues

# padronizando nomes
janitor::clean_names(animal_rescues)