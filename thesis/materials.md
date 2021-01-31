## The database

Data from bibliography regarding the distribution of OMFs in Europe was collected into a starting database. The data had to be of fungi isolated from known orchid roots, and had to be georeferenced at the very least with the name of a close enough place; also, each sample had to have a genbank accession code in order to get the sequences and do the analysis.
Only sequences from well-known OMFs were considered, that is: Ceratobasidiaceae, Tulasnellaceae, Inocybaceae, Serendipitaceae, Sebacinaceae, Russulaceae and Thelephoraceae [#dearnaley2012]
For each point six variables were extracted by using the ESDAC database [#esdac] and the World Clim database [#worldclim]: Nitrogen, Potassium and Phosphorus soil content, soil pH, minimum temperature of the coldest quarter and maximum precipitation of the wettest month. Those variables were selected because there is evidence that mycorrhizal fungi are very sensitive to nutrients in the soil: Nitrogen, Phosphorus and Potassium in high quantities (such as in eutrophicated soils because of agricultural fertilizers) have been seen to cause decline in the belowground mycorrhizal fungi species richness and cause dramatic changes in the community composition and structure [#lilleskov2002, baar2002, grant2011]. Mycorrhizal fungi growth and community composition also seem to be influenced by the soil pH [#aarle2002, carrino-kyker2016], temperature and precipitation [#rillig2003]. That's not all though: those variables may serve as important proxy for other conditions. Biomes and vegetation are correlated with the environmental condition, both because they change said conditions (like soil pH) and because all species have a range of tolerance. Also, human impact can often be seen by the amount of chemicals in the soil, especially close to cultivated fields.
Environmental values were extracted using `GDAL`'s `Sample Raster Values` tool (Using QGIS v. 3.16 as a GUI) and appended to the dataset

## Phylogenetic analysis

In order to understand the distribution and ecology of the OMFs we need to get a better insight of their phylogenesis. The hypothesis was for sequences of the same family to be clustered together, with some doubts with the Sebacinales as Serendipitaceae and Sebacinaceae are very close and only recently named so [#weiss2016a].
The phylogenetic analysis were performed on the sequences deposited by the papers included in the database.
The **primers** used were mainly ITS1F, ITS4, ITS3 and ITS4OF, all targeting **regions** between the 18S rRNA subunit and the 28S rRNA subunit, including the Internal Transcribed Spacers (ITS hereafter) 1 and ITS 2. Those primers were usually universal for *Basidiomycota* or in some cases more specific for *Tulasnellaceae* (like ITS4tul) or other taxa.
Sequence `DQ520100` from *Tremiscus helvelloides* was used as outgroup.

* Sequences were aligned using the MUSCLE algorithm [#edgar2004] and manually trimmed to a visually satisfying overlapping
* Ugene was used as main GUI, v. 37.0 [#okonechnikov2012]
* The Maximum Parsimony analysis was performed using TNT, v. 1.1 [#tnt], using the Tree Bisection and Reconnection algorhithm and with ten replics. 1000 trees were kept and a strict consensus tree was calculated. A bootstrap was performed on the tree with 200 replications to test the validity of the tree. Bootstrap values are displayed as node labels in the appendix tree
* The Bayesian analysis (MCMC) was performed using MrBayes, v. 3.2.7a [#huelsenbeck2001], using the Hasegawa-Kishino-Yano with a gamma rate heterogeneity among sites (`lset nst=2 rates=gamma;`). One million trees were generated and sampled each thousand, with four chains running. A final consensus tree was then calculated (see appendix)
* Trees were then visually edited with FigTree v. 1.4.4
* All parameters are available in the supplemental data, along with the files to reproduce the analysis.

## Multivariate analysis

Before proceeding with the multivariate analysis, sequences have been clustered into Operative Taxonomic Units (**OTU** hereafter), by using cd-hit v. 4.8.1 [#li2001]. This process yielded 210 OTUs, with the extremes of _Serendipitaceae_ having two OTUs only, and _Tulasnellaceae_ 52 OTUs. 
The database was then pivoted in a presence-absence matrix, and for further analysis it was splitted by family, so that each matrix only had all the OTUs for that single family, yielding 7 different matrices. This was necessary to test what internal variability each family has. Another matrix was obtained by grouping together all the observations from the same family, to test what the variability between the different families is. 
Principal Component Analysis (PCA hereafter) and Non-metric Multi Dimensional Scaling (NMDS hereafter) were performed on all the matrices by using the R package *vegan* [#dixon2003a], to understand both how do the OTUs from different families cluster together (if they do) and what environmental factors are most relevant. For the NMDS an Euclidean distance method was used.
Another matrix was obtained by using the single Families/OTUs as rows and removing the qualitaties orchid species variable. This was done to understand the  impact of the environmental variables only on each OTU, therefore trying to understand how different the realized niche (ie variance in the environmental variables) is between the groups.

![Number of OTUs from each family](images/clust.png) 

In the PCA and NMDS we have taken into account how each OTUs presence was influenced by environmental factors, such as climate and soil conditions. By using Species Distribution Models (SDM hereafter) we also take in account the presence of other OTUs, trying to disentangle the assembly processes that lead to the community as we can observe from the data we have.

A bayesian analysis based hierarchical model of species community (HMSC) [#ovaskainen2017] was performed by using the `Hmsc` package in R, v. 3.0.9 [#tikhonov2020, hmsc-r2021].
Three parallel chains were run, sampling every 500 results. Regression was done with a probit model (probability + unit), a non-linear model where the dependent variable can only take two variables, which was particularly apt for this dataset because of the binary nature of the presence-absence matrix.
Using this framework, a plot with the species responses to environmental covariates (beta parameters) was produced, with at least a 85% posterior probability of being positive (red) or negative (blue).
In addition, by using the presence-absence matrix, a correlation plot between the OTUs was established, looking at the positive associations with a statistical support of at least 85% shown in red and negative associations shown in blue.





