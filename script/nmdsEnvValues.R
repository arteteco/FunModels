 
# settings

library(vegan)
library(tidyverse)
setwd("~/tesi/FunModels/data/misc/")
dataPath <- "envVarWithFamilies.csv"
#outPath <- "lump.jpg" # output graph
outTitle <- ""

# /settings


data <- read.csv(dataPath)

data <- drop_na(data)

grp <-data$family


# Read in species matrix AND grouping variabl es

data <- select(data, -family)

dataMDS <-
  metaMDS(data,
          distance = "euclidean",
          k = 3,
          maxit = 999, 
          trymax = 500,
          na.rm=T)


dataMDS

stressplot(dataMDS)

# plot 02


datascores <- as.data.frame(scores(dataMDS))

scores <- cbind(as.data.frame(datascores), grp = grp)

centroids <- aggregate(cbind(NMDS1, NMDS2) ~ grp, data = scores, FUN = mean)

seg <- merge(scores, setNames(centroids, c('grp','oNMDS1','oNMDS2')),
             by = 'grp', sort = FALSE)

ggplot(scores, aes(x = NMDS1, y = NMDS2, colour = grp)) +
  #geom_segment(data = seg,
  #             mapping = aes(xend = oNMDS1, yend = oNMDS2)) + # add spiders
  geom_point(data = centroids, size = 4) +                    # add centroids
  geom_point() +                                              
  coord_fixed()+                                              
  theme_bw()+ 
  #geom_path(size=1, linetype=1)+
  stat_ellipse()
  theme(legend.position="right",legend.text=element_text(size=10),legend.direction='vertical')+
  ggtitle(outTitle)
# adds encircle
#  geom_path(size=1, linetype=2)
# annotate("text",x=NMDS.mean$MDS1,y=NMDS.mean$MDS2,label=NMDS.mean$group)
