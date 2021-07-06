#' **carregando a base**
## ----  message = FALSE, warning = FALSE ------
tuesdata <- tidytuesdayR::tt_load(2021, week = 27)
animal_rescues <- tuesdata$animal_rescues

#' **Padronizando nomes**
## ----  message = FALSE, warning = FALSE ------
janitor::clean_names(animal_rescues)

#' **Carregando pacotes**
## ----  message = FALSE, warning = FALSE ------
library(tidyverse)
library(ggplot2)
library(lubridate)

#' **Natureza dos dados**
## ----  message = FALSE, warning = FALSE ------
glimpse(animal_rescues)

#' **Selecionando variaveis de interesse**
## ----  message = FALSE, warning = FALSE ------
var <- animal_rescues %>% select(date_time_of_call,
                                 animal_group_parent)

#' **Colocando em formato de `dmy_hm` do pacote `lubridate`**
## ----  message = FALSE, warning = FALSE ------
var <- var %>% mutate(date_time = lubridate::dmy_hm(date_time_of_call))

#' **Verificando o animal mais resgatado**
## ----  message = FALSE, warning = FALSE ------
var %>%
  count(animal_group_parent) %>%
  arrange(desc(n)) %>% top_n(1)


#' **Estratificando por %m/%Y e filtrando para gatos**
plot <- var %>%
  group_by(data = lubridate::floor_date(date_time, "month"),
           animal = as.factor(animal_group_parent)) %>%
  summarise(n = n()) %>%
  filter(animal == "Cat") %>%
  mutate(ano = lubridate::year(data),
         mes = lubridate::month(data))

plot

## ----  message = FALSE, warning = FALSE ------
#' **Plotando**

plot %>%
  group_by(ano) %>%
  mutate(media_anual = mean(n)) %>%
  ungroup() %>%
  ggplot()+
  geom_bar(aes(x = as.factor(mes), y = n),
           stat = "identity", position = "dodge",
           fill = "#00843D")+
  xlab("Ano")+
  ylab("Quantidade de gatos")+
  geom_line(aes(x = mes, y = media_anual, group = 1),
            color = "#003A70", size = 1.3)+
  geom_text(aes(x = 1.5, y = media_anual + 5,label = round(media_anual,1)))+
  facet_wrap(~ano)+
  theme_minimal()

#' Segundo o [The Guardian](URL(https://www.theguardian.com/world/2021/jan/08/animal-rescues-london-fire-brigade-rise-2020-pandemic-year)) no ano pandêmico
#' o numero de ocorrências aumentaram em 20% comparado em 2019, além disso, os gráfico acima revela que por enquanto é a maior média anual desde 2009 se
#' desconsiderarmos a média dos primeiros meses de 2021 que se encontra com uma média de `30.2`.
