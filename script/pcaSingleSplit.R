#!/usr/bin/env Rscript 
# SETTINGS

library(vegan)
library(tidyverse)
library(psych)
library(caret)
library(ggbiplot)
setwd("~/tesi/FunModels/data/matrix/split")
dataPath <- "ser.csv"

outTitle="Serendipitaceae"
# /SETTINGS

name <- substr(dataPath, 1,3)

plotOut <- paste(name, ".png", sep="")

# /SETTINGS
  
data <- read.csv(dataPath)
  
dataDist <- select(data, -c("lat","lon","population")) %>%
    na.omit()
  
  # remove columns without variance
  
if (length(nearZeroVar(dataDist)) > 0) {
    dataDist <- dataDist[, -nearZeroVar(dataDist)] 
}
  
train <- dataDist
pc <- princomp(train[,-1],center = T,scale = T)
  #pc <- prcomp(train[,-1],center = T,scale. = T)
  #png(plotOut)
  ggbiplot(pc, obs.scale = 1, var.scale = 1,
           groups = train$Orc_species, ellipse = TRUE, circle = TRUE,ellipse.prob = 0.68) +
    scale_color_discrete(name = '') +
    theme(legend.direction = 'horizontal', legend.position = 'top')+
    ggtitle(outTitle)
  #dev.off()
  #ggsave(plotOut)


loadings(pc)

