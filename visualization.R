library(tm)
library(wordcloud)
library(RColorBrewer)

setwd("D:/Skripsi/Data")

docs <- readLines("sentimen negatif.csv")
docs <- Corpus(VectorSource(docs))

docs <- tm_map(docs, removeWords, c("covid", "corona", "virus", "ini", "kita",
                                    "itu", "dan", "juga", "aja", "sudah", "lalu",
                                    "ada", "dari", "moga", "lagi", "aku", "yang",
                                    "dengan","gue","gak","jadi","tapi","buat","makin",
                                    "tau","udh","sih","kalo","bgt","buat","udah","bisa",
                                    "sama","orang","gin","indonesia","malah","nya",
                                    "dah","banget","pada","mana","emang","banyak","bikin",
                                    "baru","apa","mau","mudik","kek","gua","pas","karena",
                                    "bukan","kena","pas","masih","masuk","tahun","cuma",
                                    "lah","org","percaya","pake","kapan","negara","rumah",
                                    "semua","atau","kan","terus","dulu","gara","harus",
                                    "sekarang","hari","kelar","kok","boleh","mereka","gimana",
                                    "kalau","nih","kaya","bilang","nikah","lebih","tuh",
                                    "dia","kali","anak","kenapa","indo","liat","bener",
                                    "sampe","jalan","kerja","untuk","klo","tanggal","mah",
                                    "punya","positif","buka","mei","sehat"))

dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m), decreasing = TRUE)
d <- data.frame(word = names(v), freq = v)
head(d, 30)

#word cloud
set.seed(1000)
wordcloud(words = d$word, freq=d$freq, scale = c(3, 0.5), min.freq = 1,
          max.words = 25, random.order = FALSE, rot.per = 0.35,
          colors = brewer.pal(5, "Set1"))

#barplot
k <- barplot(d[1:20,]$freq, las = 2, names.arg = d[1:20,]$word,cex.axis = 1.2,cex.names = 1.2,
             main = "Most frequent words", ylab = "Word frequencies", col = terrain.colors(20))