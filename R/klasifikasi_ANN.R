library(neuralnet)
library(caret)

getwd()
setwd("D:/R")

data <- read.csv("D:/R/hasil_transformation.csv",
                 stringsAsFactors = FALSE)
View(data)

#memisahkan variabel yang digunakan
data <- data[,1:290]
str(data)

#sampel acak
n <- round(nrow(data)*0.80);n
set.seed(12);
samp=sample(1:nrow(data),n)
head(samp)

#data partisi
train = data[samp,]
test = data[-samp,]

#mengambil nama variabel yang digunakan
feats <- names(data[,2:290])

#menggabungkan strings
f <- paste(feats,collapse=' + ')
f <- paste('Sentimen ~',f)

#mengubah variabel f ke dalam bentuk faktor
f <- as.formula(f);f

#fungsi aktivasi
sigmoid = function(g){
  1/( 1 + exp(-g))
}

#model artificial neural network (backpropagation)
nn <- neuralnet(f,train,
                hidden=c(10),
                algorithm = "backprop",
                learningrate = 0.05,
                act.fct = sigmoid,
                threshold = 0.01,
                linear.output=FALSE)

#deskriptif model
summary(nn)

#plot model
plot(nn)

#prediksi model
pred <- compute(nn, test[2:290])
results = data.frame(actual = test$Sentimen, prediction=pred$net.result)
results
prediksi = ifelse(pred$net.result[,1]<0.5, "Positif", "Negatif")
prediksi
results=data.frame(prediksi, actual = test$Sentimen)
results
table(results)

#confusion matrix
confusionMatrix(as.factor(prediksi), as.factor(test$Sentimen))

