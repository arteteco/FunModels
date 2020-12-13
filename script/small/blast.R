#!/usr/bin/env Rscript

library(rentrez)
library(annotate)

c = commandArgs(trailingOnly=TRUE)

c <- "EF100192"
r<-entrez_summary(db="nuccore", id=c)
r_fasta <- entrez_fetch(db="nuccore", id=r$uid, rettype="fasta")

r_fasta

test <- blastSequences(c,hitListSize=8, as="data.frame",oot=120)



EF100192
