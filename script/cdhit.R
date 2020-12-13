# I couldn't find a wrapper for cdhit as FindMyFriends kept crashing, 
# so I compiled it locally from source: https://github.com/weizhongli/cdhit

# I run the code as system, so you'll have to adapt the code to your OS and folders.
# I know it's a hack. If you have a better way PR is welcome
# The folder for cdhit is in a subfolder of the workind directory, called cdhit, should work ootb for linux/unix users


setwd("~/Computer/programmi/cd-hit")


# I'm running it with all default parameters except for the cutoff (-c) which is at 0.98
system("./cd-hit-est -i ~/tesi/data/init/7fam.fasta -d 0 -o ~/tesi/data/cluster/data -c 0.98 -n 10 -l 11  -r 0 -G 1 -g 1 -b 20 -l 10 -s 0.0 -aL 0.0 -aS 0.0 -T 4 -M 32000")



