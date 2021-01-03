# setup
library(tidyverse)
library(ggplot2)

dataDir <- "~/tesi/FunModels/data/matrix/"
fileName <- "7famPresAbs.csv"

setwd(dataDir)


data <- read.csv(fileName)
names <- colnames(data)

names <- names[-c(1:3)] # Here i remove my first 3 columns, very specific for my dataset

for(i in (1:length(names))){
  names[i] <- substr(names[i], 1, 3) 
}

freqs
freqs <- as.data.frame(table(names), stringsAsFactors = F)

ggplot(freqs, aes(x="", y=Freq, fill=names)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0) +
  geom_text(aes(label = paste0(Freq)), position = position_stack(vjust=0.5)) +
  labs(x = NULL, y = NULL, fill = NULL) + 
  theme_void()
