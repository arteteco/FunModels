# settings

library(vegan)
library(tidyverse)
setwd("~/tesi/FunModels/data/matrix/split/")
dataPath <- "cer.csv"
#outPath <- "lump.jpg" # output graph
outTitle <- "Lumped"

# /settings


data <- read.csv(dataPath)



# Read in species matrix AND grouping variables

dataDist <- select(data, -c("lat","lon","Orc_species", "population"))



# standardize the data. Skip in case of negative values

# dataRel <- decostand(data, method = "total")

# to avoid missing too many rows with na.rm, replace NAs with the mean of the column. We'd lose about 1/3 of the data otherwise

#for(i in 1:ncol(data)){
#  data[is.na(data[,i]), i] <- mean(data[,i], na.rm = TRUE)
#}

# Distance Matrix

#dataDist <- 
#  vegdist(dataDist, method = "euclidean", na.rm=T)

#dataDist <- 
#  as.matrix(dataDist, labels = T, na.rm=T)

#dataDist
# NMDS

dataMDS <-
  metaMDS(dataDist,
          distance = "euclidean",
          k = 3,
          maxit = 999, 
          trymax = 500,
          na.rm=T)


dataMDS

stressplot(dataMDS)

# plot 02

grp <-data[,1]
datascores <- as.data.frame(scores(dataMDS))

scores <- cbind(as.data.frame(datascores), Orchid = grp)

centroids <- aggregate(cbind(NMDS1, NMDS2) ~ Orchid, data = scores, FUN = mean)

seg <- merge(scores, setNames(centroids, c('Orchid','oNMDS1','oNMDS2')),
             by = 'Orchid', sort = FALSE)

ggplot(scores, aes(x = NMDS1, y = NMDS2, colour = Orchid)) +
  geom_segment(data = seg,
             mapping = aes(xend = oNMDS1, yend = oNMDS2)) + # add spiders
  geom_point(data = centroids, size = 4) +                    # add centroids
  geom_point() +                                              
  coord_fixed()+                                              
  theme_bw()+ 
  theme(legend.position="right",legend.text=element_text(size=10),legend.direction='vertical')+
  ggtitle("Ceratobasidiaceae")
# adds encircle
#  geom_path(size=1, linetype=2)
# annotate("text",x=NMDS.mean$MDS1,y=NMDS.mean$MDS2,label=NMDS.mean$group)
