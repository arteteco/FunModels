# setup

setwd("~/tesi/data/matrix/env/points")
rawPath <- "../../7famPresAbs.csv"
outPath <- "values.csv"

# /setup


files <- list.files(path=".", pattern="*.csv$", full.name=TRUE, all.files=TRUE)

tot<-read.csv(rawPath)

for(f in files){
  var<-read.csv(f)
  col <- rev(var)[1]
  tot <- cbind(tot, col)
}

View(tot)

write.csv(tot, outPath, row.names = F)
