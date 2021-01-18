# setup

setwd("~/tesi/FunModels/data/matrix/env/points/")
rawPath <- "~/tesi/FunModels/data/matrix/PresAbs.csv"
outPath <- "~/tesi/FunModels/data/matrix/values.csv"

# /setup


files <- list.files(path=".", pattern="*.csv$", full.name=TRUE, all.files=TRUE)

tot<-read.csv(rawPath)

for(f in files){
  var<-read.csv(f)
  col <- rev(var)[1]
  tot <- cbind(tot, col)
}

write.csv(tot, outPath, row.names = F)
