#'---
#'title: "#TidyTuesday"
#'subtitle: "Week 28"
#'author: "Nabil Murtadha"
#'---

#' **Carregando a base da semana**
#' A semana 28 trás O dia da independência dos países.
## ---- base , message = FALSE, warning = FALSE ------
tuesdata <- tidytuesdayR::tt_load('2021-07-06')
tuesdata <- tidytuesdayR::tt_load(2021, week = 28)

holidays <- tuesdata$holidays

#' **Carregando pacotes**
## ---- pacotes, message = FALSE, warning = FALSE ---- 
library(tidyverse)
library(ggplot2)
library(lubridate)

#' **Ivestigando as variáveis**

# Tipos de colonizadores
unique(holidays$independence_from)

# Metropoles - Espanha, França, Inglaterra e Portugal
portugal <- c("United Kingdom of Portugal, Brazil and the Algarves",
              "Portugal")

england <- c("United Kingdom","United Kingdom of Great Britain and Ireland",
                "United Kingdom and the British Mandate for Palestine",
                "Australia, New Zealand and the United Kingdom" ,
                "Italy and United Kingdom",
                "Egypt and the United Kingdom",
                "Kingdom of Great Britain",
                "United Kingdom and France")

france <- c("France","Empire of Japan and France") # "France and Spain"

spain <- c("Spanish Empire","Spain","Spanish Empire[72]")
# data das independecias das metropoles acima

temp <- holidays %>%
  mutate(date = mdy(date_mdy),
         metropole = case_when(independence_from %in% portugal~"Portugal",
                               independence_from %in% england~"United Kingdom",
                               independence_from %in% france~"France",
                               independence_from %in% spain~"Spain")) %>%
  filter(!is.na(metropole)) %>%
  select(country, metropole, date, year) %>%
  group_by(country, metropole, date, year) %>%
  summarise(n = n()) %>%
  ungroup() %>%
  group_by(metropole) %>%
  arrange(date) %>%
  mutate(soma = cumsum(n)) %>% ungroup()
  

#' **Plotando**
## ---- plot, message = FALSE, warning = FALSE ---- 
# plotando

temp %>%
  ggplot(aes(x = year, y = metropole, colour = metropole))+
  geom_line(size = 5) + geom_point(size = 10)+
  geom_jitter(colour = "black", width = 5, height = 0.5, size = 0.4)+
  geom_text(check_overlap = TRUE, angle = 45, aes(label = country), size = 3, colour = "white")+
  annotate(geom = "text", x = 1986, y = 4, label = "Brunei", colour = "white", size = 3, angle = 45)+
  annotate(geom = "text", x = 1982, y = 1, label = "Djibouti", colour = "white", size = 3, angle = 45)+
  scale_x_continuous(breaks = seq(1580,2010,50))+
  scale_color_manual(name = "Metrópole",values = c("United Kingdom" = "#CF142B",
                                                   "Spain" = "#F1BF00",
                                                   "Portugal" = "#006600",
                                                   "France" = "#0055A4"))+
  theme_minimal()+
  theme(axis.title.y = element_blank(),
        axis.title.x = element_blank(),
        panel.grid = element_blank(),
        axis.text = element_text(colour = "white", size = 10),
        legend.position = "none",
        plot.background = element_rect(fill = "#696969", colour = "#696969"))



