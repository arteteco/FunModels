library(vegan)
library(tidyverse)
library(psych)
library(caret)
library(ggbiplot)

# SETTINGS
setwd("~/tesi/FunModels/data/matrix/")

dataPath <- "lump.csv"
plotOut <- paste(substr(dataPath, 1,3), ".png", sep="")

# /SETTINGS



data <- read.csv(dataPath)

dataDist <- select(data, -c("lat","lon","population")) %>%
  na.omit()

# remove columns without variance

#if (length(nearZeroVar(dataDist)) > 0) {
#  dataDist <- dataDist[, -nearZeroVar(dataDist)] 
#}

# partition the data set into training and testing data sets.

#ind <- createDataPartition(dataDist$Orc_species,p=0.80,list = F)
#train <- dataDist[ind,]
#test <- dataDist[-ind,]



train <- dataDist
pc <- prcomp(train[,-2],center = T,scale. = T)

summary(pc)
#png(plotOut)
ggbiplot(pc, obs.scale = 1, var.scale = 1,
         groups = train$Orc_species, ellipse = TRUE, circle = TRUE,ellipse.prob = 0.68) +
  scale_color_discrete(name = '') +
  theme(legend.direction = 'horizontal', legend.position = 'top')
#dev.off()

