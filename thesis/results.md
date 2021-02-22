## Phylogenetic analysis

The Bayesian analysis yielded low probability branches. Nonetheless, it correctly put together the families, with the only notable exception of the Serendipitaceae and Sebacinaceae which were nested separately. This makes sense though, as they are both Sebacinales and the Serendipitaceae were originally considered Ssebacinaceae B [#weiss2004] and were only recently given a new name and properly defined [#weiss2016].
The Maximum parsimony analysis gave similar results, with very low bootstrap support.



## PCA

The PCA analysis on the presence-absence matrix and the environmental variables combined showed how there is a substantial overlap of realized niche in the OTUs isolated from different orchids, without distinguishable clusters except for the Tulasnellaceae isolated from *Neottia cordata*.
In all cases, the variance was well explained by the first two components (>95% explained variance), with two variables bearing most of the loading: Maximum Precipitation of the wettest month and Potassium content in the soil.

The PCA done using the condensed family matrix yielded the same results, with the notable exception of the *Limodorum abortivum*, which showed a variance higher than expected ![PCA done on the condensed matrix of all seven OTUs families](images/lumpPCA.png)

## NMDS
The NMDS analysis on the single families seems to show that there is no highly relevant differentiation in the OTUs found in different orchid species, as the clustering wasn't really neat.
Again, Tulasnellaceae seem to be the exception, with more distinct groups for different orchid hosts; while this could be a bias caused by the higher number of samples, Ceratobasidiaceae and Theleophoraceae did not show this pattern even though the sample amount where roughly similar. This could point to a higher specialization of the Tulasnellaceae group, confirming previous observations [#dearnaley2007].
The NMDS comparing the families yielded only a partial overlapping clustering, which could indicate that different orchids may have different degrees of specialization and realized niche; *Limodorum abortivum* seemed to exibit the highest diversity, together with *Spiranthes spiralis*. 

Taking the Orchid species out of the NMDS analysis and only looking at how different OrM families clustered based on the environmental conditions showed an unexpected pattern. Russulaceae seemed to have a high variance, which points to a broader realized niche, compared to all other families; Tulasnellaceae, which is the most sampled and abundant OrM in the dataset, had less than half the variance and clustered in an area comparable to Sebacinaceae. 

![NMDS of the OrMs families considering environmental variables only](images/nmdsEnvMatrix.png)


## Hierarchical modelling of species communities

Joint species distribution modelling in HMSC. In the correlation between the families seemed like most families had a positive correlation, with two exceptions: Tulasnellaceae, who had no correlation (0) and Russulaceae, that had a negative correlation (-1). OTUs from the same families seemed, on the other hand, to have no correlation with the others, positive or negative. This stands true for all families but Ceratobasidiaceae, which had more complex correlations, both positive and negative. Whether this is phylogenetically related is to be understood. 

![HMSC correlation between the families, taking into account the presence-absence data](images/envCorrLump.png)

![HMSC correlation between the Ceratobasidiaceae OTUs](images/corrCer.png)

![HMSC correlation between the OTUs for Inocybaceae, Russulaceae, Sebacinaceae and Serendipitaceae](images/hmscfam01.png)

![HMSC correlation between the OTUs for Theleophoraceae and Tulasnellaceae](images/hmscfam02.png)

The second HMSC result is the correlation between the groups and the environmental variables.
The difference between the families wasn't very pronounced, and the most relevant parameter seemed the Minimum Temperature, which was highly correlated with most  families (only Tulasnellaceae had 0 correlation), confirming the importance of this environmental parameter in understanding the distribution of OrMs. Maximum precipitation was also invertedly correlated with most families, except for Russulaceae which showed a positive correlation. Of all the soil parameters, pH seemed the most important with a general inverse correlation (the lower the pH, the higher the presence of the OrM). 
The differences between OTUS from the same families were less clear-cut, showing different correlations for different OTUs in the same family, giving an idea of the diversity that can happen also at low taxonomic levels.
It's worthy of notice that Tulasnellaceae showed again the least amount of internal differences, with Ceratobasidiaceae being at the opposite side of the spectrum.

![HMSC taking into account the environmental variables for all the families](images/envCorrLump.png)

![HMSC taking into account the environmental variables for Ceratobasidiaceae, Inocybaceae, Russulaceae and Sebacinaceae OTUs](images/hmsc01.png)

![HMSC taking into account the environmental variables for Serendipitaceae, Theleophoraceae and Tulasnellaceae OTUs](images/hmsc02.png)





