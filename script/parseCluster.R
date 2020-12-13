library(sp)
library(tidyverse)
library(stringr)
library(knitr)


setwd("~/Documents/uni/tesi/FunModels/data/7fam")

# This script is to parse the cluster file produced by CDhit, http://weizhong-lab.ucsd.edu/cdhit_suite/cgi-bin/index.cgi
# It's going to be the .clstr file.


clstr <- read.csv("7fam.clstr", sep = "\t", row.names = NULL, header = FALSE, stringsAsFactors = FALSE)

clstr2 <- clstr

n = nrow(clstr)
x = 0

numbers_only <- function(x) !grepl("\\D", x)
for (row in c(1:n)) {
  if (numbers_only(clstr2[row,1]) == TRUE) {
    clstr2[row,1] <- x}
  else {NULL}
  x <- clstr2[row,1]
}

clstr.sums <- data.frame(dplyr::count(clstr2,V1))
kable(head(clstr.sums))

switch <- clstr.sums[1,2]

clstr3 <- cbind(clstr2[1], clstr)


colnames(clstr3)[1] <- "V0"

clstr4 <- select(clstr3, "V0", "V2")

clstr4 <- filter(clstr4, V2!="")

# Make sure you have "nt", otherwise substitute the string
clstr5 <- clstr4
clstr5[] <- lapply(clstr5, gsub, pattern='>', replacement='')
clstr5.2 <- data.frame(str_split_fixed(clstr5$V2, "nt, ", 2))
clstr5.3 <- data.frame(str_split_fixed(clstr5.2$X2, "... ", 2))
clstr6 <- cbind(clstr5[1],clstr5.2[1],clstr5.3[1:2])
colnames(clstr6) <- c("cluster","nt","gene","stat")

clstr6 <- select(clstr6, cluster, gene)

clstr6<-mutate_if(clstr6,is.factor, as.character)

write.csv(clstr6, "7FamCluster.csv", row.names = F)
