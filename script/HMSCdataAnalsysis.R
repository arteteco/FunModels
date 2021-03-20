# Data explorer for the Hmsc analysis

# SETUP
library(Hmsc) 
library(corrplot)
library(tidyverse)
library(snow)

setwd("~/tesi/FunModels/data/matrix/noSingle")

fileName <- "Hmsc500.RData"
envTitle <-"All families"
corrTitle <-envTitle

betaOut <- "HMSC_Beta_total.csv"
# /SETUP

load(fileName)
#Gelman diagnostics are useful for model fit - the intercept for each variable. We are looking for point estimates near 1.
mpost = convertToCodaObject(m1)
gelman.diag(mpost$Beta, multivariate = FALSE, autoburnin = FALSE)$psrf

summary(mpost$Beta)
effectiveSize(mpost$Beta)
es.beta = effectiveSize(mpost$Beta)

#extract beta values
mbeta = getPostEstimate(m1, "Beta")

write.csv(mbeta, file = betaOut)

#a cool way to look at how each environmental variable affects each OMF group 
postBeta = getPostEstimate(m1, parName = "Beta")
plotBeta(m1, post = postBeta, param = "Support" , supportLevel = 0.85, split = 0.5, mar = c(6, 1, 2, 1), spNamesNumbers = c(T,F), main=envTitle)

#This is the juicy part - the residual correlations i.e., the relationships that exist between taxa beyong the influence of their shared 
#environments. Blue means they are negative (i.e., competitive), red means they are positive (i.e. positive)

OmegaCor = computeAssociations(m1)

#We are only interested in interactions that have high levels of posterior statistical support >0.85. 
#You can change this value and re-plot the graph accordingly.

supportLevel = 0.85

#to plot the result, we use this script. You can save the image as a png or pdf (better) in RStudio
par(mfrow = c(1,1))
plotOrder = 1:m1$ns
toPlot = ((OmegaCor[[1]]$support>supportLevel) + (OmegaCor[[1]]$support<(1-supportLevel))>0)*OmegaCor[[1]]$mean
rownames(toPlot)=colnames(toPlot)=gsub("_"," ",rownames(toPlot)) 
corrplot(toPlot[plotOrder,plotOrder], type="lower", tl.cex=.7, tl.col="black",tl.srt=45, method = "color", col=colorRampPalette(c("blue3","white","red3"))(200), title=corrTitle, cl.cex=.7, mar=c(0,0,1,0))

#save the data as a csv file
write.csv(OmegaCor, file = "HMSC_OmegaCor_total.csv")

#how is variance partitioned for each OTU
VP = computeVariancePartitioning(m1)
vals = VP$vals
mycols = rainbow(nrow(VP$vals))
par(xpd = T)
plotVariancePartitioning(hM=m1, VP=VP,cols = mycols, 
                         args.leg=list(bg="white",cex=0.25),
                         cex.main=0.25, legend.text = NULL, main=NULL, las=2, xlab="OTU")

?plotVariancePartitioning()
