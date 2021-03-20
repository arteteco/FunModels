library(vegan)
library(tidyverse)
library(viridis)
setwd("~/tesi/FunModels/data/matrix/lump/")
dataPath <- "lump.csv"
#outPath <- "lump.jpg" # output graph
outTitle <- ""

# /settings


data <- read.csv(dataPath)

data <- drop_na(data)

dataDist <- select(data, -c("lat","lon","Orc_species", "population", "N", "P", "K", "pH", "MaxPrec", "MinTemp"))

dataMDS <-
  metaMDS(dataDist,
          distance = "euclidean",
          k = 3,
          maxit = 999, 
          trymax = 500,
          na.rm=T)


dataMDS

stressplot(dataMDS)


grp <-data[,1]
datascores <- as.data.frame(scores(dataMDS))

scores <- cbind(as.data.frame(datascores), Orchid = grp)

centroids <- aggregate(cbind(NMDS1, NMDS2) ~ Orchid, data = scores, FUN = mean)

seg <- merge(scores, setNames(centroids, c('Orchid','oNMDS1','oNMDS2')),
             by = 'Orchid', sort = FALSE)

ggplot(scores, aes(x = NMDS1, y = NMDS2, colour = Orchid)) +
#  geom_segment(data = seg,
#               mapping = aes(xend = oNMDS1, yend = oNMDS2)) + # add spiders
#  geom_point(data = centroids, size = 4) +                    # add centroids
  geom_point() +                                              
  coord_fixed()+                                              
  theme_bw()+ 
  theme(legend.position="right",legend.text=element_text(size=10),legend.direction='vertical')+
  ggtitle(outTitle)

