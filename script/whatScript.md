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


# Analysis paramters

## MUSCLE





## MrBayes

This are the parameters used for the MrBayes run. The file can be found in `data/trees/7fam/mrbayes/7fam.nex`

```
set autoclose=yes nowarn=yes;
lset nst=2 rates=gamma;
unlink statefreq=(all) revmat=(all) shape=(all) pinvar=(all);
mcmcp ngen= 1000000 relburnin=yes burninfrac=0.25 printfreq=1000  samplefreq=1000 nchains=4 savebrlens=yes;
mcmc;
sumt;
```

## TNT

This are the parameters used for the TNT run. The file can be found at `data/trees/7fam/pars/istruzioni.tnt`

```
mxram 200 ;
nstates DNA ;
nstates NOGAPS ;
procedure data/data.tnt ;
log data/log.txt ;
hold 1000 ;
mult=replic 10;
bbreak=tbr ;
nelsen * ;
taxname= ;
export - data/result.nex ;
resample replications 200 ;
export - data/bs.nex ;
```

## CD-HIT

Full command can be found on `script/cdhit.R`
```
-c 0.98 -n 10 -l 11  -r 0 -G 1 -g 1 -b 20 -l 10 -s 0.0 -aL 0.0 -aS 0.0 -T 4 -M 32000
```
