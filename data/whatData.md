Description  of all data files in the folder. May still lack some of them

What I mean by 7 families is data filtered to only use seven familioes of fungi: 

# cluster/

Where the files for the clustering are


* **data.clstr** is the raw output of the cdhit run
* **cluster/cluster.csv** contains just 2 columns: cluster (as cluster1, cluster2 etc) and gene as genbank code
* **otus.csv** has the original dataset + the otus names (both as `cluster1` and as `seb1`, `seb2` ecc. This is the first 3 letters of the family name and an index number
* **7FamCluster.csv** is a data frame with 2 columns: cluster number and genbank code


# trees/

where all the fies for phylogenetic data is

## trees/7fam

Where the data for the seven families is



# init/
contains files that are often the starting point for other analysis or manipulation

* **raw.ods** is the manually created dataset
* **raw.csv** is a csv export of `complete.ods`
* **complete.fasta** is the fasta with all sequences (unfiltered)
* **CompleteGBANFAS.csv** has 2 columns: GBAN code and the corresponding FASTA for all the sequences (unfiltered)
* **filteres.csv** containes all the data from the raw dataset corresponding to the 7 families we selected
* **7famGBANFAS.csv** has two colums, GBAN and the corresponding FASTA for the 7 families
* **7fam.fasta** contains the FASTA for the 7 families

# matrix/

Here is the data used in  the presence/absence matrix and subsequent analysis

* **7famPresAbs.csv** is the presence absence csv for the 7 families. Doesn't include environmental variables
* **values.csv** is the presence absence csv for the 7 families and it includes the environmental variables
* **lump.csv** is a csv with environmental variables and all the OTUs of the same family are lumped together so that if there is a presence in that family in that sampling it will show a 1 regardless of the OTU


## matrix/env

containes the files for the environmental analysis

### matrix/env/points

Files with the environmental values. The name of the file (N, P, K etc) is the variable it adds to the original dataset.
* **values.csv** is the merging of all the values and the original data set


## matrix/split

each file has the presence absence matrix for that family only. The name is the identifier (`cer.csv` is for *Ceratobasidiaceae*, `ino.csv` for *Inocybaceae* etc)