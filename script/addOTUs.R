# setup

library(seqinr)
library(tidyverse)
library(stringr)
library(knitr)

setwd("~/tesi/data/cluster")

clusterToRead <- "7FamCluster.csv"
rawPath <- "../init/filtered.csv"
outFile <- "otus.csv"

# /setup


# get the data
cluster<-read.csv(clusterToRead, stringsAsFactors = FALSE)
colnames(cluster)[2] <- "GBAN"
raw<-read.csv(rawPath, stringsAsFactors = FALSE)

# Remove rows without any data on the family
raw <-dplyr::filter(raw,Fun_family != "")

# merge the two datasets
otus <- merge(cluster, raw, by="GBAN")

# create a df with only a few columns
otusOnly <- select(otus, cluster, Fun_family)

# create a data frame of corrispondence between cluster and otus name
otusd <- distinct(otusOnly)

# In case a OTU comprises more than one family, only keep one for naming

# otusd <- otusd[!duplicated(otusd$cluster),]

# create a correlation table
corrTable <- data.frame()


# get a correspondence table between OTU and family
for(f in unique(otusd$Fun_family)){
  oneFam <- filter(otusd, Fun_family==f)
  oneFam$ID <- 1:nrow(oneFam)
  withOtu <- mutate(oneFam, otu=paste(substr(Fun_family, 1,3),ID, sep=""))
  withOtu <- select(withOtu, -ID)
  corrTable <- rbind(corrTable, withOtu)
}

# Now add the OTU column to the original dataset based on a shared cluster as key

otus$otu <- corrTable$otu[match(otus$cluster,corrTable$cluster)]

write.csv(otus, outFile, row.names=F)



