# Wordcloud2 com Shopee
library(rtweet)
library(tidyverse)

# 20.000 ou quase, tweets pela manhã do dia 07/07
rt <- search_tweets("Shopee",
                    lang = "pt-br", #lingua
                    n = 20000,# quantidade
                    include_rts = FALSE,
                    retryonratelimit = TRUE
    )

save(rt, file = "shopee.Rdata")


# limpando
rt$text <- gsub("https\\S*", "", rt$text) 
rt$text <- gsub("@\\S*", "", rt$text) 
rt$text <- gsub("amp", "", rt$text)
rt$text <- gsub("[\r\n]", "", rt$text)
rt$text <- gsub("[[:punct:]]", "", rt$text)

# apenas um usuario
txt <- distinct(rt, user_id, .keep_all = TRUE)

# criando df
library(tidytext)
palavras <- txt %>%
  select(text) %>%
  unnest_tokens(word,text)

# contando
palavras_freq <- palavras %>% count(word, sort=TRUE)


# filtrando para as palavras maiores
tweets <- palavras_freq %>% filter(nchar(word) > 3,
                                   word != "shopee", #outlier
                                   n > 100)

# plotando, e salvando manualmente
wordcloud2(tweets,color = "white", backgroundColor = "#FF6600")

# twittando
post_tweet("Reação do Twitter sobre a promoção 07/07 da Shopee. A nuvem de palavra representa as palavras mais reproduzidas nos tweets durante o dia. #Rstats #Shopee", media = "shopee.png")
