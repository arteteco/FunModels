library(tidyverse)
library(dendextend)
library(ggplot)
library(clValid)



setwd("~/tesi/FunModels/data/misc/")
dataPath <- "envVarWithFamilies.csv"

outTitle=""
# /SETTINGS


data <- read.csv(dataPath)

data <- drop_na(data)

# Standardize the data

stand<- data %>% mutate_at(c('N', 'P', 'K', 'pH', 'MaxPrec', 'MinTemp'), ~(scale(.) %>% as.vector))

labels <- stand$family

stand <- select(stand, -family)

dist_mat <- dist(stand, method = 'euclidean')


hclust_avg <- hclust(dist_mat, method = 'average')

plot(hclust_avg)

cut_avg <- cutree(hclust_avg, k = 7)

avg_dend_obj <- as.dendrogram(hclust_avg)
avg_col_dend <- color_branches(avg_dend_obj, h = 7)
plot(avg_col_dend)

seeds_df_cl <- dplyr::mutate(data, cluster = cut_avg)

class(seeds_df_cl)

count(seeds_df_cl,"cluster")

# Plot in a stacked barplot

ggplot(seeds_df_cl, aes(fill=family, x=factor(cluster))) + 
  geom_bar(position='stack', stat='count')


# Dunn's Index
dunn(dist_mat, cut_avg)
