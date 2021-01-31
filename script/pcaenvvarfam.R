#!/usr/bin/env Rscript 
# SETTINGS

library(vegan)
library(tidyverse)
library(psych)
library(caret)
library(ggbiplot)
setwd("~/tesi/FunModels/data/misc/")
dataPath <- "envVarWithFamilies.csv"

outTitle=""
# /SETTINGS


data <- read.csv(dataPath)

data <- drop_na(data)

datapc <- select(data, -family)



pc <- prcomp(datapc,center = T,scale. = T)




ggbiplot(pc, obs.scale = 1, var.scale = 1,
         groups = data$family, ellipse = TRUE, circle = TRUE,ellipse.prob = 0.68) +
  scale_color_discrete(name = '') +
  theme(legend.direction = 'horizontal', legend.position = 'top')+
  ggtitle(outTitle)
#dev.off()
#ggsave(plotOut)


