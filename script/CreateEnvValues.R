# SETTING

library(tidyverse)

setwd("~/tesi/FunModels/data/")

# Data set with the values and the presence absence matrix
values <- read.csv("matrix/values.csv")

# Data set with the otus and all the lat, lon etc
otus <- read.csv("cluster/otus.csv")

# We don't need all the values from "values", we are only going to keep the following
keepFromValues <- c("Orc_species", "lat", "lon", "N", "P", "K", "pH", "MaxPrec", "MinTemp")

# We don't need anything from envOtu, this is what we are going to keep
keepFromEnvOtus <- c("N", "P", "K", "pH", "MaxPrec", "MinTemp", "otu")

# Output file name
outName <- "misc/envVarWithFamilies.csv"

# / SETTING

onlyValues <- select(values, all_of(keepFromValues))

# This new data frame will have the environmental variables appended at the end
envOtu <- merge(otus, onlyValues)


selected <- select(envOtu, all_of(keepFromEnvOtus))

# we don't need to know what OTU is that, we only need the group
# We are substringing at the first 3 letters

final <- mutate(selected, family = substr(otu, 1,3)) %>%
  select(-otu) %>%# Remove the otus, we don't need them anymore
  distinct() # remove duplicate rows

write.csv(final, outName, row.names = F)


