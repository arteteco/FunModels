# setup

library(tidyverse)
setwd("~/Documents/uni/tesi/data/init/")

data <- read.csv("complete.csv", sep="\t")

OMF<- tolower(c("Ceratobasidiaceae", "Tulasnellaceae", "Inocybaceae", "Serendipitaceae", "Sebacinaceae", "Russulaceae", "Thelephoraceae"))

#lista<- tolower(c("Serendipitaceae", "Sebacinaceae"))

data$Fun_family <- tolower(data$Fun_family)

raw <- dplyr::filter(data, Fun_family %in% OMF)

write.csv(raw, "raw.csv", row.names = F)

