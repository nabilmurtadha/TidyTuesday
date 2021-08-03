#'---
#'title: "#TidyTuesday"
#'subtitle: "Week 31"
#'author: "Nabil Murtadha"
#'---

#' **Carregando a base da semana**
#' A semana 31 trás variáveis sobre os medalhistas olímpicos.
## ---- base , message = FALSE, warning = FALSE ------
library(tidyverse)
tuesdata <- tidytuesdayR::tt_load(2021, week = 31)
olympics <- tuesdata$olympics

#
glimpse(olympics)

# Filtrando para jogos de verao e medalhistas apenas.
olimpiadas_verao <- filter(olympics, season == "Summer",
                          !is.na(medal))


# selecionando o pais Brasil e as variaveis de interesse
brasil <- olimpiadas_verao %>% filter(team == "Brazil") %>% select(year,sport,city,event,medal)

# filtrando para uma só observação por competição do esporte e reordenando os fatores de acordo com sua frequencia

brasil <- brasil %>% group_by(year,sport,city,event,medal) %>% unique() %>% ungroup()
brasil$sport <- forcats::fct_infreq(brasil$sport)


## ---- plot , message = FALSE, warning = FALSE ------
brasil %>% count(sport,medal) %>%
  ggplot(aes(x = medal, y = n, fill = medal))+
  geom_bar(stat = "identity", position = "dodge", color = "black" )+
  geom_text(aes(label = n),nudge_y = 2, size = 3.5, color = "white")+
  scale_fill_manual(name = "Medalhas", values = c("#A77044", "#FEE101","#A7A7AD"))+
  facet_wrap(~sport)+
  ylab("Quantidade")+
  labs(title = "Olympics Medals From Brazil by Sports",
       subtitle = "From 1920 to 2016")+
  theme_minimal()+
  theme(axis.title.x = element_blank(),axis.ticks.x.bottom = element_blank(),
        axis.text.x.bottom = element_blank(),axis.text.y.left = element_blank(),
        axis.ticks.y.left = element_blank(), axis.title.y = element_blank(),
        panel.grid = element_blank(), plot.background = element_rect(fill = "#009C3B"),
        panel.background = element_rect(fill = "#002776"),text = element_text(color = "white"),
        strip.text = element_text(color = "white", size = 10.5))
  
  
  
