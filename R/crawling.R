#menginstall library
install.packages(rtweet)

#mengaktifkan library
library(rtweet)

#mengautentikasi dengan API twitter
token <- create_token(
  app = "Crawling",
  consumer_key = "ksp6fVsFQKesaTEz292RSRTSi",
  consumer_secret = "Db488G9yIEiLXAThb5GojWIwntuGhLR3U6SYvUhIiPpT4330Jz",
  access_token = "1361137585653878784-fLm2Rus0Jbl6r9TWVwEfdpxM5dTCj7",
  access_secret = "AssMz8zWfKcwDk3vnfQ2vV2Aixi1dDwRzjPOiz1Nz6UjO"
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
             "crawling_30april.csv",
             prepend_ids = TRUE,
             na = "",
             fileEncoding = "UTF-8"
)
