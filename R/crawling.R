#menginstall library
install.packages(rtweet)

#mengaktifkan library
library(rtweet)

#mengautentikasi dengan API twitter
token <- create_token(
  app = "Crawling",
  consumer_key = "7S5yQbcyMx7bOLxkMeQbLWF0Q",
  consumer_secret = "JdsfBTnWuPEbQim3ZUdMuNUpaYfUtUgRPU0LdfLYPjLVFc5qwI",
  access_token = "1361137585653878784-yEek7Az1dc3tGgR7v3xucpR5VALwhy",
  access_secret = "qBPXNbmeHGGToIx6xyCubuiIwBWXN9bWGMgyYzNBAQtma"
)

#mendefinisikan variabel
jmltweet <- 2000
bahasa <- "id"
retweet <- FALSE

#search tweets
crawling <- search_tweets("corona",
                          n = jmltweet,
                          lang = bahasa,
                          include_rts = retweet,
                          type = "recent"
)

#melihat hasil crawling
View(crawling)

#menyimpan hasil crawling
write_as_csv(crawling,
             "datasentimen.csv",
             prepend_ids = TRUE,
             na = "",
             fileEncoding = "UTF-8"
)
