# SETUP
library(Hmsc) 
library(corrplot)
library(tidyverse)
library(snow)


setwd("~/tesi/FunModels/data/matrix/")

# dataset
alldat = read.csv("lump.csv")

alldat <- drop_na(alldat)

# Where should it save the RData once the MCMC is done?

rdat<- "HmscLump.RData"

# Where should it save the beta file

betaOut <- "HMSC_Beta_Lump.csv"

# Where should it save the final results

finalResult <- "HMSC_OmegaCor_Lump.csv"

# choose the column with the environmental variables
EnvToKeep <- c("N","P","K", "pH", "MaxPrec", "MinTemp")

# select columns that have the presence absence data

PresAbs <- c("cer", "tul", "ino", "ser", "seb", "rus", "the")

#/ SETUP


# here you select the columns that contain the environmental variables, which Hmsc calls XData
XData <- select(alldat, all_of(EnvToKeep))

#this is the formula we will use to describe the environment
XFormula = ~ N+P+K+pH+MinTemp+MaxPrec

#select these columns for the is the presence-absence matrix of the OMF co-occurrences
Y = select(alldat, all_of(PresAbs))

#these are the random variables, for this study we use orchid species to control for variation in OMF according 
#to orchid species 
#and population to control for population-level variation

studyDesign = data.frame(species = alldat$Orc_species, population = alldat$population)
head(studyDesign)
rL_species = HmscRandomLevel(units = studyDesign$species)
rL_population = HmscRandomLevel(units = studyDesign$population)

# this is the basic Hmsc model. We use "probit" regression as we have PA data
m = Hmsc(Y=as.matrix(Y), XData = XData, XFormula = XFormula, 
         studyDesign = studyDesign, distr = "probit", ranLevels = list(species = rL_species, population = rL_population))

#######settings to run the model i.e. to sample the posterior distribution, 
# 3 independent chains each of 250.000 iterations (500 thin * 500 samples) is a good approach
thin = 500
samples = 500
nChains = 3
adaptNf = ceiling(0.4*samples*thin) 
transient = ceiling(0.5*samples*thin)

m1 = sampleMcmc(m, samples = samples, thin = thin,
                adaptNf = rep(adaptNf, m$nr), transient = transient,
                nChains = nChains, nParallel = nChains)


# MultiThread it

#m1func <- function(){
#  sampleMcmc(m, samples = samples, thin = thin,
#              adaptNf = rep(adaptNf, m$nr), transient = transient,
#              nChains = nChains, nParallel = nChains)
#   
# }

#cl <- parallel::makeCluster(parallel::detectCores()-1, type="FORK")

#parallel::clusterCall(cl=cl, fun=m1func)

# the model takes a while to run, sometimes a few hours depending on the size of the dataset,
#it is best to save this so you don't have to re-run it
save(m1, file = rdat)

#load(rdat)


#examining model fit - important for interpreting model outputs
#preds = computePredictedValues(m1)

#MF = evaluateModelFit(hM = m1, predY = preds)
#MF
#write.csv(MF, file = "Hmsc_Lump_ModelFit.csv")

#Gelman diagnostics are useful for model fit - the intercept for each variable. We are looking for point estimates near 1.
mpost = convertToCodaObject(m1)
gelman.diag(mpost$Beta, multivariate = FALSE, autoburnin = FALSE)$psrf

summary(mpost$Beta)
effectiveSize(mpost$Beta)
es.beta = effectiveSize(mpost$Beta)

#extract beta values
mbeta = getPostEstimate(m1, "Beta")
mbeta
write.csv(mbeta, file = betaOut)

#a cool way to look at how each environmental variable affects each OMF group 
postBeta = getPostEstimate(m1, parName = "Beta")
plotBeta(m1, post = postBeta, param = "Support" , supportLevel = 0.95, split = 0.5, mar = c(6, 1, 2, 1), spNamesNumbers = c(T,F))

#This is the juicy part - the residual correlations i.e., the relationships that exist between taxa beyong the influence of their shared 
#environments. Blue means they are negative (i.e., competitive), red means they are positive (i.e. positive)

OmegaCor = computeAssociations(m1)

#We are only interested in interactions that have high levels of posterior statistical support >0.85. 
#You can change this value and re-plot the graph accordingly.
supportLevel = 0.85
supportLevel = 0.9
supportLevel = 0.95

#to plot the result, we use this script. You can save the image as a png or pdf (better) in RStudio
par(mfrow = c(1,1))
plotOrder = 1:m1$ns
toPlot = ((OmegaCor[[1]]$support>supportLevel) + (OmegaCor[[1]]$support<(1-supportLevel))>0)*OmegaCor[[1]]$mean
rownames(toPlot)=colnames(toPlot)=gsub("_"," ",rownames(toPlot)) 
corrplot(toPlot[plotOrder,plotOrder], type="lower", tl.cex=.7, tl.col="black",tl.srt=45, method = "color", col=colorRampPalette(c("blue3","white","red3"))(200), title=expression("Plot level"), cl.cex=.7, mar=c(0,0,1,0))

#save the data as a csv file
write.csv(OmegaCor, file = finalResult)

