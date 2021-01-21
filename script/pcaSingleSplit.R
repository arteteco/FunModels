#!/usr/bin/env Rscript 
# SETTINGS

library(vegan)
library(tidyverse)
library(psych)
library(caret)
library(ggbiplot)
setwd("~/tesi/FunModels/data/matrix/split/")

# /SETTINGS

# loop all the csv files and perform the pca



dataPath <- "the.csv"
plotOut <- paste(name, ".png", sep="")

name <- substr(dataPath, 1,3)
  # /SETTINGS
  
data <- read.csv(dataPath)
  
dataDist <- select(data, -c("lat","lon","population")) %>%
    na.omit()
  
  # remove columns without variance
  
  if (length(nearZeroVar(dataDist)) > 0) {
    dataDist <- dataDist[, -nearZeroVar(dataDist)] 
  }
  
  # partition the data set into training and testing data sets.
  
  #ind <- createDataPartition(dataDist$Orc_species,p=0.80,list = F)
  #train <- dataDist[ind,]
  #test <- dataDist[-ind,]
  train <- dataDist
  pc <- prcomp(train[,-1],center = T,scale. = T)
  
  #png(plotOut)
  ggbiplot(pc, obs.scale = 1, var.scale = 1,
           groups = train$Orc_species, ellipse = TRUE, circle = TRUE,ellipse.prob = 0.68) +
    scale_color_discrete(name = '') +
    theme(legend.direction = 'horizontal', legend.position = 'top')+
    ggtitle("Theleophoraceae")
  #dev.off()
  #ggsave(plotOut)


