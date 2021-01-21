# setup

library(tidyverse)
setwd("~/tesi/FunModels/data/matrix")

# starting values df, with environmental variables
matrPath <- "values.csv"

# folder to output the splitted csvs. Leave empty if you want them in the same folder
splitPath <- "split/"


# /setup


matr <- read.csv(matrPath)

# To assign a unique name to rows alphabetically
letterwrap <- function(n, depth = 1) {
  args <- lapply(1:depth, FUN = function(x) return(letters))
  x <- do.call(expand.grid, args = list(args, stringsAsFactors = F))
  x <- x[, rev(names(x)), drop = F]
  x <- do.call(paste0, x)
  if (n <= length(x)) return(x[1:n])
  return(c(x, letterwrap(n - length(x), depth = depth + 1)))
}

# Add a column population with the letters
matrLett <- letterwrap(nrow(matr))
matr$population <- matrLett 


# SPLIT


lista<- tolower(c("cer", "tul", "ino", "ser", "seb", "rus", "the"))

for (f in lista){
  kick <- subset(lista, !(lista == f))
  NMatr <- select(matr, !starts_with(kick))
  
  # Remove all rows where there is just 0 for the presence of that family, ie, no recorded presence
  NMatr <- NMatr %>% 
    dplyr::mutate(sumVar = rowSums(dplyr::select(., contains(f))))%>%
    filter(sumVar>0) %>%
    select(-sumVar)
  
  # assign the variable
  
  assign(f, NMatr)
  write.csv(x=NMatr, file=paste(splitPath, f, ".csv", sep=""), row.names=FALSE)
}

