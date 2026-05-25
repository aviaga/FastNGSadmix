#!/bin/bash
#$ -N run_admix
#$ -cwd
#$ -l h_data=4G,h_rt=02:00:00
#$ -pe shared 4
#$ -m bea
#$ -o admix.log
#$ -e admix.err

source /u/local/Modules/default/init/bash

mkdir -p results

fastngsadmix/fastNGSadmix/fastNGSadmix \
  -likes ANGSD_results/DRR608889_final.beagle.gz \
  -fname fastNGSadmix_ref.txt \
  -Nname nInd.txt \
  -out results/admixResults \
  -whichPops all
