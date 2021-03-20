#!/usr/bin/env Rscript 
# SETTINGS

library(vegan)
library(tidyverse)
library(psych)
library(dplyr)
library(caret)
library(ggbiplot)
library(viridis)
library(tibble)
library(ggpubr)
library(factoextra)
setwd("~/tesi/FunModels/data/misc/")
dataPath <- "envVarWithFamilies.csv"

outTitle=""
# /SETTINGS


data <- read.csv(dataPath)

data <- drop_na(data)

datapc <- select(data, -family)

pc <- prcomp(datapc,center = T,scale. = T)


# Calculate the percentage of variance explained

# Compute the variance
pr_var <- pc$sdev^2

# See the proportion

prop_varex <- pr_var/sum(pr_var)

plot(prop_varex, col="#069a2e", main="Varianza spiegata", type='b', ylab = "Percentuale di varianza spiegata", xlab="Componente principale")

fviz_screeplot(pc, ncp=6,linecolor = "black", barfill  = "#069a2e", 
               barcolor ='black', xlab = "Dimensioni", 
               ylab = '% varianza',
               main = 'Riduzione dei componenti')



# Plot with points only
ggbiplot(pc, obs.scale = 1, var.scale = 1,
         groups = data$family, ellipse = FALSE, circle = F,ellipse.prob = 0.68) +
  geom_point()+
  theme(legend.direction = 'horizontal', legend.position = 'none')+
  ggtitle(outTitle)


# Plot with legend and colored by fungus family
ggbiplot(pc, obs.scale = 1, var.scale = 1,
         groups = data$family, ellipse = FALSE, circle = T,ellipse.prob = 0.68, var.axes=F) +
  theme(legend.direction = 'horizontal', legend.position = 'top')+
  ggtitle(outTitle)

# Plot with circles

ggbiplot(pc, obs.scale = 1, var.scale = 1,
         groups = data$family, ellipse = TRUE, circle = FALSE,ellipse.prob = 0.68, var.axes=F) +
  theme(legend.direction = 'horizontal', legend.position = 'top')+
  ggtitle(outTitle)

#dev.off()
#ggsave(plotOut)

# How much does each variable impact

a <- pc$rotation

a %>% as.data.frame %>% rownames_to_column %>%
  select(rowname, PC1, PC2) %>% arrange(desc(PC1)) %>% head(10)

f <- fviz_contrib(pc,
             choice = "var",
             axes = 2,
             top = 10, color = '#069a2e', barfill  = '#069a2e',fill ='#069a2e')

ggpar(f, main = "Contributi delle variabili alla PC2", ylab = "Contributo (%)")



# K-mean

res.km <- kmeans(scale(data[, -7]), 7, nstart = 25)

fviz_cluster(res.km, data = data[, -7],
             geom = "point",
             ellipse.type = "convex", 
             ggtheme = theme_bw()
)

# combine PCA

ind.coord <- as.data.frame(get_pca_ind(pc)$coord)
# Add clusters obtained using the K-means algorithm
ind.coord$cluster <- factor(res.km$cluster)
# Add Species groups from the original data sett
ind.coord$Species <- data$family
# Data inspection
head(ind.coord)

# Get the variance percentage

eigenvalue <- round(get_eigenvalue(pc), 1)
variance.percent <- eigenvalue$variance.percent

ggscatter(
  ind.coord, x = "Dim.1", y = "Dim.2", 
  color = "cluster", palette = "npg", ellipse = TRUE, ellipse.type = "convex",
  shape = "Species", size = 1.5,  legend = "right", ggtheme = theme_bw(),
  xlab = paste0("Dim 1 (", variance.percent[1], "% )" ),
  ylab = paste0("Dim 2 (", variance.percent[2], "% )" )
) +
  stat_mean(aes(color = cluster), size = 4)
