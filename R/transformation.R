library(tm)
library(dplyr)

getwd()
setwd("D:/R")

#membaca data
data <- read.csv("D:/R/hasil_preprocessing.csv",
               stringsAsFactors = FALSE)
View(data)

#mengubah data ke dalam corpus
corpus <- Corpus(VectorSource(data$text))
inspect(corpus[1:3])

#membersihkan data yang tidak dibutuhkan
corpus.clean <- tm_map(corpus, tolower)
corpus.clean <- tm_map(corpus.clean, removeNumbers)
corpus.clean <- tm_map(corpus.clean, removeWords, stopwords())
corpus.clean <- tm_map(corpus.clean, removePunctuation)
corpus.clean <- tm_map(corpus.clean, stripWhitespace)

#membuat document term matrix
dtm <- DocumentTermMatrix(corpus.clean)
inspect(dtm[40:50, 1:10])

#mengurangi fitur yang jarang muncul
adtm <- removeSparseTerms(dtm, 0.99)

#membuat matrix TF-IDF
dtm_matrix = weightTfIdf(adtm, normalize = TRUE)
adtm.label = cbind(dtm_matrix, data$Sentimen)
dtmtfidf = as.matrix(adtm.label)
dtmtfidftrain.df = as.data.frame(dtmtfidf)
inspect(dtm_matrix[40:50, 1:10])

#menyimpan data hasil TF-IDF
write.csv(dtmtfidftrain.df, file = "hasil_transformation.csv")
