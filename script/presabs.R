# setup

library(tidyverse)

setwd("~/tesi/data/cluster")

csvPath <- "otus.csv"

outPath <- "../matrix/7famPresAbs.csv"

  
  
  
  
# /setup
  
  
# Load the CSV and only get the columns we need
raw<-read.csv(file=csvPath, stringsAsFactors = F)

# filter for the family we want

#families <-tolower(c("Ceratobasidiaceae", "Tulasnellaceae", "Inocybaceae", "Serendipitaceae", "Sebacinaceae", "Russulaceae", "Thelephoraeae"))

#filtRaw <-dplyr::filter(raw, Fun_family %in% families) %>%
#    dplyr::select("Orc_species", "otu", "lat", "lon")

filtRaw <- dplyr::select(raw, "Orc_species", "otu", "lat", "lon")
### If we want to have the otus

# Remove all rows without the otu (you shouldn't have any, but best to make sure)

funfam<- distinct(filtRaw) %>%

  drop_na(otu) %>%
  #remove rows without the family
  dplyr::filter(!otu=="") %>%
  #add presence column
  add_column(Present=1) %>% 
  pivot_wider(names_from=otu, values_from=Present) %>%
  replace(is.na(.), 0)

# Put the otus in alphabetical order while keeping Orc_species, lat and lon at the first positions

funfam <- funfam[,order(colnames(funfam))]

funfam <- relocate(funfam, Orc_species, lat, lon)

# Write the csv
write.csv(funfam, outPath, row.names = FALSE)
            