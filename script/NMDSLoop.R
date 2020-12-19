# SETTINGS

library(vegan)
library(tidyverse)

# all the csv in this folder will be looped
setwd("~/tesi/FunModels/data/matrix/split")

# /SETTINGS



files <- list.files(".", pattern = "*.csv")

for(f in files){

# extract the first 3 letters from the filename
name <- substr(f, 1,3)

dataPath <- f
outPath <- paste(name, ".jpg", sep="") # output graph
outTitle <- name

data <- read.csv(dataPath)
grp <- data

# Read in species matrix AND grouping variables

dataDist <- select(data, -c("lat","lon","Orc_species", "population"))

# standardize the data. Skip in case of negative values

# dataRel <- decostand(data, method = "total")

# to avoid missing too many rows with na.rm, replace NAs with the mean of the column. We'd lose about 1/3 of the data otherwise

#for(i in 1:ncol(data)){
#  data[is.na(data[,i]), i] <- mean(data[,i], na.rm = TRUE)
#}

# Distance Matrix

dataDist <- 
  vegdist(dataDist, method = "euclidean", na.rm=T)

dataDist <- 
  as.matrix(dataDist, labels = T, na.rm=T)


# NMDS

dataMDS <-
  metaMDS(dataDist,
          distance = "euclidean",
          k = 3,
          maxit = 999, 
          trymax = 500,
          wascores = F)


dataMDS
stressplot(dataMDS)


# Plotting the data

plot(dataMDS, "sites", type="t")

colv <- c("green", "gray0", "red", "blue")

symv <- c(21,22,23,24)

png(outPath)
plot(dataMDS, main=outTitle)

with(grp,
     points(dataMDS,
            display = "sites",
            col = "black",
            pch = symv[Orc_species],
            bg = colv[Orc_species]))

#Create convex hulls that highlight point clusters based on grouping dataframe
ordihull(
  dataMDS,
  grp$Orc_species,
  display = "sites",
  draw = c("polygon"),
  col = NULL,
  border = colv,
  lty = c(1, 2, 1, 2),
  lwd = 2.5
)

# Calculating centroids 

# Calculating and plotting centroids of NMDS Result
scrs <- scores(dataMDS, display = "sites", "species")
cent <- aggregate(scrs ~ Orc_species, data = grp, FUN = "mean")

names(cent) [-1] <- colnames(scrs)

points(cent [,-1],
       pch = c( 8 , 8 , 8, 8),
       col = colv,
       bg = c("black"),
       lwd = 3.0,
       cex = 2.0 # Plots centroids as points on ordination
)
dev.off()
}
