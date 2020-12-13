# If you plan on using this code from the command line, check instead  GBQuickSearch.R

library("rentrez")

# For testing purposes
#   args<-"DQ061874"


GBQuick <- function(gbcode){

r<-entrez_summary(db="nuccore", id=gbcode)

p<-entrez_link(dbfrom="nuccore", id=gbcode, db="all")

pub<-p$links$nuccore_pubmed

if(is.null(pub)){
  pub= 'No article found'
  
} else {
  
  pub=paste('https://www.ncbi.nlm.nih.gov/pubmed/?term=',pub, sep="")
}

gbl<-paste('https://www.ncbi.nlm.nih.gov/nuccore/', code sep="")

pubm<-entrez_summary(db="pubmed", id=p$links$nuccore_pubmed)

if(is.null(pubm)){
  pubm= 'No article found'
  
}

auth<-do.call(paste,pubm$authors[1])

cat('Title:', r$title, "\n", 'Organism: ', r$organism, "\n", 'PubMed: ', pubm$title, "\n", 'Authors: ', auth, "\n",pub, "\n", 'GenBank: ', gbl, "\n")

}
