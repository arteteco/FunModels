# Scripts

* **filterFamilies.R** removes all the families which are not of our interest (in my case, likely not OMFs). **Outputs** `raw.csv`
* **createFasta.Rmd** generates a csv with 2 columns, GBAN and FASTA, and a fasta file, from the column with the sequencesID (in my dataset, that is `GBAN`).
* **cdhit.R** is basically a wrapper for the system command to cdhit. You need to have cdhit somewhere on your pc, and it outputs `data` and `data.clstr`
* **parsecluster.R** parses the cdhit raw output to yield a csv with 2 columns: `cluster` is the cluster name and `gene` is the genbank code
* **addOTUs.R** takes as input `data.clstr` and adds the OTUs to the raw original dataframe
* **presAbs.R** pivots the csv with the otus and returns a matrix of presence-absence with the coordinate in `lat` and `lon`
* **mergeEnvValues.R** merges the values of the presence-absence csvs. Each of the file has a last row
* **splitPresAbs.R** takes the complete presence absence matrix with the environmental variables and splits it by family
* **lumpPresAbs.R** lumps together OTUs of the same family by sampling point, so that if any OTU for that family was detected there it would give a `1`
* **NMDSSingle.R** makes an NMDS on a dataset and outputs the graph with the end result
* **NMDSLoop.R** loops all CSVs in a folder and does what `NMDSSingle.R` does (is the same script in a for loop)