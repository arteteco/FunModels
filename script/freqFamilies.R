# setup
library(tidyverse)
library(ggplot2)

dataDir <- "~/tesi/FunModels/data/matrix/"
fileName <- "PresAbs.csv"

setwd(dataDir)


data <- read.csv(fileName)
names <- colnames(data)

names <- names[-c(1:3)] # Here i remove my first 3 columns, very specific for my dataset

for(i in (1:length(names))){
  names[i] <- substr(names[i], 1, 3) 
}


freqs <- as.data.frame(table(names), stringsAsFactors = F)
freqs <- mutate(freqs, family = case_when(names == "cer" ~ "Ceratobasidiace",
                                          names =="rus" ~ "Russulaceae",
                                          names =="ino" ~"Inocybaceae",
                                          names == "seb"~"Sebacinaceae",
                                          names == "ser" ~ "Serendipitaceae",
                                          names == "the" ~ "Theleophoraceae",
                                          names == "tul" ~ "Tulasnellaceae"))
freqs

ggplot(freqs, aes(x="", y=Freq, fill=family)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0) +
  geom_text(aes(label = paste0(Freq)), position = position_stack(vjust=0.5)) +
  labs(x = NULL, y = NULL, fill = NULL) + 
  scale_fill_brewer(palette="BrBG")+
  theme_void()
