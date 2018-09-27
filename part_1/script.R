

demographicData <- read.table(file = "dane_demograficzne_pl.csv", sep=";", dec=".", header=TRUE)
head(demographicData,10)


cat("srednia liczba ludności od 1949 do 2016")
cat(summary(demographicData$total))

plot(demographicData$total, demographicData$years)
