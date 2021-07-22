#'---
#'title: "#TidyTuesday"
#'subtitle: "Week 29"
#'author: "Nabil Murtadha"
#'---

#' **Carregando a base da semana**
#' A semana 29 trás variáveis sobre os episódios do Scooby-Doo.
## ---- base , message = FALSE, warning = FALSE ------
library(tidyverse)

tuesdata <- tidytuesdayR::tt_load('2021-07-13')
tuesdata <- tidytuesdayR::tt_load(2021, week = 29)

scoobydoo <- tuesdata$scoobydoo

#' Verificando a base
## ---- check , message = FALSE, warning = FALSE ------
dplyr::glimpse(scoobydoo)

#' Transformando em classe logica as variaveis de interesse
## ---- mutate , message = FALSE, warning = FALSE ------
scoobydoo <- scoobydoo %>% mutate(across(contains(c("caught", "captured", "unmask","snack")),as.logical))

# ep por temporada
scoobydoo %>% count(season)

# removendo season 4, crossover e special.
scoobydoo <- scoobydoo %>% filter(season %in% c("1","2","3"))

#' Contando a frequência de protagonismo de cada personagem por temporada
#' transformando a tible em série temporal
## ---- plot , message = FALSE, warning = FALSE ------
library(ggplot2)
scoobydoo %>% 
  select(season,contains(c("caught", "captured", "unmask","snack"))) %>%
  group_by(season) %>%
  summarise(across(everything(), list(mean), na.rm = TRUE)) %>%
  pivot_longer(-season, names_to = "nome", values_to = "freq") %>%
  mutate(action = stringr::str_remove(nome, "_.*"),
         name = stringr::str_remove(nome, action),
         name = gsub("[_1]", "", name),
         across(c(action,name), stringr::str_to_title),
         across(c(action, name), as.factor))%>%
  select(-nome) %>%
  filter(!name %in% c("Other", "Not", "Ofsnacks")) %>%
  ggplot(aes(x = season, y = freq, group = name, fill = name))+
  geom_bar(color = "black",stat = "identity", position = "dodge")+
  facet_wrap(~action, scales = "free_y")+
  scale_fill_manual(name = "Character", values = c("#4b0055", "#128a84",
                                                     "#8e6345", "#79af30",
                                                     "#bb5c37"))+
  scale_y_continuous(labels = scales::percent_format(accuracy = 1))+
  labs(title = "Proportion of each action taken by each character by season",
       subtitle = "Scooby-Doo database - #TidyTuesday",
       x = "Season",
       y = "Proportion")+
  theme_minimal()


  
  
  

            
