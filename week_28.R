#'---
#'title: "#TidyTuesday"
#'subtitle: "Week 28"
#'author: "Nabil Murtadha"
#'---

#' ** Carregando a base da semana **
#' A semana 28 trás O dia da independência dos países.
## ---- base , message = FALSE, warning = FALSE ------
tuesdata <- tidytuesdayR::tt_load('2021-07-06')
tuesdata <- tidytuesdayR::tt_load(2021, week = 28)

holidays <- tuesdata$holidays

#' ** Carregando pacotes **
## ---- pacotes, message = FALSE, warning = FALSE ---- 
library(tidyverse)
library(ggplot2)
library(lubridate)
library(ggbump)
library(ggtext)

install.packages("ggbump","ggtext")

#' ** Ivestigando as variáveis **

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
  select(country, metropole, date) %>%
  group_by(country, metropole, date) %>%
  summarise(n = n()) %>%
  ungroup() %>%
  group_by(metropole) %>%
  arrange(date) %>%
  mutate(soma = cumsum(n))
  

#' ** Plotando **
# plotando

subset(temp) %>%
  ggplot(aes(x = date, y = soma,colour = metropole))+
  geom_sigmoid(smooth = 10,alpha=1) +
  geom_point( size = 1)+
  theme_minimal()+
  scale_color_discrete(name = "Metrópole")+
  scale_y_continuous(name = "Total", breaks = seq(0,60,10))+
  coord_flip()
  






