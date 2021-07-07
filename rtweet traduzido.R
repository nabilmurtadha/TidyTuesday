#'---
#'title: "#Aprendendo pacote rtweet"
#'subtitle: "Week 28"
#'author: "Nabil Murtadha"
#'---

#' Aprendendo pacote rtweet
library(rtweet)

#' Pesquisando tweets
rt <- search_tweets(
  "#stats", # a palavra
  n = 18000, # quantidade,
  include_rts = FALSE #incluir retweets
)

#' vendo os usuarios dos tweets
users_data(rt)

#' serie de tempo com os tweets
ts_plot(rt)

#' caso tenha passado o rate limit (18000 a cada 15 min) use
#'`retryonratelimit = TRUE` o programa continua rodando e espera
#' o limite passar.

rt <- search_tweets(
  "#stats", n = 250000, retryonratelimit = TRUE)

#' Filtrando buscas
# uscando por 10,000 tweets de origem Estadunidense e lingua inglesa.
rt <- search_tweets(
  "lang:en", #lingua
  geocode = lookup_coords("usa"), #localizacao
  n = 10000 # quantidade
  )

#' Criando variavel latitude/longitude utilizando os tweets coletado #nubank
rt <- lat_lng(rt)

#' Plotanto Estados americanos
par(mar = c(0, 0, 0, 0))
maps::map("state", lwd = .25)

#' plotando latidude e longitude dos tweets no mapa.
with(rt,points(lng, lat, pch = 20,
               cex = .75, col = rgb(0, .3, .7, .75)))

#' Aproximadamente 1% Tweets aleatórios em tempo real - 30 segundos
rt <- stream_tweets("")

#' tweets aleatórios em tempo real dos Estados Unidos - 60 segundos
rt <- stream_tweets(lookup_coords("usa"), timeout = 60)

# plotando no mapa
rt <- lat_lng(rt)
maps::map("state", lwd = .25)
with(rt,points(lng, lat, pch = 20,
               cex = .75, col = rgb(0, .3, .7, .75)))

#' tweets aleatórios mentionando o twitter de Donald trump
#' ou Trump durante uma semana e salvando em .json
#' interrompa o processo quando quiser
stream_tweets(
  "realdonaldtrump,trump",
  timeout = 60 * 60 * 24 * 7,
  file_name = "tweetsabouttrump.json",
  parse = FALSE
)

#' carregando o arquivo salvo acima e plotando no mapa.
djt <- parse_stream("tweetsabouttrump.json")
djt <- lat_lng(djt)
maps::map("state", lwd = .25)
with(djt,points(lng, lat, pch = 20,
               cex = .75, col = rgb(0, .3, .7, .75)))

##' Coletar contas que são seguidas pela página da CNN
cnn_fds <- get_friends("cnn")

# olhando as contas
cnn_fds_data <- lookup_users(cnn_fds$user_id)

#' Coletar contas que seguem a pagina da CNN
cnn_flw <- get_followers("cnn", n = 75000)

# olhando as contas
cnn_flw_data <- lookup_users(cnn_flw$user_id)

#' vendo quantos seguidores tem na conta da CNN
cnn <- lookup_users("cnn")

#' Extraindo da timeline
# Pegando 30 tweets mais citados da CNN, BBCWorld e Foxnews 
tmls <- get_timelines(c("cnn", "BBCWorld", "foxnews"), n = 3200)

# plotando a frequencia de tweet de cada conta
tmls %>%
  dplyr::filter(created_at > "2017-10-29") %>%
  dplyr::group_by(screen_name) %>%
  ts_plot("days", trim = 1L) +
  ggplot2::geom_point() +
  ggplot2::theme_minimal() +
  ggplot2::theme(
    legend.title = ggplot2::element_blank(),
    legend.position = "bottom",
    plot.title = ggplot2::element_text(face = "bold")) +
  ggplot2::labs(
    x = NULL, y = NULL,
    title = "Frequency of Twitter statuses posted by news organization",
    subtitle = "Twitter status (tweet) counts aggregated by day from October/November 2017",
    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
  )


#'Extrair os tweets mais favoritados
# 300 tweets mais recentes favoritados por JK Rowling

jkr <- get_favorites("jk_rowling", n = 300)

#' Buscar contas com #rstats na bios.
usrs <- search_users("#rstats", n = 100)

#'Extraindo Trends
# Trends em brasilia
bsb <- get_trends("Brasília")


#' Pesquisando usuarios

## Pesquisando usuarios por nome ou @
users <- c("KimKardashian", "justinbieber", "taylorswift13",
           "espn", "JoelEmbiid", "cstonehoops", "KUHoops",
           "upshotnyt", "fivethirtyeight", "hadleywickham",
           "cnn", "foxnews", "msnbc", "maddow", "seanhannity",
           "potus", "epa", "hillaryclinton", "realdonaldtrump",
           "natesilver538", "ezraklein", "annecoulter")

famous_tweeters <- lookup_users(users)

# preview dados dos usuarios
famous_tweeters

# extrair os tuites mais recentes de cada usuario
tweets_data(famous_tweeters)

#' Postando um tuite
post_tweet("my first rtweet #rstats")

#' Seguindo contas
post_follow("kearneymw")

