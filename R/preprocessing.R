library(readxl)
library(NLP)
library(tm)
library(SnowballC)
library(katadasaR)
library(dplyr)
library(tokenizers)
library(tau)
library(parallel)

#melihat folder default
getwd()

#mengatur folder yang akan digunakan
setwd("D:/R")

#memanggil data teks yang akan dibersihkan
data = read_xlsx(path = "datasentimen.xlsx", sheet = "Sheet1", 
                          col_names = TRUE )
View(data)

#mengubah data dengan format csv ke dalam corpus
cleaning = data$Tweet
clean <- Corpus(VectorSource(cleaning))

#Tahap Cleansing
##menghapus URL
remove_URL <- function(x) gsub("http[^[:space:]]*","",x)
clean <- tm_map(clean,remove_URL)

##menghapus kurung
remove_pipe <- function(z) gsub("<[^>]+>","",z)
clean <- tm_map(clean, remove_pipe)

##menghapus mention
remove_mention <- function(z) gsub("@\\s+","",z)
clean <- tm_map(clean, remove_mention)

##menghapus hastag
remove_hastag <- function(z) gsub("#\\s+","",z)
clean <- tm_map(clean, remove_hastag)

##menghapus titik
remove_dot <- function(y) gsub("[[:punct:]]","",y)
clean <- tm_map(clean, remove_dot)

##menghapus nomor
remove_number <- function(y) gsub("[[:digit:]]","",y)
clean <- tm_map(clean, remove_number)

#Tahap Case Folding
clean <- tm_map(clean, content_transformer(tolower))

#Tahap Tokenizing
token_data <- function(x) NGramTokenizer(x, Weka_control(min=2, max=3))
dtm_data <- DocumentTermMatrix(clean, control = list(tokenize = token_data))
termFreqdata <- rowSums(as.matrix(dtm_data))
termFreqVectordata <- as.list(termFreqdata)
datatoken <- tm_map(clean, tokenize_words)

#Tahap Filtering
myStopword <- file("stopword_id.csv", open="r")
CmyStopword <- readLines(myStopword)
close(myStopword)
CmyStopword = c(CmyStopword, "amp")
clean <- tm_map(clean, removeWords, CmyStopword)

#Tahap Stemming
stem_text <- function(text, mc.cores=1)
{
  stem_string <- function(str)
  {
    str <- tokenize(x=str)
    str <- sapply(str, katadasaR)
    str <- paste(str, collapse = "")
    return(str)
  }
  x <- mclapply(X=text,FUN=stem_string,mc.cores = mc.cores)
  return(unlist(x))
}
clean <- tm_map(clean, stem_text)

#menghapus spasi berlebih
clean <- tm_map(clean, stripWhitespace)

#menyimpan data hasil preprocessing
dataframe <- data.frame(Tweet=unlist(sapply(clean, '[')), data$Sentimen,
                        stringsAsFactors = F)
View(dataframe)
write.csv(dataframe,file = "hasil_preprocessing.csv")