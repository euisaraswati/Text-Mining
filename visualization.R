library(tm)
library(wordcloud)
library(RColorBrewer)

setwd("D:/Skripsi")

docs <- readLines("sentimen positif.csv")
docs <- Corpus(VectorSource(docs))

#hapus kata yang kurang berpengaruh
docs <- tm_map(docs, removeWords, c("covid", "corona", "virus", "ini", "kita",
                                    "itu", "dan", "juga", "aja", "sudah", "lalu",
                                    "ada", "dari", "moga", "lagi", "aku", "yang", "dengan"))

dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m), decreasing = TRUE)
d <- data.frame(word = names(v), freq = v)
head(d, 20)

#word cloud
set.seed(1000)
wordcloud(words = d$word, freq=d$freq, scale = c(3, 0.5), min.freq = 1,
          max.words = 25, random.order = FALSE, rot.per = 0.35,
          colors = brewer.pal(5, "Set1"))

#barplot
k <- barplot(d[1:20,]$freq, las = 2, names.arg = d[1:20,]$word,cex.axis = 1.2,cex.names = 1.2,
             main = "Most frequent words", ylab = "Word frequencies", col = terrain.colors(20))
