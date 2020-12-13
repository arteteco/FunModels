# setup
library(tidyverse)

setwd("~/tesi/FunModels/data/matrix")

# path of the original matrix with the values

matrPath <- "values.csv"
outPath <- "lump.csv"
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

ff <- matr

lista<- tolower(c("cer", "tul", "ino", "ser", "seb", "rus", "the"))

# here we are creating a new column with a value 0-1 if that family is present in that site

for(c in lista){
  # create the new column and make it a sum of the row for that family
  tmp <- matr %>% 
    mutate(!!c := rowSums(select(., starts_with(c))))
  
  # substitute with 0 or 1
  for(i in 1:nrow(tmp)){
    if(tmp[i, ncol(tmp)] > 0){
      tmp[i, ncol(tmp)] <- 1
    }
  }
  
  ff <- merge(ff, tmp, all=T)
}

# discard all otus

envvar <- c("N", "P", "K", "pH", "MinTemp", "MaxPrec")
keep <- c("Orc_species", "lat", "lon", "population", lista, envvar)

ff <- select(ff, all_of(keep))

write.csv(ff,outPath)
